# SDD Tasks: Full Process Reference

> Complete task derivation procedure, tasks.md template, and quality rules. See [SKILL.md](SKILL.md) for the summary.

## Prerequisites

- `docs/specs/<NNN>-<feature-slug>/plan.md` must exist (required)
- `docs/specs/<NNN>-<feature-slug>/data-model.md` (used if present)
- `docs/specs/<NNN>-<feature-slug>/contracts/` (used if present)
- `docs/specs/<NNN>-<feature-slug>/research.md` (used if present)

## Step 1: Read All Inputs

Read the plan and all supporting documents. Build a mental map of:
- All files that will be created or modified
- All tests that must be written (and in what order)
- All implementation steps (each requiring a prior red test)
- Dependencies between tasks (which must complete before others can start)
- Which tasks are truly independent (safe to parallelize)

## Step 2: Derive Tasks

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

A task is NOT safe to parallelize when:
- It depends on code being written in another concurrent task
- It modifies the same file as a concurrent task

## Step 3: Write tasks.md

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

---

## Sequential: Phase 1 — <Component Name>

*Complete T001–T002 before starting this phase.*

- [ ] **T003** Write failing unit test for `<function/class>`:
  ```<language>
  <complete test code>
  ```
- [ ] **T004** Verify T003 fails: run `<exact command>` — expect: `FAIL <reason>`
- [ ] **T005** Implement `<function/class>`:
  ```<language>
  <complete implementation code>
  ```
- [ ] **T006** Verify T003 passes: run `<exact command>` — expect: `PASS`
- [ ] **T007** Commit: `git add <files> && git commit -m "feat: <description>"`

---

## Sequential: Phase N — Integration

*All prior phases must be complete.*

- [ ] **TNNN** Run full test suite: `<command>` — expect: ALL PASS
- [ ] **TNNN** Verify acceptance criterion 1: <exact verification step>
- [ ] **TNNN** Final commit: `git add . && git commit -m "feat: complete <feature>"`

---

## Task Summary

| Range | Phase | Can Parallelize? |
|-------|-------|-----------------|
| T001–T002 | Setup & Contracts | Yes (within group) |
| T003–T007 | <Phase 1> | No (sequential) |

**Total tasks:** <N>
**Estimated parallel speedup:** <X>x (Y tasks parallelizable)
```

## Step 4: Validate the Task List

Check before presenting:

**Red-before-green:** For every implementation task, is there a preceding "write failing test" task AND a "verify fails" task? No exceptions.

**Complete code:** Every task that writes or runs code shows the exact code or command. No "write a test for login" without the actual test code.

**Commit granularity:** Is there a commit task after each logical unit? Commits should be frequent — every 2-5 implementation tasks.

**Dependency ordering:** Could any task fail because a prior task didn't produce the right output? If so, reorder.

**Parallelization safety:** Recheck every `[P]` task — does it truly touch different files than all concurrent tasks?

## Step 5: Branch Creation and Doc-First Commit

Invoke `using-git` — **Branch Creation and Doc-First Commit**

Pass to `using-git`:
- Spec folder path: `docs/specs/<NNN>-<feature-slug>/`
- Optional ticket ID: ask the user now if not already known

`using-git` will handle: convention loading, branch name suggestions, branch creation, doc staging, commit message confirmation, and commit execution.

Proceed to Step 6 (Handoff) only after `using-git` reports:
- Branch `<name>` created
- Doc-first commit made: `<commit-sha>`

## Step 6: Handoff

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
> Work through tasks in order, completing each checkbox before starting the next."

## Task Quality Rules

**No ambiguity in done criteria:** Each task must have an unambiguous pass/fail state. "Write tests" is ambiguous. "Write test, run it, confirm it outputs `FAILED: function not found`" is not.

**Show the complete artifact:** A test task shows the complete test. An implementation task shows the complete function. A command task shows the exact command with expected output.

**Commits have meaningful messages:** Every commit message follows `<type>: <description>` convention (feat, test, fix, refactor, chore).

**Tasks are idempotent:** Running a task twice should produce the same result. "Create directory" is fine (mkdir -p). "Append to file" is not idempotent — rewrite as "write file."
