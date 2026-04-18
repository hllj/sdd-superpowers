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
| Alignment check | `sdd-superpowers:sdd-review` |
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
- Claiming done without evidence — `sdd-superpowers:verification-before-completion`

Full routing rules and red flags: See [routing.md](routing.md)
