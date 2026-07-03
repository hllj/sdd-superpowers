# SDD Execute: Full Process Reference

> Complete dispatch procedure, model selection, and failure escalation paths. See [SKILL.md](SKILL.md) for the summary.

## Step 0: Load Steering Context

Scan `.claude/memory/steering/` for `.md` files whose `loaded-by` frontmatter includes `sdd-execute`. Read each matched file and incorporate its content as context before producing any user-facing output. Loading is silent — no announcement to the user.

If `.claude/memory/steering/` does not exist, or no files contain `sdd-execute` in `loaded-by`, proceed without change.

Rescan on every invocation — custom files added after init are discovered automatically.

## Step 1: Verify Starting Baseline

```bash
git branch --show-current
```
If output is `main` or `master`: **STOP**. Ask user to confirm the correct feature branch before any implementation begins.

**Load git convention:** Read `docs/git-convention.md`.
- Missing on new project (no `CLAUDE.md`): halt — "Run `sdd-superpowers:sdd-init` first."
- Missing on existing project: offer one-time creation dialogue (same 4 questions as `sdd-superpowers:sdd-init` Step 5.4), write `docs/git-convention.md`, then continue.

```bash
# Confirm baseline tests pass
<project test command>
```
If tests fail: stop, report failures, do not proceed.

## Step 2: Detect Mode and Derive Work Units

### 2a. Detect execution mode

Check whether `docs/specs/<NNN>-<feature-slug>/tasks.md` exists:

- **tasks.md present → task-driven mode**: Read `tasks.md` in full. Extract all tasks with complete text and code blocks, parallel groups, sequential phases and prerequisites, and the spec file path. Skip to Step 3 — use task text as work unit content. **Do NOT make subagents read the tasks file** — provide full task text directly.

- **tasks.md absent → plan-driven mode**: Continue with steps 2b–2e below.

### 2b. Read source files (plan-driven only)

Read both files in full:
- `docs/specs/<NNN>-<feature-slug>/plan.md`
- `docs/specs/<NNN>-<feature-slug>/spec.md`

If `plan.md` cannot be read: surface error "No plan.md found at docs/specs/NNN-feature/plan.md. Run sdd-plan first." Halt.
If `plan.md` has no sections: surface error "plan.md has no sections to derive work units from." Halt.

**Do NOT make subagents read these files** — extract and inject content directly into each subagent prompt.

### 2c. Derive work units (plan-driven only)

From `plan.md`, produce a flat ordered list of work units. Each work unit:
- Is scoped to one plan section or sub-section
- Is sized to be implementable by one subagent in a single TDD red-green-refactor cycle
- Has a title equal to the plan section heading (used for commit message matching in restart detection)

Work unit size guide:
- One well-scoped function or behavior change = one work unit
- If a plan section describes 3+ distinct behaviors, split into sub-units (one per behavior)
- If a plan section is a single configuration change or single file edit, keep as one unit

Record all derived work units as TodoWrite entries before dispatching any subagent.

### 2d. Determine parallelization (plan-driven only)

For each pair of work units, mark as parallelizable only if BOTH conditions hold:
1. The plan text explicitly states the sections are independent, OR the units modify disjoint sets of files
2. No ordering constraint is stated or implied in the plan between the two sections

Default to sequential when parallelism cannot be confirmed. Do not invent concurrency.

### 2e. Restart detection (plan-driven only)

Run:
```bash
git log --oneline
```

For each work unit, check whether its plan section heading appears in any commit message. If a match is found: mark that unit complete in TodoWrite and skip it in dispatch. Only dispatch units with no matching commit.

## Step 3: Execute Each Phase

### Sequential Tasks

For each sequential task, in order:

**3a. Dispatch implementer subagent**

Provide the subagent with:
- The complete task text (copy verbatim from tasks.md)
- The feature branch name
- The spec file path: `docs/specs/<NNN>-<feature-slug>/spec.md`
- The scene: "You are implementing [work unit title / task ID] as part of feature NNN-<slug>. Complete this work using the `sdd-superpowers:test-driven-development` skill (RED-GREEN-REFACTOR: write failing test → confirm it fails → write minimal implementation → confirm it passes → commit). Do NOT write implementation code before a failing test exists. Include the work unit title '[exact plan section heading]' in your commit message. Report DONE, DONE_WITH_CONCERNS, NEEDS_CONTEXT, or BLOCKED."

**3b. Handle implementer status**

| Status | Action |
|--------|--------|
| DONE | **Mark `[x]` in tasks.md (step 3b-1), then** proceed to spec-compliance review |
| DONE_WITH_CONCERNS | **Mark `[x]` in tasks.md (step 3b-1);** if correctness concern, address before review; if observational, proceed |
| NEEDS_CONTEXT | Provide missing context, re-dispatch same task |
| BLOCKED | Assess: context problem → provide context; wrong model → upgrade; task too large → split; plan wrong → escalate to human |

Never ignore BLOCKED. Never force retry without changing something.

**3b-1. Mark task complete in tasks.md**

Immediately after a subagent returns `DONE` or `DONE_WITH_CONCERNS` — before spec-compliance review — edit `tasks.md`:

**Task-driven mode:** Find the line for the task that just completed. Edit its checkbox from `[ ]` to `[x]`.

```
- [ ] Task N: Description   →   - [x] Task N: Description
```

