---
name: receiving-code-review
description: Use when receiving code review feedback, before implementing review suggestions
---

# Code Review Reception

## Overview

Code review requires technical evaluation, not emotional performance. Verify before implementing. Ask before assuming. Technical correctness over social comfort.

## When to Use

- Receiving feedback from a human partner or external reviewer
- Before implementing any review suggestion (especially if it seems unclear or wrong)
- NOT for general debugging or self-review

## Quick Reference

Response pattern:
1. **READ** — Complete feedback without reacting
2. **UNDERSTAND** — Restate requirement in own words (or ask)
3. **VERIFY** — Check against codebase reality
4. **EVALUATE** — Technically sound for THIS codebase?
5. **RESPOND** — Technical acknowledgment or reasoned pushback
6. **IMPLEMENT** — One item at a time, test each

**Forbidden responses:**
- "You're absolutely right!" / "Great point!" — performative, never use
- "Let me implement that now" — never before verification
- Any gratitude expression — actions speak; just fix it

**Unclear feedback:** Stop. Ask for clarification on ALL unclear items before implementing any. Partial understanding = wrong implementation.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Performative agreement | State requirement or just act |
| Blind implementation | Verify against codebase first |
| Implementing without testing | One item at a time, test each |
| Avoiding pushback | Technical correctness > comfort |
| Partial implementation | Clarify all items first |
| Can't verify, proceed anyway | State limitation, ask for direction |

Push back when suggestion breaks functionality, reviewer lacks context, violates YAGNI, or conflicts with prior architectural decisions. Use technical reasoning, not defensiveness.

See [reference.md](reference.md) for source-specific handling (human partner vs. external reviewers), YAGNI check procedure, implementation ordering, pushback technique, and real examples.
