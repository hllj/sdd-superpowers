---
name: sdd-init
description: Use when starting a new project that has no CLAUDE.md and no docs/specs/ directory
---

# SDD Init

## Overview

Establishes the project foundation for a new SDD project: guides the user through a 4-question Mission Charter ceremony, then writes `memory/constitution.md`, auto-generates steering files in `memory/steering/`, and scaffolds `docs/specs/`, `CLAUDE.md`, and `docs/git-convention.md`. No feature work begins before the constitution is approved.

## When to Use

- The project has no `CLAUDE.md` AND no `docs/specs/` directory
- Starting a brand-new repo from scratch
- NOT when either `CLAUDE.md` or `docs/specs/` already exists — check first

## Quick Reference

Files created by sdd-init:

| File | Purpose |
|------|---------|
| `memory/constitution.md` | Mission Charter — mission statement + 3–5 project-specific principles |
| `memory/steering/tech-stack.md` | Tech stack context — loaded by sdd-specify, sdd-plan, sdd-execute, sdd-research, sdd-review |
| `memory/steering/test-strategy.md` | Test philosophy — loaded by sdd-plan, sdd-execute, sdd-review |
| `memory/steering/conventions.md` | Code conventions — loaded by sdd-specify, sdd-plan, sdd-execute, sdd-review |
| `memory/steering/team-practices.md` | Team practices — loaded by sdd-plan, sdd-review, using-git |
| `docs/specs/.gitkeep` | Spec directory scaffold |
| `CLAUDE.md` | SDD workflow instructions with Project Foundation pointer |
| `docs/git-convention.md` | Branch naming + commit format rules |

Flags: `--fast` skips Q3 (failure modes) — use for returning users or time-constrained sessions.

## Process Summary

1. Detect project context (subagent, silent) + check for existing constitution
2. Mission Charter: 4 questions via structured UI (Q1 mission, Q2 non-negotiables, Q3 failure modes, Q4 amendment) — Q3 skipped if `--fast`
3. Draft constitution from answers → user approval gate → write `memory/constitution.md`
4. Auto-generate 4 steering files from detected context → write `memory/steering/*.md`
5. Create scaffold files (CLAUDE.md, docs/specs/.gitkeep, docs/git-convention.md) in one uninterrupted sequence
6. Initial commit → hand off to `sdd-superpowers:sdd-workflow`

<HARD-GATE>
Do NOT create any feature specs, plans, or code until the constitution is approved and the scaffold is written.
</HARD-GATE>

See [reference.md](reference.md) for the full initialisation procedure, Mission Charter ceremony, steering file templates, scaffold templates, and error scenarios.