**Plan-driven mode:** Mark the work unit complete in TodoWrite. No file edit needed.

Constraints (both modes):
- Mark only the unit that just completed
- Do not mark speculatively before the subagent result is known
- If the subagent returns `NEEDS_CONTEXT` or `BLOCKED`, leave the unit incomplete

**3c. Spec-compliance review**

Dispatch a spec-reviewer subagent. Provide:
- The task text
- The spec file contents (or relevant sections)
- The git diff since before the task: `git diff <before-sha>`

The reviewer must answer:
1. Does the implementation satisfy all requirements this task was supposed to address?
2. Did the implementation add anything not in the spec (scope creep)?
3. Are tests actually testing the spec requirements (not just testing the implementation)?

If spec-compliance fails: invoke `sdd-superpowers:receiving-code-review` with the reviewer's findings, then dispatch the original implementer to fix. Re-review until passing.

**3d. Code-quality review**

After spec-compliance passes, dispatch a code-quality reviewer. Provide:
- The git diff
- The relevant spec sections

The reviewer checks: naming clarity, test coverage completeness, no magic numbers, no dead code, error handling correct per spec.

If quality review fails: invoke `sdd-superpowers:receiving-code-review`, send implementer to fix. Re-review until approved.

**3e. Commit completed task**

Invoke `sdd-superpowers:using-git` — **Per-Task Commit**. Pass: prior commit SHA (`git rev-parse HEAD` recorded before dispatch) and task description. `sdd-superpowers:using-git` handles conflict detection, staging, message validation, and commit execution.

**3f. Phase boundary review**

When all tasks in a phase complete, before starting the next phase:

Invoke `sdd-superpowers:requesting-code-review`. Blocking gate — critical issues must be resolved before proceeding.

### Parallel Task Groups

**REQUIRED:** Invoke `sdd-superpowers:dispatching-parallel-agents` before dispatching this group.

Safety check before dispatch:
- [ ] Tasks touch different source files
- [ ] Tasks touch different test files
- [ ] No task depends on another in this group's output

If any check fails: execute sequentially.

1. Dispatch all tasks concurrently (one subagent each)
2. Wait for ALL implementers to finish
3. Run spec-compliance review for each (can be concurrent)
4. Run code-quality review for each (can be concurrent)
5. Fix issues via `sdd-superpowers:receiving-code-review`, re-review

## Step 4: Final Verification

```bash
<project test command>
```

Read complete output. Count failures. If any fail: use `sdd-superpowers:systematic-debugging` before proceeding.

Invoke `sdd-superpowers:verification-before-completion` — capture fresh test evidence before any completion claim. This is a **hard gate**: no completion claim without running this.

Dispatch `sdd-superpowers:sdd-review` (implementation mode) to build the coverage matrix.

## Step 5: Finish

After `sdd-superpowers:sdd-review` reports SPEC-ALIGNED, use `sdd-superpowers:finishing-a-development-branch`. Do not merge, push, or delete branches directly.

---

## Mid-Flight Spec Changes

If the user requests a change, addition, or correction during execution:

1. **STOP** the current task (do not implement the change directly)
2. Invoke `sdd-superpowers:sdd-spec-update` — classify PATCH / MINOR / MAJOR, version the spec
3. Propagate to `plan.md` as directed by `sdd-spec-update` (and `tasks.md` if it exists)
4. Resume execution from the updated tasks

**MAJOR bump** (architectural change): re-evaluate the entire task list before resuming.
**MINOR bump** (new scope): add tasks, continue sequential execution.
**PATCH bump** (clarification): update task text in place, continue.

Never touch plan or tasks directly — `sdd-spec-update` owns that propagation.

---

## Model Selection Guide

| Task Characteristics | Model |
|---------------------|-------|
| Single file, clear spec, 1-2 functions | Fast/cheap model |
| Multiple files, needs integration judgment | Standard model |
| Architecture decisions, broad codebase knowledge | Most capable model |
| Spec-compliance review | Standard model |
| Code-quality review | Standard model |

---

## When a Task Fails Repeatedly

If an implementer is BLOCKED after re-dispatch with context or model upgrade:

1. Read the failure carefully
2. Plan problem? → Update `plan.md` (and `tasks.md` if it exists), continue
3. Spec ambiguity? → Clarify with user, update `spec.md`, continue
4. Architectural issue (3+ different fixes all fail)? → Stop, invoke `sdd-superpowers:systematic-debugging`, discuss with user

**Never try a 4th implementation approach without architectural discussion.**

---

## Integration

**Called after:** `sdd-superpowers:sdd-plan` (plan-driven mode) or `sdd-superpowers:sdd-tasks` (task-driven mode, when tasks.md exists)

**Subagents must use:**
- `sdd-superpowers:test-driven-development` — mandatory for every implementation task
- `sdd-superpowers:verification-before-completion` — before reporting DONE

**During execution:**
- `sdd-superpowers:requesting-code-review` — at every phase boundary (blocking gate)
- `sdd-superpowers:receiving-code-review` — whenever review feedback requires fixes
- `sdd-superpowers:dispatching-parallel-agents` — before every parallel group dispatch

**On failure:** `sdd-superpowers:systematic-debugging`

**On completion:** `sdd-superpowers:sdd-review` → `sdd-superpowers:finishing-a-development-branch`
