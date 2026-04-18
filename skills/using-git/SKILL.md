---
name: using-git
description: Use when any git operation is needed in an SDD project — branch creation, commits, merge commit validation, or showing the convention
---

# Using Git in SDD Projects

**Announce at start:** "I'm using the using-git skill to perform a git operation."

## Overview

All SDD git operations run through this skill. It enforces the convention in `docs/git-convention.md` for every branch name and commit message. Two usage modes: direct invocation (user picks from a menu) or delegation (another skill passes a named operation and inputs).

## When to Use

- Creating a feature branch for a new spec
- Making a doc-first commit after tasks.md is written
- Making a per-task commit during `sdd-superpowers:sdd-execute`
- Generating a merge commit message for `sdd-superpowers:finishing-a-development-branch`
- Showing or verifying the git convention
- NOT for general shell git commands outside an SDD project context

## Quick Reference

| Operation | Invoked by | Menu option |
|-----------|-----------|-------------|
| A — Branch Creation | `sdd-superpowers:sdd-tasks`, user | 1 |
| B — Doc-First Commit | `sdd-superpowers:sdd-tasks` (after A), user | 2 (ad-hoc) |
| C — Per-Task Commit | `sdd-superpowers:sdd-execute` (delegation only) | not in menu |
| D — Merge Commit Message | `sdd-superpowers:finishing-a-development-branch`, user | 3 |
| Show convention | user | 4 |

Convention file: `docs/git-convention.md` (YAML frontmatter with `branch_pattern`, `commit_format`, `allowed_types`). Missing file on new project → halt, run `sdd-superpowers:sdd-init`. Missing on existing project → offer 4-question creation dialogue.

See [reference.md](reference.md) for convention loading detail, full operation procedures (A–D), error reference table, and worktrees guide.
