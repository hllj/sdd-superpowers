---
name: sdd-specify
description: Use when a user describes a new feature, idea, or problem without an existing spec — before any planning, research, or code
---

# SDD: Specify

**Announce at start:** "I'm using the sdd-specify skill to create a feature specification."

## Overview

Turn ideas into precise, executable Product Requirements Documents (PRDs). The specification is the source of truth — code serves specs, not the other way around. A spec written here drives all downstream planning and code generation.

<HARD-GATE>
Do NOT write any implementation code, scaffold any project, or make any architectural decisions until a spec is approved and written. This skill produces ONLY the specification.
</HARD-GATE>

## When to Use

- A new feature, idea, or problem needs to be formalized
- `sdd-superpowers:sdd-brainstorm` has completed and `design.md` exists (fast-path)
- NOT when spec already exists — go to `sdd-superpowers:sdd-plan` or `sdd-superpowers:sdd-research`
- NOT when the idea is still fuzzy — run `sdd-superpowers:sdd-brainstorm` first

## Quick Reference

Spec output: `docs/specs/NNN-<slug>/spec.md`

Spec sections: Problem Statement → Goals → Non-Goals → Users and Context → User Stories (with acceptance criteria) → Functional Requirements → Non-Functional Requirements → Error Scenarios → Open Questions → Out of Scope

**Fast-path:** if `design.md` exists from `sdd-superpowers:sdd-brainstorm`, Steps 2–3 are skipped — the design is formalized directly.

Key rules:
- Requirements describe WHAT, never HOW (no technology mentions)
- Every acceptance criterion must be testable (convertible to a passing/failing test)
- Never leave vague placeholders — use `[NEEDS CLARIFICATION]` instead

See [reference.md](reference.md) for the full process (Steps 1–8), spec.md template, self-review checklist, placeholder anti-patterns, and handoff options.

## Remember

- Requirements describe WHAT, never HOW — no technology mentions in the spec
- Every acceptance criterion must be testable (convertible to a passing/failing test)
- Use `[NEEDS CLARIFICATION]` over vague text — never leave ambiguity unmarked

## Self-Review

After writing the spec, check inline — no subagent needed:

1. **Testability** — every acceptance criterion can become a passing/failing test
2. **No placeholders** — no vague text; `[NEEDS CLARIFICATION]` used where needed
3. **Goals vs Non-Goals** — each item is in the right section
4. **Open Questions** — all unknowns explicitly captured

Fix issues before presenting the spec to the user.

After the user explicitly approves the spec, update `Status: Draft` → `Status: Approved` in spec.md before handing off to sdd-plan.
