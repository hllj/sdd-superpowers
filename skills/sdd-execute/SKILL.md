---
name: sdd-execute
description: Use when a tasks.md exists and implementation should begin
---

# SDD: Execute

**Announce at start:** "I'm using the sdd-execute skill to implement this feature."

## Overview

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
→ Mid-flight change: STOP → sdd-update → resume
After all tasks: verification-before-completion → sdd-review → finishing-a-development-branch
```

Implementer status handling:

| Status | Action |
|--------|--------|
| DONE | Proceed to spec-compliance review |
| DONE_WITH_CONCERNS | Correctness concern → fix first; observational → proceed |
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
2. Invoke `sdd-superpowers:sdd-update` to classify impact (PATCH / MINOR / MAJOR) and version the spec
3. Propagate the change to `plan.md` and `tasks.md` as directed by `sdd-update`
4. Resume execution from the updated tasks

Never update tasks or plan directly without running `sdd-superpowers:sdd-update` first.

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

> **Note:** `sdd-superpowers:test-driven-development` is mandated for **implementer subagents** dispatched by `subagent-driven-development` — not invoked directly by the controller.
| Phase boundary | `sdd-superpowers:requesting-code-review` |
| Implementing fixes after review feedback | `sdd-superpowers:receiving-code-review` |
| Task fails or behavior unexpected | `sdd-superpowers:systematic-debugging` |
| About to claim done | `sdd-superpowers:verification-before-completion` |
| All tasks complete | `sdd-superpowers:sdd-review` (required before merge) |
| sdd-review passes | `sdd-superpowers:finishing-a-development-branch` |
