---
name: sdd-init
description: Use when sdd-workflow detects a new uninitialised project — creates Constitutional Foundation (memory/constitution.md), docs/specs/ scaffold, and CLAUDE.md before any feature work begins
---

# SDD Init: Constitutional Foundation

Sets up the architectural constitution and project scaffold for a new SDD project.

**Announce at start:** "I'm using sdd-init to set up the Constitutional Foundation for this new SDD project."

<HARD-GATE>
Do NOT create any feature specs, plans, or code until the constitution is approved and the scaffold is written. This skill produces ONLY the project foundation.
</HARD-GATE>

## Overview

The Constitutional Foundation is a set of immutable architectural principles (Nine Articles) stored in `memory/constitution.md`. Every implementation plan in this project must pass gates derived from these articles. No feature work begins before the constitution exists.

## Step 1: Announce and Orient

Tell the user:
> "Before we begin feature work, I'll walk you through the Nine Articles of your project constitution — a set of architectural principles that will govern every implementation plan. We'll go through them one at a time. For each article, you can: accept the default, provide custom text, or mark it as not applicable. Nothing is written until you approve the final result."

## Step 2: Nine Articles Interactive Review

Present each Article in order. For each one:
1. Show the Article number and name
2. Show the default text (or stub for IV–VI)
3. Ask: "Accept this default, provide custom text, or mark as not applicable?"
4. Record the response — do NOT write files yet

---

### Article I: Library-First Principle

**Default:**
> Every feature in this project MUST begin its existence as a standalone library. No feature shall be implemented directly within application code without first being abstracted into a reusable library component with clear boundaries and minimal dependencies.

---

### Article II: CLI Interface Mandate

**Default:**
> All libraries MUST expose their functionality through a command-line interface. CLI interfaces must: accept text as input (via stdin, arguments, or files), produce text as output (via stdout), and support JSON format for structured data exchange. This enforces observability and testability.

---

### Article III: Test-First Imperative

**Default:**
> This is NON-NEGOTIABLE: All implementation MUST follow strict Test-Driven Development. No implementation code shall be written before: (1) tests are written, (2) tests are validated and approved, (3) tests are confirmed to FAIL (Red phase). Every implementation step in every plan must be preceded by a failing test step.

---

### Article IV: [NEEDS CLARIFICATION]

**Default stub:**
> [NEEDS CLARIFICATION: Define your fourth architectural principle here. Consider: how should research and technical context be gathered before implementation? (e.g. "All features with external dependencies require a research.md before planning begins")]

---

### Article V: [NEEDS CLARIFICATION]

**Default stub:**
> [NEEDS CLARIFICATION: Define your fifth architectural principle here. Consider: how should production feedback and operational learnings feed back into specifications? (e.g. "Production incidents must update the relevant spec before a fix is planned")]

---

### Article VI: [NEEDS CLARIFICATION]

**Default stub:**
> [NEEDS CLARIFICATION: Define your sixth architectural principle here. Consider: how should exploration and branching be handled? (e.g. "Multiple implementation approaches may be generated from the same spec for comparison before committing")]

---

### Article VII: Simplicity Gate

**Default:**
> Maximum 3 major components for any initial implementation. No future-proofing — build only what the current spec requires. Any additional complexity requires documented justification in the plan's Complexity Tracking section. Adding a new dependency requires explicit rationale tied to a spec requirement.

---

### Article VIII: Anti-Abstraction Gate

**Default:**
> Use framework features directly rather than wrapping them. Maintain a single, canonical model representation — no parallel DTO/entity/view-model chains. Every abstraction layer must be justified by a concrete spec requirement, not anticipated future need.

---

### Article IX: Integration-First Testing

**Default:**
> Tests MUST use realistic environments: prefer real databases over mocks, use actual service instances over stubs. Contract tests are mandatory before any implementation code. Integration tests take precedence over isolated unit tests. Mock only what cannot be made real within the test environment.

---

## Step 3: Confirm Amendment Process

After all Nine Articles are reviewed, present Section 4.2:

> **Section 4.2 — Amendment Process**
> Modifications to this constitution require:
> - Explicit documentation of the rationale for change
> - Review and approval by project maintainers
> - Backwards compatibility assessment

