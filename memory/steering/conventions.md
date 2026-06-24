---
scope: conventions
loaded-by: sdd-specify, sdd-plan, sdd-execute, sdd-review
---

# Conventions

## File Naming
- Hook scripts: `kebab-case.sh` under `scripts/hooks/`
- Test files: `test_snake_case.sh` under `tests/hooks/`
- Skill files: `SKILL.md` and `reference.md` under `skills/<skill-name>/`
- Memory files: `snake_case.md` under `memory/`
- Spec artifacts: `spec.md`, `plan.md`, `tasks.md`, `research.md` under `docs/specs/NNN-slug/`

## Directory Structure
```
skills/         # One subdirectory per skill; SKILL.md + reference.md required
scripts/hooks/  # Hook shell scripts + lib/ for shared utilities
tests/hooks/    # One test file per hook; helpers.sh shared
memory/         # Tier 2 memory entries + MEMORY.md index
memory/steering/ # Tier 1 operational context files
docs/specs/     # Feature specs organized by NNN-slug
```

## Code Style
- Bash: `set -euo pipefail` at top of every hook script; `shellcheck`-clean
- Skills: markdown only — no code blocks with executable commands unless illustrative
- Commits: Conventional Commits format per `docs/git-convention.md`

## Architectural Patterns
- Skills describe WHAT to do; hooks enforce gates automatically
- Every hook reads stdin JSON via `jq`; outputs JSON with `hookSpecificOutput` or `systemMessage`
- Shared logic extracted to `scripts/hooks/lib/` (e.g., `detect-active-spec.sh`)
