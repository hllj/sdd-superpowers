---
scope: team-practices
loaded-by: sdd-plan, sdd-review, using-git
---

# Team Practices

## Branching
Pattern: `NNN-slug` (e.g. `013-sdd-init-redesign`). See `docs/git-convention.md` for full regex and allowed types.

## Code Review
Skills use `sdd-review` for spec-alignment validation. Phase boundaries trigger `requesting-code-review`. Fixes from review go through `receiving-code-review`.

## Release Process
Bump `.claude-plugin/plugin.json` + `marketplace.json` on every release. No automated release pipeline — tag on main after all tasks verified.
