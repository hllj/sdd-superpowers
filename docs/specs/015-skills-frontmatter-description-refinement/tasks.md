# Task List: Feature 015 — Skills Frontmatter and Description Refinement

**Spec:** `docs/specs/015-skills-frontmatter-description-refinement/spec.md`
**Plan:** `docs/specs/015-skills-frontmatter-description-refinement/plan.md`
**Branch:** `015-skills-frontmatter-description-refinement`

---

## Setup

### Task 0 — Create feature branch and doc-first commit

```bash
git checkout -b 015-skills-frontmatter-description-refinement
git add docs/specs/015-skills-frontmatter-description-refinement/
git commit -m "docs(015): add spec and plan for skills frontmatter and description refinement"
```

Expected: branch created, commit on new branch.

---

## Phase 1 — Description CSO Fixes + sdd-workflow Frontmatter

All Phase 1 tasks touch different files. [P] = safe to run concurrently.

---

### [P] Task 1 — sdd-workflow: fix description + add user-invocable: false

**File:** `skills/sdd-workflow/SKILL.md`

**RED — verify problem exists:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-workflow/SKILL.md
```
Expected: `description: Use when starting any conversation in an SDD project — establishes skill invocation order`

```bash
grep "user-invocable" /Users/hllj/Projects/sdd-superpowers/skills/sdd-workflow/SKILL.md
```
Expected: no output (field absent)

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-workflow
description: Use when starting any conversation in an SDD project — establishes skill invocation order
---
```

New:
```
---
name: sdd-workflow
description: Use when starting any conversation in an SDD project
user-invocable: false
---
```

**GREEN — verify fix:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-workflow/SKILL.md
```
Expected: `description: Use when starting any conversation in an SDD project`

```bash
grep "user-invocable" /Users/hllj/Projects/sdd-superpowers/skills/sdd-workflow/SKILL.md
```
Expected: `user-invocable: false`

---

### [P] Task 2 — sdd-brainstorm: fix description + add allowed-tools

**File:** `skills/sdd-brainstorm/SKILL.md`

**RED — verify problem exists:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-brainstorm/SKILL.md
```
Expected: contains "explore 2-3 directions and agree on a design first"

```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-brainstorm/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-brainstorm
description: Use when an idea is fuzzy, exploratory, or has competing approaches — before sdd-specify, when you need to explore 2-3 directions and agree on a design first
---
```

New:
```
---
name: sdd-brainstorm
description: Use when an idea is fuzzy, exploratory, or has competing approaches that need design exploration before specification
allowed-tools: Bash, Read
---
```

**GREEN — verify fix:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-brainstorm/SKILL.md
```
Expected: `description: Use when an idea is fuzzy, exploratory, or has competing approaches that need design exploration before specification`

```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-brainstorm/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 3 — sdd-tasks: fix description + add allowed-tools

**File:** `skills/sdd-tasks/SKILL.md`

**RED — verify problem exists:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-tasks/SKILL.md
```
Expected: contains "checkboxed task list" and "after sdd-plan and before sdd-execute"

```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-tasks/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-tasks
description: Use when an implementation plan exists and needs to become an ordered, checkboxed task list — after sdd-plan and before sdd-execute
---
```

New:
```
---
name: sdd-tasks
description: Use when an implementation plan is approved and needs to be broken down into executable tasks
allowed-tools: Bash, Read
---
```

**GREEN — verify fix:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-tasks/SKILL.md
```
Expected: `description: Use when an implementation plan is approved and needs to be broken down into executable tasks`

```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-tasks/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 4 — sdd-spec-update: fix description

**File:** `skills/sdd-spec-update/SKILL.md`

**RED — verify problem exists:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-spec-update/SKILL.md
```
Expected: contains "to assess impact, version the spec, and propagate changes downstream"

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-spec-update
description: Use when a user describes a change, addition, or correction to an in-progress feature — after a spec exists but before or during implementation — to assess impact, version the spec, and propagate changes downstream
---
```

New:
```
---
name: sdd-spec-update
description: Use when a user describes a change, addition, or correction to an approved spec — during or before implementation
---
```

**GREEN — verify fix:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-spec-update/SKILL.md
```
Expected: `description: Use when a user describes a change, addition, or correction to an approved spec — during or before implementation`

