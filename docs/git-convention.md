---
branch_pattern: "^[0-9]+-[a-z0-9-]+$"
ticket_prefix: ""
commit_format: "<type>(<scope>): <message>"
allowed_types:
  - feat
  - fix
  - docs
  - chore
  - refactor
  - test
---

# Git Convention

This file is read by SDD skills to enforce branch naming and commit message standards.
To change these settings, edit this file directly.

## Examples

### Branch names
- `003-replace-using-git-worktrees`
- `004-new-feature-slug`

### Commit messages
- `docs(003-replace-using-git-worktrees): add spec, plan, and tasks`
- `feat(003-replace-using-git-worktrees): implement using-git skill`
