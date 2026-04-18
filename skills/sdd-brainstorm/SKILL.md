---
name: sdd-brainstorm
description: Use when an idea is fuzzy, exploratory, or has competing approaches — before sdd-specify, when you need to explore 2-3 directions and agree on a design first
---

# SDD: Brainstorm

**Announce at start:** "I'm using the sdd-brainstorm skill to explore this idea before specifying."

## Overview

Turn fuzzy ideas into validated designs through collaborative dialogue. Produces a `design.md` that feeds directly into `sdd-specify` as a fast-path input, skipping questions already answered here.

<HARD-GATE>
Do NOT invoke sdd-specify, sdd-plan, or any implementation skill until the user has approved the design. Do NOT write code. This skill produces ONLY a design document.
</HARD-GATE>

## When to Use

- The idea is vague, exploratory, or has competing approaches ("I'm thinking about…", "what if we…")
- Multiple directions are possible and trade-offs need exploring
- NOT when the idea is already clear and concrete — go straight to `sdd-specify`
- NOT when another brainstorm has already produced a `design.md` — skip to `sdd-specify`

## Quick Reference

Brainstorm outputs one artifact: `docs/specs/NNN-<feature-slug>/design.md`

| Step | Action |
|------|--------|
| 1 | Explore project context; check existing specs |
| 2 | Ask clarifying questions (one at a time) |
| 3 | Propose 2-3 approaches with trade-offs + recommendation |
| 4 | Present design in sections, get approval per section |
| 5 | Write `design.md`, run spec-review loop (max 3 iterations) |
| 6 | User reviews written design |
| 7 | Invoke `sdd-specify` with design doc path |

Key principles: one question per message, YAGNI ruthlessly, always 2-3 approaches before settling, decompose multi-subsystem ideas before brainstorming any single piece.

See [reference.md](reference.md) for full checklist, process flow diagram, design.md template, spec review loop procedure, and visual companion guide.
