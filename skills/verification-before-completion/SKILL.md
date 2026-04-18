---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing — run the verification command and read the output before making any success claim
---

# Verification Before Completion

## Overview

Claiming work is complete without running verification is dishonesty, not efficiency.

**Iron Law:** No completion claim without fresh verification evidence.

**Violating the letter of this rule is violating the spirit of this rule.**

**Announce at start:** "I'm using the verification-before-completion skill before making any claim."

## When to Use

**ALWAYS before:**
- Any success or completion claim — "done", "fixed", "passing", "works"
- Any expression of satisfaction ("Great!", "Perfect!", "Done!")
- Committing, creating a PR, or marking a task complete
- Moving to the next task or delegating to agents

**Rule applies to:** Exact phrases, paraphrases, implications, and any wording suggesting completion.

## Quick Reference

**The Gate Function — run before any claim:**

```
1. IDENTIFY: What command proves this claim?
2. RUN: Execute the FULL command (fresh, not a prior run)
3. READ: Full output — check exit code, count failures
4. VERIFY: Does output confirm the claim?
5. ONLY THEN: Make the claim
```

**Common Failures:**

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| Tests pass | Command output: 0 failures | Previous run, "should pass" |
| Build succeeds | Build command: exit 0 | Linter passing, logs look good |
| Bug fixed | Test original symptom: passes | Code changed, assumed fixed |
| Agent completed | VCS diff shows changes | Agent reports "success" |
| Requirements met | Line-by-line checklist | Tests passing |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| "Should work now" | Run the verification command |
| "I'm confident this is correct" | Confidence ≠ evidence — run it |
| "Linter passed" for a build claim | Linter ≠ compiler |
| Trusting agent success reports | Verify independently via VCS diff |
| Partial verification ("ran some tests") | Full suite, full output |
| "Just this once" | No exceptions, ever |

See [reference.md](reference.md) for rationalization patterns, red flags, TDD red-green verification, and why this matters.
