---
name: sdd-tasks
description: Use when an implementation plan exists and needs to become an ordered, checkboxed task list — after sdd-plan and before sdd-execute
---

# SDD: Tasks

Convert an implementation plan into a flat, ordered, executable task list with parallelization hints.

**Announce at start:** "I'm using the sdd-tasks skill to generate the task list."

**Core principle:** Tasks are the executable unit of SDD. The plan describes architecture and approach; tasks are the atomic actions an agent (or human) executes one at a time, with clear done criteria for each.

## Prerequisites

- `docs/specs/<NNN>-<feature-slug>/plan.md` must exist (required)
- `docs/specs/<NNN>-<feature-slug>/data-model.md` (used if present)
- `docs/specs/<NNN>-<feature-slug>/contracts/` (used if present)
- `docs/specs/<NNN>-<feature-slug>/research.md` (used if present)

## Output Location

Save to: `docs/specs/<NNN>-<feature-slug>/tasks.md`

## The Process

### Step 1: Read All Inputs

Read the plan and all supporting documents. Build a mental map of:
- All files that will be created or modified
- All tests that must be written (and in what order)
- All implementation steps (each requiring a prior red test)
- Dependencies between tasks (which must complete before others can start)
- Which tasks are truly independent (safe to parallelize)

### Step 2: Derive Tasks

Convert every plan step into a discrete task. Apply these rules:

**One task = one atomic action:**
- Write a test → one task
- Run a test to verify it fails → one task
- Write implementation → one task
- Run tests to verify pass → one task
- Commit → one task

**Never merge these into one task:**
- ❌ "Write test and implementation for login"
- ✅ Task A: "Write failing test for login validation"
- ✅ Task B: "Verify login test fails (feature not yet implemented)"
- ✅ Task C: "Implement login validation"
- ✅ Task D: "Verify login tests pass"
- ✅ Task E: "Commit: feat: add login validation"

**Mark parallelizable tasks `[P]`:**

A task is safe to parallelize when:
- It has no dependency on another in-progress task's output
- It touches different files than concurrent tasks
- It is a test-writing task for a different component

Example safe parallel groups:
- Writing tests for component A and writing tests for component B (different files)
- Writing data-model.md and writing contract tests (different outputs)

A task is NOT safe to parallelize when:
- It depends on code being written in another concurrent task
- It modifies the same file as a concurrent task

### Step 3: Write tasks.md

Generate `docs/specs/<NNN>-<feature-slug>/tasks.md`:

```markdown
# Tasks: <Feature Name>

**Plan:** docs/specs/<NNN>-<feature-slug>/plan.md
**Generated:** YYYY-MM-DD

> **For agentic workers:** Execute tasks in order. `[P]` tasks within the same parallel group can run concurrently. Never start an implementation task without the prior test task completed and confirmed red.

---

## Parallel Group 0: Setup and Contracts

Tasks in this group can run in parallel.

- [ ] **T001** `[P]` Create directory structure: `mkdir -p src/<path> tests/<path>`
- [ ] **T002** `[P]` Write contract test for `POST /endpoint`:
  ```<language>
  <complete test code>
  ```
  Run: `<command>` — expect: FAIL (endpoint not implemented)
- [ ] **T003** `[P]` Write contract test for `GET /endpoint`:
  ```<language>
  <complete test code>
  ```
  Run: `<command>` — expect: FAIL

---

## Sequential: Phase 1 — <Component Name>

*Complete T001–T003 before starting this phase.*

- [ ] **T004** Write failing unit test for `<function/class>`:
  ```<language>
  <complete test code>
  ```
- [ ] **T005** Verify T004 fails: run `<exact command>` — expect: `FAIL <reason>`
- [ ] **T006** Implement `<function/class>`:
  ```<language>
  <complete implementation code>
  ```
- [ ] **T007** Verify T004 passes: run `<exact command>` — expect: `PASS`
- [ ] **T008** Commit: `git add <files> && git commit -m "feat: <description>"`

---

## Parallel Group 1: <Independent Components>

*Complete T004–T008 before starting. Tasks within this group can run in parallel.*

- [ ] **T009** `[P]` Write failing test for `<component A>`:
  ...
- [ ] **T010** `[P]` Write failing test for `<component B>`:
  ...

---

## Sequential: Phase N — Integration

*All prior phases must be complete.*

- [ ] **TNNN** Run full test suite: `<command>` — expect: ALL PASS
- [ ] **TNNN** Verify acceptance criterion 1: <exact verification step>
- [ ] **TNNN** Verify acceptance criterion 2: <exact verification step>
- [ ] **TNNN** Final commit: `git add . && git commit -m "feat: complete <feature>"`

---

## Task Summary

| Range | Phase | Can Parallelize? |
|-------|-------|-----------------|
| T001–T003 | Setup & Contracts | Yes (within group) |
| T004–T008 | <Phase 1> | No (sequential) |
| T009–T010 | <Phase N> | Yes (within group) |

**Total tasks:** <N>
**Estimated parallel speedup:** <X>x (Y tasks parallelizable)
```

