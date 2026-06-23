---
scope: conventions
loaded-by: sdd-specify, sdd-plan, sdd-execute, sdd-review
---

# Conventions

## File Naming
Skills: `skills/<skill-name>/SKILL.md` (overview) + `skills/<skill-name>/reference.md` (full procedure). Specs: `docs/specs/NNN-feature-name/spec.md`. Memory entries: `memory/<slug>.md` with YAML frontmatter.

## Directory Structure
```
skills/<skill-name>/   — SKILL.md + reference.md (+ optional scripts/, references/)
docs/specs/NNN-name/   — spec.md, plan.md, tasks.md, quickstart.md
memory/                — constitution.md + MEMORY.md index + *.md entries
memory/steering/       — tech-stack.md, test-strategy.md, conventions.md, team-practices.md
hooks/                 — shell scripts for lifecycle enforcement
```

## Code Style
Markdown-first. Skill reference.md files use `##` for steps, `###` for sub-steps. Hard gates use `<HARD-GATE>` blocks. Templates use `{{placeholder}}` for fill-in values.

## Architectural Patterns
Skill files are instructions read by Claude, not executed code. Each skill has a SKILL.md (loaded at invocation) and reference.md (loaded for full procedure). Steering files use YAML frontmatter `loaded-by:` to declare which skills incorporate them.
