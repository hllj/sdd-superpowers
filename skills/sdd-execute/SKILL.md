---
name: sdd-execute
description: Use when a tasks.md exists and implementation should begin
---

# SDD: Execute

**Announce at start:** "I'm using the sdd-execute skill to implement this feature."

## Overview

<examples>
<example>
<context>tasks.md exists with 12 tasks. User says "let's start implementing."</context>
<correct>Invoke sdd-execute. Verify the current branch is correct, then dispatch subagents in task order, completing each before the next.</correct>
<incorrect>Begin writing implementation code in the main conversation context without checking branch or following task order.</incorrect>
</example>
<example>
<context>User says "skip task 3, it's not blocking anything right now."</context>
<correct>Explain why task ordering exists (dependencies, test-before-implementation). Offer to clarify whether task 3 is truly independent before deciding.</correct>
<incorrect>Skip task 3 and proceed to task 4 — skipped tasks leave gaps in test coverage and may break later tasks that assume task 3 is complete.</incorrect>
</example>
</examples>

Implement a feature by dispatching a fresh subagent per task, with two-stage review after each: spec-compliance first, then code quality. Parallel task groups run concurrently. Subagents never inherit session context — you construct exactly what they need.

## When to Use

- A `tasks.md` exists and implementation is ready to start
- NOT when `tasks.md` is missing — run `sdd-superpowers:sdd-tasks` first
- NOT on `main`/`master` — a feature branch must exist

<HARD-GATE>
Do NOT start implementation on main/master. Verify branch before any subagent dispatch.
</HARD-GATE>

## Quick Reference

Execution flow:

```
Verify branch + baseline
→ Sequential tasks: one subagent at a time
→ Parallel groups: dispatch concurrently, wait for all, then review
→ After each task: spec-compliance → code-quality → commit
→ Phase boundary: requesting-code-review (blocking gate)
→ Mid-flight change: STOP → sdd-spec-update → resume
After all tasks: verification-before-completion → sdd-review → finishing-a-development-branch
```

Implementer status handling:

| Status | Action |
|--------|--------|
| DONE | Mark task `[x]` in `tasks.md`, then proceed to spec-compliance review |
| DONE_WITH_CONCERNS | Mark task `[x]` in `tasks.md`; if correctness concern fix first; if observational proceed |
| NEEDS_CONTEXT | Provide context, re-dispatch |
| BLOCKED | Assess: context / model upgrade / split task / escalate |

See [reference.md](reference.md) for the full dispatch procedure, parallel group safety checks, model selection guide, and repeated-failure escalation paths.

## When to Stop and Ask

**STOP executing immediately when:**
- A dependency is missing or broken
- A test fails repeatedly with no clear fix path
- An instruction in the plan is unclear or contradictory
- A plan gap prevents you from starting a task

Ask for clarification rather than guessing. Don't force through blockers.

## Mid-Flight Spec Changes

If the user requests a change, addition, or correction during execution:

1. **STOP** — do not implement the change directly
2. Invoke `sdd-superpowers:sdd-spec-update` to classify impact (PATCH / MINOR / MAJOR) and version the spec
3. Propagate the change to `plan.md` and `tasks.md` as directed by `sdd-spec-update`
4. Resume execution from the updated tasks

Never update tasks or plan directly without running `sdd-superpowers:sdd-spec-update` first.

## Remember

- Follow plan steps exactly — don't improvise or optimize away steps
- Don't skip verifications
- Reference sub-skills when the plan says to
- Stop when blocked — never guess past a blocker
- Never start implementation on main/master without explicit user consent

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

## Constraints

- Does NOT start implementation on main/master — branch must be verified before any subagent is dispatched
- Does NOT skip tasks from the task list — if a task seems unnecessary, surface the question before bypassing it
- Does NOT begin a new task until the prior task's verification step has passed

## Error Handling

- **tasks.md does not exist**: Redirect to `sdd-superpowers:sdd-tasks` before proceeding.
- **Current branch is main/master**: Stop. Ask the user to confirm the correct feature branch before any implementation begins.
- **A task is blocked by an unresolved dependency**: Surface the blocker explicitly to the user; do not skip the task or reorder silently.
- **User requests gate bypass**: The gate is "no implementation on main/master." Explain the risk of implementing directly on main. Offer to create the feature branch first.