### Step 4: Validate the Task List

Check before presenting:

**Red-before-green:** For every implementation task, is there a preceding "write failing test" task AND a "verify fails" task? No exceptions.

**Complete code:** Every task that writes or runs code shows the exact code or command. No "write a test for login" without the actual test code.

**Commit granularity:** Is there a commit task after each logical unit? Commits should be frequent — every 2-5 implementation tasks.

**Dependency ordering:** Could any task fail because a prior task didn't produce the right output? If so, reorder.

**Parallelization safety:** Recheck every `[P]` task — does it truly touch different files than all concurrent tasks?

### Step 5: Branch Creation and Doc-First Commit

#### 5.1 Load convention

Read `docs/git-convention.md`.

If missing:
- Check if this is a new project (no `CLAUDE.md` exists) → halt: "Run `sdd-init` first to create the git convention."
- If existing project → offer one-time convention creation:
  > "I need to set up your git convention before creating a branch. I'll ask 4 quick questions."
  Ask the same 4 questions as sdd-init Step 5.4. Write `docs/git-convention.md` before continuing.

#### 5.2 Suggest branch names

Prompt:
> "Do you have an external ticket ID? (e.g. PROJ-123) Press Enter to skip."

Generate suggestions based on `branch_pattern` from `docs/git-convention.md`:
- **A:** `NNN-<feature-slug>` (derived from the spec folder name, e.g. `002-git-flow-integration`)
- **B:** ticket-ID-based (only if ticket ID was provided, e.g. `feat/PROJ-123-git-flow-integration`)
- **C:** Type a custom name

Present:
> "Choose a branch name:
> A) `<suggestion A>`
> B) `<suggestion B>` (if ticket ID provided)
> C) Type a custom name
>
> Enter A, B, or your custom branch name:"

#### 5.3 Validate and create branch

Validate the chosen name against `branch_pattern` regex from `docs/git-convention.md`:
- If it matches → create branch: `git checkout -b <name>`
- If it doesn't match → warn: "Branch name `<name>` doesn't match the convention pattern `<pattern>`. Proceed anyway? (yes/no)" Require explicit yes to override.

If the branch already exists:
> "Branch `<name>` already exists. Options:
> 1. Switch to the existing branch
> 2. Choose a different name
> 3. Abort"
Wait for selection.

#### 5.4 Doc-first commit

Stage all files under `docs/specs/<NNN>-<feature-slug>/`:
```bash
git add docs/specs/<NNN>-<feature-slug>/
```

Propose a commit message using `commit_format` and `allowed_types` from `docs/git-convention.md`:
> "Proposed commit: `docs(<NNN>-<feature-slug>): add spec, plan, and tasks`
> Confirm this message, or type an alternative:"

Validate the confirmed message against `commit_format` and `allowed_types`. If invalid, warn and re-prompt.

Execute commit:
```bash
git commit -m "<confirmed message>"
```

If the commit fails (nothing staged, git error):
> "Commit failed: `<exact git error output>`. Resolve the issue and re-run this step."
Do not proceed to handoff until commit succeeds.

### Step 6: Handoff

> "Task list generated: `docs/specs/NNN-feature/tasks.md`
> Branch `<branch-name>` created. Doc-first commit made: `<commit-sha> <commit-message>`
>
> **NNN total tasks** | **X parallelizable across Y parallel groups** | **Z sequential phases**
>
> **Execution options:**
>
> **Option A — Subagent-driven (recommended):**
> Use `sdd-execute` — dispatches a fresh subagent per task with spec-compliance review and code-quality review after each task. Parallel groups dispatched concurrently.
>
> **Option B — Manual/inline:**
> Work through tasks in order, completing each checkbox before starting the next. Use `systematic-debugging` immediately when any task fails — don't skip ahead.
>
> After all tasks: use `sdd-review` (implementation mode) to validate the code matches the spec, then `finishing-a-development-branch` to integrate."

## Task Quality Rules

**No ambiguity in done criteria:** Each task must have an unambiguous pass/fail state. "Write tests" is ambiguous. "Write test, run it, confirm it outputs `FAILED: function not found`" is not.

**Show the complete artifact:** A test task shows the complete test. An implementation task shows the complete function. A command task shows the exact command with expected output.

**Commits have meaningful messages:** Every commit message follows `<type>: <description>` convention (feat, test, fix, refactor, chore).

**Tasks are idempotent:** Running a task twice should produce the same result. "Create directory" is fine (mkdir -p). "Append to file" is not idempotent — rewrite as "write file."