---

### [P] Task 5 — verification-before-completion: fix description + add allowed-tools

**File:** `skills/verification-before-completion/SKILL.md`

**RED — verify problem exists:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/verification-before-completion/SKILL.md
```
Expected: contains "run the verification command and read the output before making any success claim"

```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/verification-before-completion/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing — run the verification command and read the output before making any success claim
---
```

New:
```
---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing
allowed-tools: Bash, Read
---
```

**GREEN — verify fix:**
```bash
grep "^description:" /Users/hllj/Projects/sdd-superpowers/skills/verification-before-completion/SKILL.md
```
Expected: `description: Use when about to claim work is complete, fixed, or passing`

```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/verification-before-completion/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### Task 6 — Verify all Phase 1 changes

```bash
grep "^description:" \
  /Users/hllj/Projects/sdd-superpowers/skills/sdd-workflow/SKILL.md \
  /Users/hllj/Projects/sdd-superpowers/skills/sdd-brainstorm/SKILL.md \
  /Users/hllj/Projects/sdd-superpowers/skills/sdd-tasks/SKILL.md \
  /Users/hllj/Projects/sdd-superpowers/skills/sdd-spec-update/SKILL.md \
  /Users/hllj/Projects/sdd-superpowers/skills/verification-before-completion/SKILL.md
```

Expected — none of these phrases appear in any output:
- "establishes skill invocation order"
- "2-3 directions"
- "checkboxed task list"
- "after sdd-plan and before sdd-execute"
- "assess impact, version the spec"
- "run the verification command and read the output"

```bash
grep "user-invocable" /Users/hllj/Projects/sdd-superpowers/skills/sdd-workflow/SKILL.md
```
Expected: `user-invocable: false`

```bash
grep "allowed-tools" \
  /Users/hllj/Projects/sdd-superpowers/skills/sdd-brainstorm/SKILL.md \
  /Users/hllj/Projects/sdd-superpowers/skills/sdd-tasks/SKILL.md \
  /Users/hllj/Projects/sdd-superpowers/skills/verification-before-completion/SKILL.md
```
Expected: three lines each showing `allowed-tools: Bash, Read`

---

### Task 7 — Commit Phase 1

```bash
git add \
  skills/sdd-workflow/SKILL.md \
  skills/sdd-brainstorm/SKILL.md \
  skills/sdd-tasks/SKILL.md \
  skills/sdd-spec-update/SKILL.md \
  skills/verification-before-completion/SKILL.md
git commit -m "fix(skills): correct CSO-violating descriptions and add user-invocable to sdd-workflow"
```

Expected: commit created, 5 files changed.

---

## Phase 2+3 — allowed-tools Frontmatter + Content Bug Fixes

All Phase 2+3 tasks touch different files. [P] = safe to run concurrently.

---

### [P] Task 8 — sdd-specify: add allowed-tools

**File:** `skills/sdd-specify/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-specify/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-specify
description: Use when a user describes a new feature, idea, or problem without an existing spec — before any planning, research, or code
---
```

New:
```
---
name: sdd-specify
description: Use when a user describes a new feature, idea, or problem without an existing spec — before any planning, research, or code
allowed-tools: Bash, Read
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-specify/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 9 — sdd-plan: add allowed-tools

**File:** `skills/sdd-plan/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-plan/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-plan
description: Use when a feature spec exists and needs to become a technical implementation plan
---
```

New:
```
---
name: sdd-plan
description: Use when a feature spec exists and needs to become a technical implementation plan
allowed-tools: Bash, Read
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-plan/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 10 — sdd-research: add allowed-tools

**File:** `skills/sdd-research/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-research/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-research
description: Use when a spec has unresolved technology choices, performance targets, security requirements, or external integrations that need investigation before planning
---
```

