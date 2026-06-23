<!-- sdd-init: generated -->
# SDD Superpowers

Before starting work, invoke `sdd-superpowers:sdd-workflow`.

## Memory

Memory lives in `memory/` — see `memory/MEMORY.md` for the index.
Project identity is in `memory/foundation.md`.
Steering files in `memory/steering/` are loaded by skills when relevant.

## Hard Gates

- NO PLAN without an approved spec
- NO TASKS without a plan
- NO CODE without a prior failing test
- NO COMPLETION CLAIM without fresh verification evidence

## Project Context

Before starting any work, read these sources:

| Source | What it contains |
|--------|-----------------|
| `memory/foundation.md` | Mission and principles. Loaded every session. |
| `memory/MEMORY.md` | Index of all persistent memory files |
| `docs/git-convention.md` | Branch naming regex, commit format, allowed types |
| `docs/specs/` | All feature specs, plans, and task lists |

Always check `docs/specs/` for existing specs before starting a new feature.

> For plugin contributor reference (skills, workflow, directory structure): see `docs/contributing.md`