Ask: "Does this amendment process work for your project, or would you like to adjust it?"

## Step 4: Final Approval Gate

Present a summary of all Nine Articles as the user approved them, then ask:

> "Here is your constitution as approved. Shall I write it to `memory/constitution.md` and create the project scaffold?"

**Do NOT proceed to Step 5 until the user explicitly says yes.**

If the user says no or requests changes: return to Step 2 for the relevant articles.

## Step 5: Scaffold Creation

Create files in this order. Announce each file before creating it.

### 5.1 Create memory/constitution.md

Announce: "Creating `memory/constitution.md` with your approved Nine Articles."

Create `memory/` directory if it does not exist.

Write `memory/constitution.md`:

```markdown
# Project Constitution

> These principles are immutable. Every implementation plan must pass gates derived from them.
> To amend, follow Section 4.2.

---

## Article I: Library-First Principle

{{approved text}}

---

## Article II: CLI Interface Mandate

{{approved text}}

---

## Article III: Test-First Imperative

{{approved text}}

---

## Article IV

{{approved text or [NEEDS CLARIFICATION] stub}}

---

## Article V

{{approved text or [NEEDS CLARIFICATION] stub}}

---

## Article VI

{{approved text or [NEEDS CLARIFICATION] stub}}

---

## Article VII: Simplicity Gate

{{approved text}}

---

## Article VIII: Anti-Abstraction Gate

{{approved text}}

---

## Article IX: Integration-First Testing

{{approved text}}

---

## Section 4.2: Amendment Process

{{approved amendment process text}}
```

### 5.2 Create docs/specs/.gitkeep

Announce: "Creating `docs/specs/` directory for feature specifications."

Create `docs/specs/.gitkeep` (empty file so the directory is tracked by git).

### 5.3 Create or update CLAUDE.md

**If `CLAUDE.md` does not exist:**
Announce: "Creating `CLAUDE.md` with SDD workflow instructions."

Write `CLAUDE.md` with:
- Project name (infer from directory name; ask user if ambiguous)
- Reference to `memory/constitution.md` as the architectural authority
- The SDD skill map (condensed):

```markdown
# <Project Name>

## Architecture

Governed by [Project Constitution](memory/constitution.md). All implementation plans must pass gates derived from the Nine Articles. Constitution amendments require explicit approval per Section 4.2.

## SDD Workflow

| Situation | Skill |
|-----------|-------|
| Fuzzy idea | `sdd-brainstorm` |
| Clear idea | `sdd-specify` |
| Tech investigation needed | `sdd-research` |
| Spec approved | `sdd-plan` |
| Plan approved | `sdd-tasks` |
| Tasks ready | `sdd-execute` |
| Verify spec alignment | `sdd-review` |

**Hard Gates:**
- NO PLAN without an approved spec
- NO TASKS without a plan
- NO CODE without a prior failing test
- NO COMPLETION CLAIM without fresh verification evidence
```

**If `CLAUDE.md` already exists:**
Announce: "I'd like to append SDD workflow instructions to your existing `CLAUDE.md`. Here is what I will add:" — show the exact text to be appended.
Get explicit approval before appending.

## Step 6: Handoff

After all scaffold files are created, report:

> "Constitutional Foundation complete. Created:
> - `memory/constitution.md` — Nine Articles governing all implementation plans
> - `docs/specs/` — ready for feature specifications
> - `CLAUDE.md` — SDD workflow instructions
>
> Returning to your original request now."

Then return control to `sdd-workflow` to route the user's original request.

## Abort Handling

If the user exits the flow at any point before Step 5 begins:
- Write NO files
- Say: "Init aborted. No files were created. Run `sdd-workflow` again to restart the constitutional setup."

## Error Scenarios

| Scenario | Handling |
|----------|----------|
| User aborts during Article review | No files written; show abort message |
| `memory/constitution.md` exists but `docs/specs/` does not | Skip Step 5.1; create `docs/specs/.gitkeep` only; warn: "constitution already exists, creating docs/specs/ only" |
| `CLAUDE.md` exists but has no SDD content | Append SDD section after showing diff and getting approval |
