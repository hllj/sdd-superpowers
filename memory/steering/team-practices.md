---
scope: team-practices
loaded-by: sdd-plan, sdd-review, using-git
---

# Team Practices

## Branching
Pattern: `NNN-slug` (e.g. `014-tiered-memory-architecture`) — see `docs/git-convention.md` for full regex. One branch per spec; branch created by `sdd-tasks` after tasks.md is written.

## Code Review
Every feature goes through `sdd-review` Mode B (coverage matrix + test run) before merge. PRs created via `finishing-a-development-branch`. No direct pushes to master.

## Release Process
Version bump in `.claude-plugin/plugin.json` and `marketplace.json` on every release. Tag on master after merge. Semantic versioning (MAJOR.MINOR.PATCH).
