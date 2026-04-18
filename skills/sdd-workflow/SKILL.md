---
name: sdd-workflow
description: Use when starting any conversation in an SDD project — establishes skill invocation order
---

# SDD Workflow

## Overview

Entry point for SDD. When a skill might apply, invoke it before acting — non-negotiable.

## When to Use

- Every SDD conversation, from the start
- When the next step after a skill is unclear
- NOT for non-SDD repositories

## Quick Reference

| Situation | Invoke |
|-----------|--------|
| Fuzzy or exploratory idea | `sdd-superpowers:sdd-brainstorm` |
| Clear idea | `sdd-superpowers:sdd-specify` |
| Unresolved tech choices | `sdd-superpowers:sdd-research` |
| Spec exists | `sdd-superpowers:sdd-plan` |
| Plan exists | `sdd-superpowers:sdd-tasks` |
| Tasks exist | `sdd-superpowers:sdd-execute` |
| **Change or addition to an approved spec** | `sdd-superpowers:sdd-update` |
| **All tasks complete** (post-implementation) | `sdd-superpowers:sdd-review` ← required before merge |
| Spec completeness check (pre-plan) | `sdd-superpowers:sdd-review` |
| Task fails | `sdd-superpowers:systematic-debugging` |
| About to claim done | `sdd-superpowers:verification-before-completion` |
| Merge decision | `sdd-superpowers:finishing-a-development-branch` |

```
NO PLAN without an approved spec
NO TASKS without a plan
NO CODE without a prior failing test
NO COMPLETION CLAIM without fresh verification evidence
```

## Common Mistakes

- Skipping `sdd-superpowers:sdd-brainstorm` — assess fuzziness first
- Coding without a spec — `sdd-superpowers:sdd-specify` first
- Updating tasks or plan without running `sdd-superpowers:sdd-update` when user requests a change — spec must be versioned first
- Claiming done without evidence — `sdd-superpowers:verification-before-completion`
- Skipping `sdd-superpowers:sdd-review` after implementation — it is a required step before `finishing-a-development-branch`

Full routing rules and red flags: See [routing.md](routing.md)
