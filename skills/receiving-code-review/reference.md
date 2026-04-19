# Receiving Code Review: Full Procedure Reference

> Complete verification checklist, pushback criteria, and examples. See [SKILL.md](SKILL.md) for the summary.

## Source-Specific Handling

### From Reviewer Subagents (SDD — most common in sdd-execute / subagent-driven-development)

Reviewer subagents are dispatched by the controller and are authoritative within their domain:

- **Spec compliance reviewer** — its findings are ground truth against `docs/specs/NNN-feature/spec.md`. If it says something is missing or extra, it is.
- **Code quality reviewer** — its findings are advisory; use technical judgment to evaluate severity.

```
BEFORE implementing:
  1. Read the reviewer's findings carefully
  2. Verify against the actual code (don't just trust the finding)
  3. If spec compliance: cross-check against spec.md directly
  4. Implement fixes one at a time, test each
  5. Re-dispatch the SAME reviewer subagent to verify fixes before moving on
```

**Never skip the re-dispatch.** Fixes must be verified by the reviewer, not self-assessed.

### From your human partner
- **Trusted** - implement after understanding
- **Still ask** if scope unclear
- **No performative agreement**
- **Skip to action** or technical acknowledgment

### From External Reviewers

```
BEFORE implementing:
  1. Check: Technically correct for THIS codebase?
  2. Check: Breaks existing functionality?
  3. Check: Reason for current implementation?
  4. Check: Works on all platforms/versions?
  5. Check: Does reviewer understand full context?

IF suggestion seems wrong:
  Push back with technical reasoning

IF can't easily verify:
  Say so: "I can't verify this without [X]. Should I [investigate/ask/proceed]?"

IF conflicts with your human partner's prior decisions:
  Stop and discuss with your human partner first
```

## YAGNI Check for "Professional" Features

```
IF reviewer suggests "implementing properly":
  FIRST: Check docs/specs/NNN-feature/spec.md

  IF spec.md requires it: Implement — spec overrides YAGNI
  IF spec.md is silent:
    grep codebase for actual usage
    IF unused: "This endpoint isn't called. Remove it (YAGNI)?"
    IF used: Then implement properly
```

**SDD rule:** `spec.md` is the authority. If it's in the spec, build it. YAGNI only applies to things outside the spec's scope.

## Implementation Order

```
FOR multi-item feedback:
  1. Clarify anything unclear FIRST
  2. Then implement in this order:
     - Blocking issues (breaks, security)
     - Simple fixes (typos, imports)
     - Complex fixes (refactoring, logic)
  3. Test each fix individually
  4. Verify no regressions
  5. (SDD) Re-dispatch the reviewer subagent to confirm all issues resolved
     — do NOT proceed to the next stage until reviewer approves
```

## When To Push Back

Push back when:
- Suggestion breaks existing functionality
- Reviewer lacks full context
- Violates YAGNI (unused feature)
- Technically incorrect for this stack
- Legacy/compatibility reasons exist
- Conflicts with your human partner's architectural decisions

**How to push back:**
- Use technical reasoning, not defensiveness
- Ask specific questions
- Reference working tests/code
- Involve your human partner if architectural

**Signal if uncomfortable pushing back out loud:** "Strange things are afoot at the Circle K"

## Acknowledging Correct Feedback

When feedback IS correct:
```
✅ "Fixed. [Brief description of what changed]"
✅ "Good catch - [specific issue]. Fixed in [location]."
✅ [Just fix it and show in the code]

❌ "You're absolutely right!"
❌ "Great point!"
❌ "Thanks for catching that!"
❌ ANY gratitude expression
```

**Why no thanks:** Actions speak. Just fix it. The code itself shows you heard the feedback.

## Gracefully Correcting Your Pushback

If you pushed back and were wrong:
```
✅ "You were right - I checked [X] and it does [Y]. Implementing now."
✅ "Verified this and you're correct. My initial understanding was wrong because [reason]. Fixing."

❌ Long apology
❌ Defending why you pushed back
❌ Over-explaining
```

State the correction factually and move on.

## Real Examples

**Performative Agreement (Bad):**
```
Reviewer: "Remove legacy code"
❌ "You're absolutely right! Let me remove that..."
```

**Technical Verification (Good):**
```
Reviewer: "Remove legacy code"
✅ "Checking... build target is 10.15+, this API needs 13+. Need legacy for backward compat. Current impl has wrong bundle ID - fix it or drop pre-13 support?"
```

**YAGNI (Good):**
```
Reviewer: "Implement proper metrics tracking with database, date filters, CSV export"
✅ "Grepped codebase - nothing calls this endpoint. Remove it (YAGNI)? Or is there usage I'm missing?"
```

**Unclear Item (Good):**
```
your human partner: "Fix items 1-6"
You understand 1,2,3,6. Unclear on 4,5.
✅ "Understand 1,2,3,6. Need clarification on 4 and 5 before implementing."
```

## GitHub Thread Replies

When replying to inline review comments on GitHub, reply in the comment thread (`gh api repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies`), not as a top-level PR comment.

## Integration

**Called by:**
- `sdd-superpowers:sdd-execute` — when spec compliance or code quality review returns issues
- `sdd-superpowers:subagent-driven-development` — when per-task review loop finds failures

**After implementing fixes:**
- Re-dispatch the reviewer subagent (`sdd-superpowers:requesting-code-review`) to verify
- Only proceed to next stage once reviewer approves (✅)
- If spec compliance passes, proceed to code quality review
- If code quality passes, mark task complete in TodoWrite
