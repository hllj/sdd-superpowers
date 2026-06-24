# Implementation Plan: Feature 015 — Skills Frontmatter and Description Refinement

**Spec:** `docs/specs/015-skills-frontmatter-description-refinement/spec.md`
**Branch:** `015-skills-frontmatter-description-refinement`

---

## Goal

Apply four categories of targeted edits to 15 skill SKILL.md files: fix five CSO-violating descriptions, add `user-invocable: false` to sdd-workflow, add `allowed-tools` to 13 skills, and repair two content bugs. No skill logic, body content, or workflow steps change.

---

## Architecture

No new files. No new abstractions. Pure text edits to existing files.

**All changes are atomic per file** — when a file receives multiple changes (e.g., description fix + frontmatter addition), all changes to that file land in a single edit.

---

## Tech Stack

- Markdown + YAML frontmatter (Claude Code `Edit` tool)
- Bash `grep` for verification of each change

---

## File Change Map

| File | Changes |
|------|---------|
| `skills/sdd-workflow/SKILL.md` | Description fix (FR-1) + `user-invocable: false` (FR-2) |
| `skills/sdd-brainstorm/SKILL.md` | Description fix (FR-1) + `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-tasks/SKILL.md` | Description fix (FR-1) + `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-spec-update/SKILL.md` | Description fix (FR-1) only |
| `skills/verification-before-completion/SKILL.md` | Description fix (FR-1) + `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-specify/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-plan/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-research/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-review/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-init/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) |
| `skills/sdd-execute/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) + table bug fix (FR-4) |
| `skills/using-git/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) |
| `skills/systematic-debugging/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) + heading fix (FR-4) |
| `skills/requesting-code-review/SKILL.md` | `allowed-tools: Bash, Read` (FR-3) |
| `skills/test-driven-development/SKILL.md` | `allowed-tools: Bash` (FR-3, Bash only per AC-3.3) |

---

## Phases

### Phase 1 — Description CSO Fixes + sdd-workflow Frontmatter

Five descriptions contain workflow leaks or process details. All are fixed in this phase. sdd-workflow also receives `user-invocable: false` in the same edit.

**Files:** `sdd-workflow`, `sdd-brainstorm`, `sdd-tasks`, `sdd-spec-update`, `verification-before-completion`

#### Phase 1, Task A — sdd-workflow: description + user-invocable

**File:** `skills/sdd-workflow/SKILL.md`

**Current frontmatter:**
```yaml
---
name: sdd-workflow
description: Use when starting any conversation in an SDD project — establishes skill invocation order
---
```

**New frontmatter:**
```yaml
---
name: sdd-workflow
description: Use when starting any conversation in an SDD project
user-invocable: false
---
```

**Change rationale:**
- Removes "establishes skill invocation order" — describes what the skill does, not when to use it (CSO violation, AC-1.1)
- Adds `user-invocable: false` — hides from `/` menu; auto-invocation from CLAUDE.md is unaffected (AC-2.1)

**Verification:**
```bash
grep -A 3 "^---" skills/sdd-workflow/SKILL.md | head -6
# Expected: description line ends at "SDD project", user-invocable: false present
```

#### Phase 1, Task B — sdd-brainstorm: description fix

**File:** `skills/sdd-brainstorm/SKILL.md`

**Current:**
```yaml
description: Use when an idea is fuzzy, exploratory, or has competing approaches — before sdd-specify, when you need to explore 2-3 directions and agree on a design first
```

**New:**
```yaml
description: Use when an idea is fuzzy, exploratory, or has competing approaches that need design exploration before specification
```

**Change rationale:** "when you need to explore 2-3 directions and agree on a design first" describes the skill's process, not the triggering situation (AC-1.2).

**Verification:**
```bash
grep "^description:" skills/sdd-brainstorm/SKILL.md
# Expected: no mention of "2-3 directions" or "agree on a design"
```

#### Phase 1, Task C — sdd-tasks: description fix

**File:** `skills/sdd-tasks/SKILL.md`

**Current:**
```yaml
description: Use when an implementation plan exists and needs to become an ordered, checkboxed task list — after sdd-plan and before sdd-execute
```

**New:**
```yaml
description: Use when an implementation plan is approved and needs to be broken down into executable tasks
```

**Change rationale:** "ordered, checkboxed task list" describes the output (AC-1.3); "after sdd-plan and before sdd-execute" is workflow sequencing that belongs in the skill body, not the description (AC-1.3).

