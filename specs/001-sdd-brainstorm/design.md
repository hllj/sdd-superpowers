# Design: sdd-brainstorm + Smart Routing

**Date:** 2026-04-16
**Status:** Approved

---

## Problem

The SDD workflow has a hard entry point: `sdd-specify` assumes the user already knows what they want to build well enough to answer structured PRD questions. When ideas are fuzzy — scope unclear, approach undecided, multiple competing directions — `sdd-specify` produces incomplete or over-constrained specs. Users need a collaborative exploration phase before formal specification.

## Goal

Add an upstream brainstorming phase to the SDD workflow that:
- Handles fuzzy, exploratory ideas through collaborative dialogue
- Proposes 2-3 concrete approaches with trade-offs before committing
- Validates the design via a spec-reviewer subagent before handing to `sdd-specify`
- Is triggered automatically when signals of fuzziness are detected, or explicitly on request

## Non-Goals

- Replacing `sdd-specify` for clear, well-defined ideas
- Producing implementation plans (that remains `sdd-plan`'s job)
- Adding a visual companion (deferred)

---

## Architecture

```
sdd-workflow (router)
    │
    ├─ fuzzy / explicit / auto-signals
    │   └─► sdd-brainstorm
    │           → one-question-at-a-time dialogue
    │           → 2-3 approaches with trade-offs
    │           → present design in sections, user approves
    │           → write specs/NNN-feature/design.md
    │           → dispatch spec-reviewer subagent (loop until approved)
    │           → user reviews design.md
    │           └─► sdd-specify (fast-path with design.md)
    │                   → skip dialogue, formalize design.md → spec.md
    │                   └─► sdd-plan → ...
    │
    └─ clear idea / no ambiguity
        └─► sdd-specify (direct path)
                → structured PRD dialogue
                └─► spec.md → sdd-plan → ...
```

---

## Component 1: `sdd-brainstorm` Skill

### Source
Copied from `superpowers:brainstorming` with three targeted adaptations.

### Adaptations from superpowers:brainstorming

| Original behavior | SDD adaptation |
|-------------------|----------------|
| Saves to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md` | Saves to `specs/NNN-<feature-slug>/design.md` |
| Terminal state: invoke `writing-plans` | Terminal state: invoke `sdd-specify` with design doc path |
| Generic spec reviewer | SDD-specific reviewer (checks: YAGNI, scope decomposition, approach justification) |

### Preserved from superpowers:brainstorming (unchanged)

- One question at a time (never multiple)
- Prefer multiple-choice questions
- Explore scope first — flag multi-subsystem projects immediately for decomposition
- Propose 2-3 approaches with trade-offs before writing design
- Present design in sections, get approval after each section
- Spec-reviewer subagent loop (max 3 iterations, then surface to human)
- User review gate after spec-reviewer passes
- YAGNI ruthlessly — remove unrequested features from all designs
- HARD-GATE: no implementation until design is approved

### Output

`specs/NNN-<feature-slug>/design.md` — written with this exact section structure so `sdd-specify` can reliably extract from it:

```markdown
# Design: <Feature Name>

**Date:** YYYY-MM-DD
**Feature:** NNN-<feature-slug>

## Problem

<What problem this solves and who experiences it.>

## Chosen Approach

<The approach selected from the 2-3 options explored, written out concretely.>

## Trade-offs & Rationale

<Why this approach was chosen over the alternatives. What was given up.>

## Key Design Decisions

<Specific decisions made during brainstorming that constrain implementation.>

## Out of Scope

<What was explicitly discussed and excluded.>
```

This is NOT a formal PRD — that is produced by `sdd-specify` from this design.

**Feature numbering:** `sdd-brainstorm` scans `specs/` for the next available number at the start, proposes it to the user, and creates the directory only after the user approves the final design. This prevents locking a feature number on a rejected design.

### Supporting File

`skills/sdd-brainstorm/spec-document-reviewer-prompt.md` — prompt template for dispatching the spec-reviewer subagent.

---

## Component 2: `sdd-specify` Fast-Path

### Change

In `sdd-specify`'s process flow, **Step 1** currently scans the `specs/` directory for existing feature numbers. Extend this step to also check whether `specs/NNN-<feature-slug>/design.md` exists in the target directory.

**Detection logic (added to Step 1):**

```
1. Scan specs/ for next available feature number (existing)
2. NEW: Check if specs/NNN-<feature-slug>/design.md exists
   - If YES → validate design.md:
       * Does it contain all required sections (Problem, Chosen Approach, Trade-offs,
         Key Design Decisions, Out of Scope)?
       * Is each section non-empty?
       If valid   → fast-path: skip Steps 2–3, read design.md, extract each section,
                    formalize into spec.md, jump to Step 4
       If invalid → warn user: "Found design.md but it appears incomplete.
                    Proceeding with normal spec dialogue."
                    Continue with normal path.
   - If NO  → normal path: proceed with Steps 2–3 as usual
```

This is a prompt-level conditional branch. The skill reads the file and follows the appropriate sub-flow based on what it finds.

### What stays the same

- Spec template and output format unchanged
- Self-review, branch creation, and handoff steps unchanged
- Fast-path still produces the same `spec.md` artifact as the normal path

---

## Component 3: `sdd-workflow` Routing Update

### Explicit triggers → suggest `sdd-brainstorm`

User language: "brainstorm", "explore", "thinking about", "not sure", "what if we", "some kind of", "a better way to"

### Auto-detected signals → suggest `sdd-brainstorm`

- No concrete user action or outcome mentioned ("I want to improve X" with no specifics)
- Multiple competing directions in one message ("should we use A or B or maybe C")
- Vague qualifiers present: "some kind of", "something like", "a better way to", "not sure how"
- Scope spans multiple subsystems (see blocking case below)

### Default → `sdd-specify` directly

When the idea contains: concrete user action, clear outcome, no competing approaches mentioned.

### Routing behavior

Two distinct cases:

**Case 1 — Fuzziness signals only (no scope problem)**
`sdd-workflow` asks (advisory, user can override):
> "Your idea sounds exploratory. Would you like to brainstorm approaches first (`sdd-brainstorm`), or do you have a clear direction and want to go straight to spec (`sdd-specify`)?"

User may choose either path. If they choose `sdd-specify` despite fuzziness signals, proceed — they are in control.

**Case 2 — Multi-subsystem scope detected (blocking)**
If the idea spans 2+ independent subsystems (e.g. "build a platform with auth, billing, and notifications"), `sdd-workflow` **blocks both paths** until decomposition happens:
> "This idea spans multiple independent subsystems. Before specifying or brainstorming, we need to decompose it into separate features. Let's identify the independent pieces — which one should we tackle first?"

Decomposition is not optional. Neither `sdd-brainstorm` nor `sdd-specify` should be invoked on a multi-subsystem idea without first agreeing on which subsystem is in scope. This mirrors the same rule in `superpowers:brainstorming`.

---

## Files to Create / Modify

| Action | File |
|--------|------|
| Create | `skills/sdd-brainstorm/SKILL.md` |
| Create | `skills/sdd-brainstorm/spec-document-reviewer-prompt.md` |
| Modify | `skills/sdd-specify/SKILL.md` — add fast-path detection |
| Modify | `skills/sdd-workflow/SKILL.md` — add routing signals + sdd-brainstorm to skill map |

---

## Acceptance Criteria

- [ ] `sdd-brainstorm` asks one question at a time and proposes 2-3 approaches before writing design.md
- [ ] `sdd-brainstorm` dispatches spec-reviewer subagent after writing; loops until approved or 3 iterations
- [ ] `sdd-brainstorm` terminal state invokes `sdd-specify` (not writing-plans)
- [ ] `sdd-specify` detects design.md and skips dialogue when present
- [ ] `sdd-workflow` routes to `sdd-brainstorm` on explicit request OR auto-detected fuzziness signals
- [ ] `sdd-workflow` asks the user before routing (does not silently pick)
- [ ] All new skill descriptions follow the `writing-skills` convention: start with "Use when...", describe only triggering conditions, never summarize the skill's workflow (per `superpowers:writing-skills` Claude Search Optimization rules)
