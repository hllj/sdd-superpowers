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
- NOT when `tasks.md` is missing — run `sdd-tasks` first
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
After all tasks: sdd-review → finishing-a-development-branch
```

Implementer status handling:

| Status | Action |
|--------|--------|
| DONE | Proceed to spec-compliance review |
| DONE_WITH_CONCERNS | Correctness concern → fix first; observational → proceed |
| NEEDS_CONTEXT | Provide context, re-dispatch |
| BLOCKED | Assess: context / model upgrade / split task / escalate |

See [reference.md](reference.md) for the full dispatch procedure, parallel group safety checks, model selection guide, and repeated-failure escalation paths.
