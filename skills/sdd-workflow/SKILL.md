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
| Fuzzy or exploratory idea | `sdd-brainstorm` |
| Clear idea | `sdd-specify` |
| Unresolved tech choices | `sdd-research` |
| Spec exists | `sdd-plan` |
| Plan exists | `sdd-tasks` |
| Tasks exist | `sdd-execute` |
| Alignment check | `sdd-review` |
| Task fails | `systematic-debugging` |
| About to claim done | `verification-before-completion` |
| Merge decision | `finishing-a-development-branch` |

```
NO PLAN without an approved spec
NO TASKS without a plan
NO CODE without a prior failing test
NO COMPLETION CLAIM without fresh verification evidence
```

## Common Mistakes

- Skipping `sdd-brainstorm` — assess fuzziness first
- Coding without a spec — `sdd-specify` first
- Claiming done without evidence — `verification-before-completion`

Full routing rules and red flags: See [routing.md](routing.md)