New:
```
---
name: sdd-research
description: Use when a spec has unresolved technology choices, performance targets, security requirements, or external integrations that need investigation before planning
allowed-tools: Bash, Read
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-research/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 11 — sdd-review: add allowed-tools

**File:** `skills/sdd-review/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-review/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-review
description: Use when a spec needs a completeness check before planning, or when implementation claims to be complete and needs spec-alignment validation
---
```

New:
```
---
name: sdd-review
description: Use when a spec needs a completeness check before planning, or when implementation claims to be complete and needs spec-alignment validation
allowed-tools: Bash, Read
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-review/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 12 — sdd-init: add allowed-tools

**File:** `skills/sdd-init/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-init/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: sdd-init
description: Use when starting a new project that has no CLAUDE.md and no docs/specs/ directory
---
```

New:
```
---
name: sdd-init
description: Use when starting a new project that has no CLAUDE.md and no docs/specs/ directory
allowed-tools: Bash, Read
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-init/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 13 — sdd-execute: add allowed-tools + fix broken integration table

**File:** `skills/sdd-execute/SKILL.md`

This task applies two changes atomically: the `allowed-tools` frontmatter addition and the table bug fix.

**RED — verify both problems:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-execute/SKILL.md
```
Expected: no output

```bash
grep -n "> \*\*Note:\*\*" /Users/hllj/Projects/sdd-superpowers/skills/sdd-execute/SKILL.md
```
Expected: line number present (note block exists between table rows)

**EDIT 1 — replace frontmatter block:**

Old:
```
---
name: sdd-execute
description: Use when a tasks.md exists and implementation should begin
---
```

New:
```
---
name: sdd-execute
description: Use when a tasks.md exists and implementation should begin
allowed-tools: Bash, Read
---
```

**EDIT 2 — fix broken integration table:**

Old (the entire Integration section):
```
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

New:
```
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

**GREEN — verify both fixes:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/sdd-execute/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

```bash
grep -n "> \*\*Note:\*\*" /Users/hllj/Projects/sdd-superpowers/skills/sdd-execute/SKILL.md
grep -n "finishing-a-development-branch" /Users/hllj/Projects/sdd-superpowers/skills/sdd-execute/SKILL.md
```
Expected: note line number is HIGHER than finishing-a-development-branch line number (note is after the table)

---

### [P] Task 14 — using-git: add allowed-tools

**File:** `skills/using-git/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/using-git/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: using-git
description: Use when any git operation is needed in an SDD project — branch creation, commits, merge commit validation, or showing the convention
---
```

New:
```
---
name: using-git
description: Use when any git operation is needed in an SDD project — branch creation, commits, merge commit validation, or showing the convention
allowed-tools: Bash, Read
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/using-git/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 15 — systematic-debugging: add allowed-tools + fix heading capitalisation

**File:** `skills/systematic-debugging/SKILL.md`

This task applies two changes atomically.

**RED — verify both problems:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/systematic-debugging/SKILL.md
```
Expected: no output

```bash
grep "^## your" /Users/hllj/Projects/sdd-superpowers/skills/systematic-debugging/SKILL.md
```
Expected: `## your human partner's Signals You're Doing It Wrong`

**EDIT 1 — replace frontmatter block:**

Old:
```
---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
---
```

New:
```
---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
allowed-tools: Bash, Read
---
```

**EDIT 2 — fix heading capitalisation:**

Old:
```
## your human partner's Signals You're Doing It Wrong
```

New:
```
## Your Human Partner's Signals You're Doing It Wrong
```

**GREEN — verify both fixes:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/systematic-debugging/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

```bash
grep "^## [Yy]our" /Users/hllj/Projects/sdd-superpowers/skills/systematic-debugging/SKILL.md
```
Expected: `## Your Human Partner's Signals You're Doing It Wrong` (capital Y and H)

---

### [P] Task 16 — requesting-code-review: add allowed-tools

**File:** `skills/requesting-code-review/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/requesting-code-review/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: requesting-code-review
description: Use when completing a development phase or major feature, and before merging to main
---
```

