---
name: sdd-init
description: Use when starting a new project that has no CLAUDE.md and no docs/specs/ directory
---

# SDD Init: Constitutional Foundation

## Overview

Creates the Constitutional Foundation (Nine Articles in `memory/constitution.md`), `docs/specs/` scaffold, `CLAUDE.md`, and `docs/git-convention.md` for a new SDD project. Nothing is written until the user explicitly approves.

## When to Use

- No `CLAUDE.md` exists AND no `docs/specs/` directory exists in the project root
- `sdd-workflow` detected an uninitialised project and routed here
- **Not when:** Either `CLAUDE.md` or `docs/specs/` already exists — partial re-init is handled case-by-case per the error scenarios in reference.md

## Quick Reference

| Step | What happens |
|------|-------------|
| 1 | Announce and orient the user |
| 1.5 | Explore project context (language, framework, test setup) |
| 2 | Interactive Nine Articles review — one per turn, no files written yet |
| 3 | Confirm amendment process (Section 4.2) |
| 4 | **Final approval gate** — write nothing until user says yes |
| 5.1 | Create `memory/constitution.md` |
| 5.2 | Create `docs/specs/.gitkeep` |
| 5.3 | Create or update `CLAUDE.md` |
| 5.4 | Create `docs/git-convention.md` (4-question dialogue) |
| 5.5 | Initial git commit |
| 6 | Handoff — return to `sdd-workflow` |

## Hard Gate

```
WRITE NO FILES before Step 5.
If user aborts before Step 5: write nothing, report abort.
```

Full procedure — Nine Articles text, scaffold templates, git convention setup, error scenarios: See [reference.md](reference.md)
