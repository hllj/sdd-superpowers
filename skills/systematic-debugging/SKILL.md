---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
---

# Systematic Debugging

## Overview

Random fixes waste time and create new bugs. Find root cause before attempting any fix — always.

**Core principle:** ALWAYS find root cause before fixing. Symptom fixes are failure.

## When to Use

- Any test failure, bug, unexpected behavior, performance problem, build failure, or integration issue
- **Especially when:** under time pressure, "one quick fix" seems obvious, you've already tried fixes, you don't fully understand the issue
- **Never skip when:** issue seems simple (simple bugs have root causes too); you're in a hurry (systematic is faster than thrashing)

## Quick Reference

| Phase | Key Activities | Gate to next phase |
|-------|---------------|-------------------|
| **1. Root Cause** | Read errors, reproduce, check changes, gather evidence, trace data flow | Understand WHAT and WHY |
| **2. Pattern** | Find working examples, compare, identify differences | Differences identified |
| **3. Hypothesis** | Form single theory, test minimally, one variable at a time | Confirmed or new hypothesis |
| **4. Implementation** | Create failing test, fix root cause, verify | Tests pass, no regressions |

**If ≥ 3 fixes have failed:** Stop. Question the architecture — discuss with your human partner before attempting another fix.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

## Common Mistakes

| Mistake | Why it fails |
|---------|-------------|
| "Quick fix for now, investigate later" | Sets wrong pattern; root cause remains |
| "Just try changing X and see if it works" | Can't isolate what worked; creates new bugs |
| "It's probably X, let me fix that" | Seeing symptoms ≠ understanding root cause |
| "Multiple changes at once saves time" | Can't isolate what worked; masks root cause |
| "I'll write test after confirming fix works" | Untested fixes don't stick; test first proves it |
| "One more fix attempt" (after 2+ failures) | 3+ failures = architectural problem, not a bug |
| "Reference too long, I'll adapt the pattern" | Partial understanding guarantees bugs |

Full four-phase procedure, red flags, and supporting techniques: See [reference.md](reference.md)