**Verification:**
```bash
grep "^description:" skills/sdd-tasks/SKILL.md
# Expected: no mention of "checkboxed", "after sdd-plan", or "before sdd-execute"
```

#### Phase 1, Task D — sdd-spec-update: description fix

**File:** `skills/sdd-spec-update/SKILL.md`

**Current:**
```yaml
description: Use when a user describes a change, addition, or correction to an in-progress feature — after a spec exists but before or during implementation — to assess impact, version the spec, and propagate changes downstream
```

**New:**
```yaml
description: Use when a user describes a change, addition, or correction to an approved spec — during or before implementation
```

**Change rationale:** "to assess impact, version the spec, and propagate changes downstream" summarises the skill's workflow (AC-1.4).

**Verification:**
```bash
grep "^description:" skills/sdd-spec-update/SKILL.md
# Expected: no mention of "assess impact", "version the spec", or "propagate changes"
```

#### Phase 1, Task E — verification-before-completion: description fix

**File:** `skills/verification-before-completion/SKILL.md`

**Current:**
```yaml
description: Use when about to claim work is complete, fixed, or passing — run the verification command and read the output before making any success claim
```

**New:**
```yaml
description: Use when about to claim work is complete, fixed, or passing
```

**Change rationale:** "run the verification command and read the output before making any success claim" is a process instruction that belongs in the skill body, not the description (AC-1.5).

**Verification:**
```bash
grep "^description:" skills/verification-before-completion/SKILL.md
# Expected: description ends at "passing"
```

**Phase 1 completion check:**
```bash
grep "^description:" skills/sdd-workflow/SKILL.md skills/sdd-brainstorm/SKILL.md skills/sdd-tasks/SKILL.md skills/sdd-spec-update/SKILL.md skills/verification-before-completion/SKILL.md
grep "user-invocable" skills/sdd-workflow/SKILL.md
```

---

### Phase 2 — allowed-tools Frontmatter

Add `allowed-tools` to 13 skills that directly invoke Bash or Read during execution. Each edit inserts the field into the existing YAML frontmatter block — after `description`, before the closing `---`.

**Pattern for all Phase 2 edits:**

Skills receiving `allowed-tools: Bash, Read` (AC-3.1):
`sdd-specify`, `sdd-plan`, `sdd-research`, `sdd-review`, `sdd-init`, `sdd-execute`, `using-git`, `systematic-debugging`, `requesting-code-review`
and the three skills that also had description fixes in Phase 1:
`sdd-brainstorm`, `sdd-tasks`, `verification-before-completion`

Skill receiving `allowed-tools: Bash` only (AC-3.3):
`test-driven-development`

Skills NOT receiving allowed-tools (AC-3.2):
`sdd-workflow` (gets `user-invocable: false` instead), `subagent-driven-development`, `dispatching-parallel-agents`, `receiving-code-review`, `finishing-a-development-branch`, `sdd-spec-update`

#### Phase 2, Task A — sdd-brainstorm (combined with Phase 1 change — single edit)

Already handled in Phase 1, Task B. The edit adds both the description fix and `allowed-tools: Bash, Read` in one operation.

**Final frontmatter:**
```yaml
---
name: sdd-brainstorm
description: Use when an idea is fuzzy, exploratory, or has competing approaches that need design exploration before specification
allowed-tools: Bash, Read
---
```

#### Phase 2, Task B — sdd-tasks (combined with Phase 1 change — single edit)

Already handled in Phase 1, Task C. The edit adds both the description fix and `allowed-tools: Bash, Read` in one operation.

**Final frontmatter:**
```yaml
---
name: sdd-tasks
description: Use when an implementation plan is approved and needs to be broken down into executable tasks
allowed-tools: Bash, Read
---
```

#### Phase 2, Task C — verification-before-completion (combined with Phase 1 change — single edit)

Already handled in Phase 1, Task E. The edit adds both the description fix and `allowed-tools: Bash, Read` in one operation.

**Final frontmatter:**
```yaml
---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing
allowed-tools: Bash, Read
---
```

#### Phase 2, Task D — sdd-specify

**File:** `skills/sdd-specify/SKILL.md`

**Current frontmatter:**
```yaml
---
name: sdd-specify
description: Use when a user describes a new feature, idea, or problem without an existing spec — before any planning, research, or code
---
```

**New frontmatter:**
```yaml
---
name: sdd-specify
description: Use when a user describes a new feature, idea, or problem without an existing spec — before any planning, research, or code
allowed-tools: Bash, Read
---
```

#### Phase 2, Task E — sdd-plan

**File:** `skills/sdd-plan/SKILL.md`

