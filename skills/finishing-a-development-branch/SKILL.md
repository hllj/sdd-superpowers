---
name: finishing-a-development-branch
description: Use when implementation is complete, all tests pass, and a decision is needed on how to integrate the work
---

# Finishing a Development Branch

## Overview

Complete a development branch by verifying tests, preparing a merge commit message, and presenting four integration options: merge locally, create PR, keep as-is, or discard.

**Core principle:** Verify tests → Prepare message → Present options → Execute choice → Clean up.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## When to Use

- After `sdd-review` reports SPEC-ALIGNED and all tasks are complete
- All tests passing on the feature branch
- Choosing between merge / PR / keep / discard
- **NOT** before tests pass — fix failures first
- **NOT** before `sdd-review` in the SDD workflow

## Quick Reference

| Step | Action |
|------|--------|
| 1 | Verify tests pass (`npm test` / `pytest` / etc.) |
| 2 | Determine base branch |
| 2.5 | Invoke `using-git` — Merge Commit Message |
| 3 | Present exactly 4 options |
| 4 | Execute chosen option |
| 5 | Cleanup worktree (only if one was used) |

**The 4 options (present verbatim):**

```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work

Which option?
```

**Option 4 requires typed "discard" confirmation.** Never auto-delete.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Proceeding with failing tests | Always verify tests before offering options |
| Open-ended question instead of 4 options | Present exactly the 4 options above, verbatim |
| Cleaning up worktree for Option 2 or 3 | Only clean up for Options 1 and 4 (and only if a worktree was used) |
| Deleting work without confirmation | Require typed "discard" for Option 4 |
| Force-pushing without explicit request | Never force push unless user explicitly asked |

See [reference.md](reference.md) for full step-by-step commands for each option, worktree cleanup detail, and integration notes.
