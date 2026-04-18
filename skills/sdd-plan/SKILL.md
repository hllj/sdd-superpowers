---
name: sdd-plan
description: Use when a feature spec exists and needs to become a technical implementation plan
---

# SDD: Plan

**Announce at start:** "I'm using the sdd-plan skill to create the implementation plan."

## Overview

Transform a feature specification into a complete, executable implementation plan. Every architecture choice, data model, and API contract must be justified by a requirement in `spec.md` — if a decision has no spec backing, question whether it belongs.

<HARD-GATE>
Do NOT start planning until ALL of the following are true:
1. `spec.md` exists at `docs/specs/NNN-slug/spec.md`
2. The user has explicitly approved the spec in this session
3. Zero `[NEEDS CLARIFICATION]` items remain in the spec
4. `spec.md` status is `Approved` (not `Draft`)

If any condition fails: stop. If unsure whether the spec is ready, run `sdd-superpowers:sdd-review` (Mode A) first.
</HARD-GATE>

## Scope Check

If the spec covers multiple independent subsystems, suggest breaking it into sub-specs before planning. Each plan should produce working, testable software on its own.

## When to Use

- `spec.md` exists and the user has explicitly approved it
- No `[NEEDS CLARIFICATION]` items remain in the spec
- Optionally: `research.md` exists with tech investigation results
- NOT before a spec exists — run `sdd-superpowers:sdd-specify` first
- NOT when spec has unresolved open questions — resolve them first

## Quick Reference

Outputs produced by sdd-plan:

| Artifact | Location | Required? |
|----------|----------|-----------|
| `plan.md` | `docs/specs/NNN-slug/plan.md` | Always |
| `data-model.md` | `docs/specs/NNN-slug/data-model.md` | If feature involves data storage |
| `contracts/api.md` | `docs/specs/NNN-slug/contracts/api.md` | If feature exposes an API |
| `quickstart.md` | `docs/specs/NNN-slug/quickstart.md` | Recommended |

Plan structure: Goal → Architecture → Tech Stack → File Structure → Complexity Tracking → Phases (contracts-first → implementation → integration verification).

Pre-implementation gates checked before planning: Simplicity Gate (≤3 components), Anti-Abstraction Gate (no unnecessary wrappers), Integration-First Gate (contracts before code).

See [reference.md](reference.md) for pre-implementation gate checklists, full plan template, data-model and contracts templates, self-review checklist, and verification gate.

## File Structure

Before defining tasks, map every file that will be created or modified and its single responsibility. This informs task decomposition — each task should produce self-contained changes.

- Design units with clear boundaries and one responsibility per file
- Files that change together should live together
- In existing codebases, follow established patterns

## No Placeholders

These are plan failures — never write them:
- "TBD", "TODO", "implement later", "fill in details"
- "Add appropriate error handling" / "handle edge cases" (without code)
- "Write tests for the above" (without actual test code)
- "Similar to Phase N" — repeat the code; phases may be read out of order
- Steps that describe what to do without showing how (code blocks required for every code step)
- References to types or functions not defined in any phase

## Self-Review

After writing the complete plan, check inline — no subagent needed:

1. **Spec coverage** — every FR has a phase that implements it; list any gaps
2. **Placeholder scan** — search for patterns from "No Placeholders" above; fix any found
3. **Type consistency** — function names and signatures match across all phases

Fix issues before presenting to user.

## Execution Handoff

After saving `plan.md`, offer:

> "Plan complete. Next: run `sdd-superpowers:sdd-tasks` to generate the executable task list."
