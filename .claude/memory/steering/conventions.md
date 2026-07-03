---
scope: conventions
loaded-by: sdd-specify, sdd-plan, sdd-execute, sdd-review
---

# Conventions

## File Naming
- Skills: `skills/<skill-name>/SKILL.md` + `reference.md` (and optional `templates/`)
- Specs: `docs/specs/NNN-feature-slug/spec.md`
- Plans: `docs/specs/NNN-feature-slug/plan.md`
- Tasks: `docs/specs/NNN-feature-slug/tasks.md`
- Hooks: `scripts/hooks/<event-name>.sh`
- Tests: `tests/hooks/test_<hook-name>.sh`

## Directory Structure
```
.claude/          Claude runtime (memory, settings, CLAUDE.md)
docs/specs/       Feature specs, plans, tasks — one directory per feature
skills/           Reusable skill definitions (SKILL.md + reference.md)
scripts/hooks/    Bash hook scripts wired via settings.local.json
tests/hooks/      Hook test suites and fixtures
```

## Code Style
Bash: POSIX-compatible where possible; `set -e` in hook scripts; quote all variables

## Architectural Patterns
Skills are prose instructions — no executable code. Hooks are the only runnable boundary. Each hook is a single-responsibility script.
