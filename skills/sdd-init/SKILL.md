---
name: sdd-init
description: Use when starting a new project that has no CLAUDE.md and no docs/specs/ directory
---

# SDD Init

## Overview

Establishes the Constitutional Foundation for a new SDD project: guides the user through the Nine Articles (immutable architectural principles), then writes `memory/constitution.md`, `docs/specs/`, `CLAUDE.md`, and `docs/git-convention.md`. No feature work begins before the constitution is approved.

## When to Use

- The project has no `CLAUDE.md` AND no `docs/specs/` directory
- Starting a brand-new repo from scratch
- NOT when either `CLAUDE.md` or `docs/specs/` already exists — check first

## Quick Reference

Files created by sdd-init:

| File | Purpose |
|------|---------|
| `memory/constitution.md` | Nine Articles — immutable architectural principles |
| `docs/specs/.gitkeep` | Spec directory scaffold |
| `CLAUDE.md` | SDD workflow instructions for this project |
| `docs/git-convention.md` | Branch naming + commit format rules |

The Nine Articles cover: Library-First, CLI Interface, Test-First, three user-defined articles (IV–VI), Simplicity Gate, Anti-Abstraction Gate, Integration-First Testing.

## Process Summary

1. Explore project context (dispatch subagent to read README, package files)
2. Walk through Nine Articles interactively — one per turn, user accepts/customises each
3. Confirm amendment process (Section 4.2)
4. Final approval gate — write nothing until user says yes
5. Create all scaffold files in one uninterrupted sequence
6. Initial commit, then hand off to `sdd-superpowers:sdd-workflow`

<HARD-GATE>
Do NOT create any feature specs, plans, or code until the constitution is approved and the scaffold is written.
</HARD-GATE>

See [reference.md](reference.md) for the full initialisation procedure, Nine Articles defaults, scaffold templates, and error scenarios.
