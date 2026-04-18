---
name: sdd-workflow
description: Use when starting any conversation in an SDD project
---

# SDD Workflow

## Overview
Entry point for all SDD work. Routes situations to the correct skill and enforces mandatory invocation before any action.

## When to Use
- Starting any feature or conversation in an SDD project
- Unsure which skill applies
- **Not for:** non-SDD projects

## Quick Reference
| Situation | Skill |
|-----------|-------|
| Fuzzy idea | `sdd-brainstorm` |
| Clear idea | `sdd-specify` |
| Tech investigation needed | `sdd-research` |
| Spec exists | `sdd-plan` |
| Plan exists | `sdd-tasks` |
| Tasks exist | `sdd-execute` |
| Validate spec or impl | `sdd-review` |
| Task fails | `systematic-debugging` |
| Claiming complete | `verification-before-completion` |
| Merging | `finishing-a-development-branch` |

## Common Mistakes
- Skipping `sdd-specify` — the idea seems obvious but never is
- Running `sdd-plan` before spec approval
- Claiming completion without `verification-before-completion`

## Hard Gates
```
NO PLAN without an approved spec
NO TASKS without a plan
NO CODE without a prior failing test
NO COMPLETION CLAIM without fresh verification evidence
```

Full routing rules and red flags: See [routing.md](routing.md)
