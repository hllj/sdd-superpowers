---
name: finishing-a-development-branch
description: Use when implementation is complete, all tests pass, and a decision is needed on how to integrate the work
model: sonnet
effort: high
---

# Finishing a Development Branch

## Overview

<examples>
<example>
<context>All tasks in tasks.md are checked off but the test suite has two failing tests.</context>
<correct>Halt. Fix the failing tests before presenting integration options — a branch with failing tests is not complete.</correct>
<incorrect>Present the four integration options anyway and let the user decide — failing tests are a blocker, not a trade-off.</incorrect>
</example>
</examples>

Verify tests, prepare a merge commit message, and present four integration options: merge locally, create PR, keep, or discard.

**Core principle:** Verify tests → Prepare message → Present options → Execute choice → Clean up.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## When to Use

- After `sdd-superpowers:sdd-review` reports SPEC-ALIGNED and all tasks are complete
- All tests passing on the feature branch
- Choosing between merge / PR / keep / discard
- **NOT** before tests pass — fix failures first
- **NOT** before `sdd-superpowers:sdd-review` in the SDD workflow

## Quick Reference

| Step | Action |
|------|--------|
| 1 | Verify tests pass (`npm test` / `pytest` / etc.) |
| 2 | Determine base branch |
| 2.5 | Invoke `sdd-superpowers:using-git` — Merge Commit Message |
| 3 | Present exactly 4 options |
| 4 | Execute chosen option |
| 5 | Cleanup worktree (only if one was used) |
| 6 | Invoke `sdd-superpowers:session-wrap` quick mode |

**The 4 options (present verbatim):**

```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work

Which option?
```

**After the chosen option and any cleanup complete, invoke `sdd-superpowers:session-wrap` quick mode to capture session learnings before closing.**

**Option 4 requires typed "discard" confirmation.** Never auto-delete.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Proceeding with failing tests | Always verify tests before offering options |
| Open-ended question instead of 4 options | Present exactly the 4 options above, verbatim |
| Cleaning up worktree for Option 2 or 3 | Only clean up for Options 1 and 4 (and only if a worktree was used) |
| Deleting work without confirmation | Require typed "discard" for Option 4 |
| Force-pushing without explicit request | Never force push unless user explicitly asked |

**REQUIRED READING before proceeding:** [reference.md](reference.md) — per-option commands and worktree cleanup detail.

## Constraints

- Does NOT present integration options while tests are failing
- Does NOT claim merge-ready without running the full test suite

## Error Handling

- **Tests are failing**: Halt. Fix failing tests before choosing an integration option.
- **No test suite exists**: Document what was manually verified before presenting options.
- **User requests gate bypass**: Tests must pass before integration. Explain that merging failing tests breaks main; offer to fix failures first.
