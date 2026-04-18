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

If any condition fails: stop. If unsure whether the spec is ready, run `sdd-superpowers:sdd-review` (Mode A) first.
</HARD-GATE>

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
