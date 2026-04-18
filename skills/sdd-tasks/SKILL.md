---
name: sdd-tasks
description: Use when an implementation plan exists and needs to become an ordered, checkboxed task list — after sdd-plan and before sdd-execute
---

# SDD: Tasks

**Announce at start:** "I'm using the sdd-tasks skill to generate the task list."

## Overview

Convert an implementation plan into a flat, ordered, executable task list with parallelization hints. Tasks are the atomic unit of SDD execution — each has unambiguous done criteria, complete code, and an exact verification command.

<HARD-GATE>
Do NOT generate tasks until ALL of the following are true:
1. `plan.md` exists at `docs/specs/NNN-slug/plan.md`
2. The user has explicitly approved the plan in this session

If the plan exists but hasn't been approved: present it and wait for explicit confirmation before generating any tasks.
</HARD-GATE>

## When to Use

- `plan.md` exists and the user has explicitly approved it
- You want to track progress or dispatch agents
- NOT before a plan exists — run `sdd-superpowers:sdd-plan` first

## Quick Reference

Task anatomy — one task = one atomic action:

| Step | Example task |
|------|-------------|
| Write test | "Write failing unit test for `<function>`" (with complete test code) |
| Verify RED | "Run `<exact command>` — expect: FAIL `<reason>`" |
| Implement | "Implement `<function>`" (with complete implementation) |
| Verify GREEN | "Run `<exact command>` — expect: PASS" |
| Commit | "`git commit -m 'feat: <description>'`" |

`[P]` marks tasks safe to run concurrently — they touch different files and have no shared dependencies.

After generating `tasks.md`, invokes `sdd-superpowers:using-git` for branch creation and doc-first commit.

See [reference.md](reference.md) for full derivation rules, tasks.md template (with parallel group format), validation checklist, and task quality rules.
