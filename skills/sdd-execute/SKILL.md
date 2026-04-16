---
name: sdd-execute
description: Use when a tasks.md exists and implementation should begin — dispatches subagents per task with spec-compliance and code-quality review after each
---

# SDD: Execute

Implement a feature by dispatching a fresh subagent per task, with two-stage review after each: spec-compliance first, then code quality. Parallel task groups are dispatched concurrently.

**Announce at start:** "I'm using the sdd-execute skill to implement this feature."

**Core principle:** Fresh subagent per task + spec-compliance review + code-quality review = implementation that provably matches the spec. Subagents never inherit your session context — you construct exactly what they need.

**REQUIRED BACKGROUND:** Understand `superpowers:subagent-driven-development` — this skill applies that pattern with SDD-specific review criteria.

## Prerequisites

- `specs/<NNN>-<feature-slug>/tasks.md` must exist and be approved
- `specs/<NNN>-<feature-slug>/spec.md` must exist (used by spec-compliance reviewer)
- Working on a feature branch (not main/master)
- Clean git baseline (tests passing before implementation starts)

<HARD-GATE>
Do NOT start implementation on main/master. Verify the git branch before dispatching any subagent. If no feature branch exists, stop and run `superpowers:using-git-worktrees` first.
</HARD-GATE>

## The Process

```
Read tasks.md → For each phase:
  Sequential tasks → Execute one at a time
  Parallel groups → Dispatch all [P] tasks concurrently
  After each task → Spec-compliance review → Code-quality review
After all tasks → sdd-review (full) → finishing-a-development-branch
```

### Step 1: Verify Starting Baseline

```bash
# Confirm on feature branch
git branch --show-current

# Confirm baseline tests pass
<project test command>
```

If tests fail before implementation starts: Stop. Report failures. Do not proceed until baseline is clean.

### Step 2: Read and Extract Tasks

Read `specs/<NNN>-<feature-slug>/tasks.md` in full. Extract:
- All tasks with their complete text and code blocks
- Parallel groups (sections marked "can run in parallel")
- Sequential phases and their prerequisites
- The spec file path for reviewer context

**Do NOT make subagents read the tasks file** — provide them the full task text directly.

### Step 3: Execute Each Phase

#### Sequential Tasks

For each sequential task, in order:

**3a. Dispatch implementer subagent**

Provide the subagent with:
- The complete task text (copy verbatim from tasks.md)
- The feature branch name
- The spec file path: `specs/<NNN>-<feature-slug>/spec.md`
- The scene: "You are implementing task TNNNN as part of feature NNN-<slug>. Complete this task, following TDD strictly. Report DONE, DONE_WITH_CONCERNS, NEEDS_CONTEXT, or BLOCKED."

Use model selection:
- Task touches 1-2 files, complete spec provided → fast model
- Task touches multiple files or requires integration judgment → standard model

**3b. Handle implementer status**

| Status | Action |
|--------|--------|
| DONE | Proceed to spec-compliance review |
| DONE_WITH_CONCERNS | Read concerns; if about correctness, address before review; if observational, proceed |
| NEEDS_CONTEXT | Provide missing context, re-dispatch same task |
| BLOCKED | Assess: context problem → provide context; wrong model → upgrade; task too large → split; plan wrong → escalate to human |

Never ignore BLOCKED. Never force retry without changing something.

**3c. Spec-compliance review**

Dispatch a spec-reviewer subagent. Provide:
- The task text
- The spec file contents (or relevant sections)
- The git diff since before the task: `git diff <before-sha>`

The reviewer must answer:
1. Does the implementation satisfy all requirements this task was supposed to address?
2. Did the implementation add anything not in the spec (scope creep)?
3. Are tests actually testing the spec requirements (not just testing the implementation)?

If spec-compliance fails: dispatch the original implementer (same subagent model) to fix the gaps. Re-review until passing.

**3d. Code-quality review**

After spec-compliance passes, dispatch a code-quality reviewer. Provide:
- The git diff
- The relevant spec sections

The reviewer checks: naming clarity, test coverage completeness, no magic numbers, no dead code, error handling correct per spec.

If quality review fails: implementer fixes. Re-review until approved.

**3e. Mark task complete**

```bash
# Confirm task committed
git log --oneline -1
```

Only mark the checkbox complete after tests pass and both reviews approve.

#### Parallel Task Groups

For groups marked "can run in parallel" in tasks.md:

1. Confirm tasks truly touch different files (re-verify independence)
2. Dispatch all tasks in the group concurrently (one subagent each)
3. Wait for ALL implementers to finish before running any reviews
4. Run spec-compliance review for each (can be concurrent)
5. Run code-quality review for each (can be concurrent)
6. Fix any issues from reviews, then re-review

**Safety check before parallel dispatch:**
- [ ] Tasks in this group touch different source files
- [ ] Tasks in this group touch different test files
- [ ] No task depends on output from another in this group

If any safety check fails: execute sequentially instead.

### Step 4: Final Verification

After all tasks complete:

```bash
# Run full test suite
<project test command>
```

Read the complete output. Count failures. If any tests fail: Stop. Use `systematic-debugging` to find root cause before proceeding.

Then dispatch `sdd-review` (implementation mode) to build the full coverage matrix.

### Step 5: Finish

After `sdd-review` reports SPEC-ALIGNED:

> "All tasks complete, tests passing, implementation spec-aligned.
>
> **REQUIRED:** Use `finishing-a-development-branch` to choose how to integrate this work."

Use `finishing-a-development-branch` — do not merge, push, or delete branches directly.

## Model Selection Guide

| Task Characteristics | Model |
|---------------------|-------|
| Single file, clear spec, 1-2 functions | Fast/cheap model |
| Multiple files, needs integration judgment | Standard model |
| Architecture decisions, broad codebase knowledge | Most capable model |
| Spec-compliance review | Standard model |
| Code-quality review | Standard model |

## When a Task Fails Repeatedly

If an implementer is BLOCKED after re-dispatch with context or model upgrade:

1. Read the failure carefully
2. Does it reveal a plan problem? → Update `plan.md` and `tasks.md`, continue
3. Does it reveal a spec ambiguity? → Clarify with user, update `spec.md`, continue
4. Does it reveal an architectural issue (3+ different fixes all fail)? → Stop, invoke `systematic-debugging`, discuss with user

**Never try a 4th implementation approach without architectural discussion.**

## Red Flags — Stop Immediately

- About to work on main/master branch
- About to skip spec-compliance review ("it's obviously correct")
- About to skip code-quality review ("we're in a hurry")
- Tests failing before you started (baseline was not clean)
- Implementer used mocks where real implementations were possible
- Spec-compliance reviewer finds the same issue twice (implementer didn't actually fix it)
- 3+ tasks in a row are BLOCKED on the same root cause

## Integration

**Called after:** `sdd-tasks`

**Subagents should use:**
- `superpowers:test-driven-development` — for each implementation task (red-green-refactor)
- `verification-before-completion` — before reporting DONE

**On failure:** `systematic-debugging`

**On completion:** `sdd-review` → `finishing-a-development-branch`
