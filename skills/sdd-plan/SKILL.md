---
name: sdd-plan
description: Use when a feature spec exists and needs to become a technical implementation plan
---

# SDD: Plan

**Announce at start:** "I'm using the sdd-plan skill to create the implementation plan."

## Overview

Transform a feature specification into a complete, executable implementation plan. Every architecture choice, data model, and API contract must be justified by a requirement in `spec.md` — if a decision has no spec backing, question whether it belongs.

## When to Use

- A `spec.md` exists and has been approved (no `[NEEDS CLARIFICATION]` remaining)
- Optionally: `research.md` exists with tech investigation results
- NOT before a spec exists — run `sdd-specify` first
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