**Current frontmatter:**
```yaml
---
name: sdd-plan
description: Use when a feature spec exists and needs to become a technical implementation plan
---
```

**New frontmatter:**
```yaml
---
name: sdd-plan
description: Use when a feature spec exists and needs to become a technical implementation plan
allowed-tools: Bash, Read
---
```

#### Phase 2, Task F — sdd-research

**File:** `skills/sdd-research/SKILL.md`

**Current frontmatter:**
```yaml
---
name: sdd-research
description: Use when a spec has unresolved technology choices, performance targets, security requirements, or external integrations that need investigation before planning
---
```

**New frontmatter:**
```yaml
---
name: sdd-research
description: Use when a spec has unresolved technology choices, performance targets, security requirements, or external integrations that need investigation before planning
allowed-tools: Bash, Read
---
```

#### Phase 2, Task G — sdd-review

**File:** `skills/sdd-review/SKILL.md`

**Current frontmatter:**
```yaml
---
name: sdd-review
description: Use when a spec needs a completeness check before planning, or when implementation claims to be complete and needs spec-alignment validation
---
```

**New frontmatter:**
```yaml
---
name: sdd-review
description: Use when a spec needs a completeness check before planning, or when implementation claims to be complete and needs spec-alignment validation
allowed-tools: Bash, Read
---
```

#### Phase 2, Task H — sdd-init

**File:** `skills/sdd-init/SKILL.md`

**Current frontmatter:**
```yaml
---
name: sdd-init
description: Use when starting a new project that has no CLAUDE.md and no docs/specs/ directory
---
```

**New frontmatter:**
```yaml
---
name: sdd-init
description: Use when starting a new project that has no CLAUDE.md and no docs/specs/ directory
allowed-tools: Bash, Read
---
```

#### Phase 2, Task I — sdd-execute (frontmatter only; bug fix in Phase 3)

**File:** `skills/sdd-execute/SKILL.md`

**Current frontmatter:**
```yaml
---
name: sdd-execute
description: Use when a tasks.md exists and implementation should begin
---
```

**New frontmatter:**
```yaml
---
name: sdd-execute
description: Use when a tasks.md exists and implementation should begin
allowed-tools: Bash, Read
---
```

#### Phase 2, Task J — using-git

**File:** `skills/using-git/SKILL.md`

**Current frontmatter:**
```yaml
---
name: using-git
description: Use when any git operation is needed in an SDD project — branch creation, commits, merge commit validation, or showing the convention
---
```

**New frontmatter:**
```yaml
---
name: using-git
description: Use when any git operation is needed in an SDD project — branch creation, commits, merge commit validation, or showing the convention
allowed-tools: Bash, Read
---
```

#### Phase 2, Task K — systematic-debugging (frontmatter only; heading fix in Phase 3)

**File:** `skills/systematic-debugging/SKILL.md`

**Current frontmatter:**
```yaml
---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
---
```

**New frontmatter:**
```yaml
---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
allowed-tools: Bash, Read
---
```

#### Phase 2, Task L — requesting-code-review

**File:** `skills/requesting-code-review/SKILL.md`

**Current frontmatter:**
```yaml
---
name: requesting-code-review
description: Use when completing a development phase or major feature, and before merging to main
---
```

**New frontmatter:**
```yaml
---
name: requesting-code-review
description: Use when completing a development phase or major feature, and before merging to main
allowed-tools: Bash, Read
---
```

#### Phase 2, Task M — test-driven-development

**File:** `skills/test-driven-development/SKILL.md`

**Current frontmatter:**
```yaml
---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
---
```

**New frontmatter:**
```yaml
---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
allowed-tools: Bash
---
```

**Phase 2 completion check:**
```bash
for f in skills/sdd-specify/SKILL.md skills/sdd-plan/SKILL.md skills/sdd-research/SKILL.md skills/sdd-review/SKILL.md skills/sdd-init/SKILL.md skills/sdd-execute/SKILL.md skills/using-git/SKILL.md skills/systematic-debugging/SKILL.md skills/requesting-code-review/SKILL.md skills/sdd-brainstorm/SKILL.md skills/sdd-tasks/SKILL.md skills/verification-before-completion/SKILL.md; do echo "=== $f ==="; grep "allowed-tools" "$f"; done
grep "allowed-tools" skills/test-driven-development/SKILL.md
# For skills that should NOT have it:
grep "allowed-tools" skills/sdd-workflow/SKILL.md skills/sdd-spec-update/SKILL.md skills/subagent-driven-development/SKILL.md skills/dispatching-parallel-agents/SKILL.md skills/receiving-code-review/SKILL.md skills/finishing-a-development-branch/SKILL.md
# Expected: no output (allowed-tools absent from these 6 skills)
```

