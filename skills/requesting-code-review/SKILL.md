---
name: requesting-code-review
description: Use when completing a development phase or major feature, and before merging to main
---

# Requesting Code Review

## Overview

Dispatch a `superpowers:code-reviewer` subagent with precisely crafted context to catch issues before they cascade. The reviewer gets the work product, not your session history — keeping review focused and your context uncluttered.

**Core principle:** Review early, review often.

**Announce at start:** "I'm using the requesting-code-review skill to get a code review."

## When to Use

**Mandatory:**
- After completing a phase in `sdd-execute` (blocking gate before next phase starts)
- Before merge to main
- After completing a major feature

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing a complex bug

**NOT** a substitute for running tests — always verify tests first.

## Quick Reference

**1. Get git SHAs:**
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**2. Dispatch `superpowers:code-reviewer` subagent with:**
- `{WHAT_WAS_IMPLEMENTED}` — what you just built
- `{PLAN_OR_REQUIREMENTS}` — what it should do
- `{BASE_SHA}` / `{HEAD_SHA}` — commit range
- `{DESCRIPTION}` — brief summary

**3. Act on feedback:**
- **Critical:** Fix immediately
- **Important:** Fix before proceeding
- **Minor:** Note for later
- **Wrong:** Push back with technical reasoning

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skipping review because "it's simple" | Always review at phase boundaries in sdd-execute |
| Ignoring Critical issues | Fix immediately — do not proceed |
| Proceeding with unfixed Important issues | Fix before starting the next phase |
| Accepting wrong feedback without pushback | Use technical reasoning and show evidence |

See template at: `requesting-code-review/code-reviewer.md`