New:
```
---
name: requesting-code-review
description: Use when completing a development phase or major feature, and before merging to main
allowed-tools: Bash, Read
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/requesting-code-review/SKILL.md
```
Expected: `allowed-tools: Bash, Read`

---

### [P] Task 17 — test-driven-development: add allowed-tools (Bash only)

**File:** `skills/test-driven-development/SKILL.md`

**RED:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/test-driven-development/SKILL.md
```
Expected: no output

**EDIT — replace frontmatter block:**

Old:
```
---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
---
```

New:
```
---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
allowed-tools: Bash
---
```

**GREEN:**
```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/test-driven-development/SKILL.md
```
Expected: `allowed-tools: Bash` (Bash only — no Read)

---

### Task 18 — Verify all Phase 2+3 changes

```bash
for f in \
  skills/sdd-specify/SKILL.md \
  skills/sdd-plan/SKILL.md \
  skills/sdd-research/SKILL.md \
  skills/sdd-review/SKILL.md \
  skills/sdd-init/SKILL.md \
  skills/sdd-execute/SKILL.md \
  skills/using-git/SKILL.md \
  skills/systematic-debugging/SKILL.md \
  skills/requesting-code-review/SKILL.md; do
  echo "=== $f ==="; grep "allowed-tools" "/Users/hllj/Projects/sdd-superpowers/$f"
done
```
Expected: each file shows `allowed-tools: Bash, Read`

```bash
grep "allowed-tools" /Users/hllj/Projects/sdd-superpowers/skills/test-driven-development/SKILL.md
```
Expected: `allowed-tools: Bash`

**Confirm skills that must NOT have allowed-tools:**
```bash
for f in \
  skills/sdd-workflow/SKILL.md \
  skills/sdd-spec-update/SKILL.md \
  skills/subagent-driven-development/SKILL.md \
  skills/dispatching-parallel-agents/SKILL.md \
  skills/receiving-code-review/SKILL.md \
  skills/finishing-a-development-branch/SKILL.md; do
  echo "=== $f ==="; grep "allowed-tools" "/Users/hllj/Projects/sdd-superpowers/$f" || echo "  (absent — correct)"
done
```
Expected: all 6 print `(absent — correct)`

**Confirm sdd-execute table fix:**
```bash
grep -n "finishing-a-development-branch\|Note:" /Users/hllj/Projects/sdd-superpowers/skills/sdd-execute/SKILL.md
```
Expected: `finishing-a-development-branch` line number < `Note:` line number

**Confirm systematic-debugging heading fix:**
```bash
grep "^## [A-Z]" /Users/hllj/Projects/sdd-superpowers/skills/systematic-debugging/SKILL.md | grep -i "partner"
```
Expected: `## Your Human Partner's Signals You're Doing It Wrong`

---

### Task 19 — Commit Phase 2+3

```bash
cd /Users/hllj/Projects/sdd-superpowers && git add \
  skills/sdd-specify/SKILL.md \
  skills/sdd-plan/SKILL.md \
  skills/sdd-research/SKILL.md \
  skills/sdd-review/SKILL.md \
  skills/sdd-init/SKILL.md \
  skills/sdd-execute/SKILL.md \
  skills/using-git/SKILL.md \
  skills/systematic-debugging/SKILL.md \
  skills/requesting-code-review/SKILL.md \
  skills/test-driven-development/SKILL.md
git commit -m "feat(skills): add allowed-tools frontmatter and fix two content bugs"
```

Expected: commit created, 10 files changed.

---

## Done Criteria

- [ ] All 5 description fields contain only triggering conditions (no workflow leaks)
- [ ] `sdd-workflow` has `user-invocable: false`
- [ ] 12 skills have `allowed-tools: Bash, Read`; `test-driven-development` has `allowed-tools: Bash`
- [ ] 6 skills have no `allowed-tools` field
- [ ] `sdd-execute` integration table has no `> Note:` block between rows
- [ ] `systematic-debugging` heading is `## Your Human Partner's Signals You're Doing It Wrong`
- [ ] 2 commits on branch `015-skills-frontmatter-description-refinement`