---

### Phase 3 — Content Bug Fixes

Two isolated content bugs are repaired. No frontmatter or description changes in this phase.

#### Phase 3, Task A — sdd-execute: fix broken integration table

**File:** `skills/sdd-execute/SKILL.md`

**Problem:** A `> **Note:**` block appears between table rows, breaking the Markdown table. The rows after the note render outside the table. The note text must be moved below the table as a prose paragraph.

**Current content (lines 80–95):**
```markdown
## Integration

Required sub-skills during execution:

| When | Sub-skill |
|------|-----------|
| Executing tasks in current session | `sdd-superpowers:subagent-driven-development` |
| Dispatching a parallel task group (2+ tasks) | `sdd-superpowers:dispatching-parallel-agents` |
| Per-task commits | `sdd-superpowers:using-git` |

> **Note:** `sdd-superpowers:test-driven-development` is mandated for **implementer subagents** dispatched by `subagent-driven-development` — not invoked directly by the controller.
| Phase boundary | `sdd-superpowers:requesting-code-review` |
| Implementing fixes after review feedback | `sdd-superpowers:receiving-code-review` |
| Task fails or behavior unexpected | `sdd-superpowers:systematic-debugging` |
| About to claim done | `sdd-superpowers:verification-before-completion` |
| All tasks complete | `sdd-superpowers:sdd-review` (required before merge) |
| sdd-review passes | `sdd-superpowers:finishing-a-development-branch` |
```

**New content:**
```markdown
## Integration

Required sub-skills during execution:

| When | Sub-skill |
|------|-----------|
| Executing tasks in current session | `sdd-superpowers:subagent-driven-development` |
| Dispatching a parallel task group (2+ tasks) | `sdd-superpowers:dispatching-parallel-agents` |
| Per-task commits | `sdd-superpowers:using-git` |
| Phase boundary | `sdd-superpowers:requesting-code-review` |
| Implementing fixes after review feedback | `sdd-superpowers:receiving-code-review` |
| Task fails or behavior unexpected | `sdd-superpowers:systematic-debugging` |
| About to claim done | `sdd-superpowers:verification-before-completion` |
| All tasks complete | `sdd-superpowers:sdd-review` (required before merge) |
| sdd-review passes | `sdd-superpowers:finishing-a-development-branch` |

> **Note:** `sdd-superpowers:test-driven-development` is mandated for **implementer subagents** dispatched by `subagent-driven-development` — not invoked directly by the controller.
```

**Verification:**
```bash
grep -n "Note:" skills/sdd-execute/SKILL.md
# Expected: note appears AFTER the last table row (finishing-a-development-branch)
grep -c "^|" skills/sdd-execute/SKILL.md
# Expected: table row count is unchanged (same rows, just reordered without break)
```

#### Phase 3, Task B — systematic-debugging: fix heading capitalisation

**File:** `skills/systematic-debugging/SKILL.md`

**Current:**
```markdown
## your human partner's Signals You're Doing It Wrong
```

**New:**
```markdown
## Your Human Partner's Signals You're Doing It Wrong
```

**Verification:**
```bash
grep "## [Yy]our" skills/systematic-debugging/SKILL.md
# Expected: "## Your Human Partner's Signals You're Doing It Wrong" (capital Y and H)
```

**Phase 3 completion check:**
```bash
grep -n "Note:" skills/sdd-execute/SKILL.md
grep "## [Yy]our" skills/systematic-debugging/SKILL.md
```

---

## Self-Review

**Spec coverage:**

| FR | Phases covering it |
|----|-------------------|
| FR-1 (description CSO fixes) | Phase 1, Tasks A–E |
| FR-2 (user-invocable: false) | Phase 1, Task A |
| FR-3 (allowed-tools) | Phase 2, Tasks A–M |
| FR-4 (content bugs) | Phase 3, Tasks A–B |

All FRs covered. No gaps.

**Placeholder scan:** No TBD, TODO, or vague steps. Every edit shows exact before/after content. Every verification step has an exact command and expected output.

**Consistency:** Phase 1 Tasks B, C, E note that their allowed-tools additions are handled in the same edit — this is flagged explicitly to avoid double-editing the same file.

---

## Execution Handoff

Plan complete. Next: run `sdd-superpowers:sdd-tasks` to generate the executable task list.
