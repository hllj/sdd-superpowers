---
name: sdd-brainstorm
description: Use when an idea is fuzzy, exploratory, or has competing approaches that need design exploration before specification
---

# SDD: Brainstorm

**Announce at start:** "I'm using the sdd-brainstorm skill to explore this idea before specifying."

## Overview

Turn fuzzy ideas into validated designs through collaborative dialogue. Produces a `design.md` that feeds directly into `sdd-superpowers:sdd-specify` as a fast-path input, skipping questions already answered here.

<examples>
<example>
<context>User says "I'm thinking we might want some kind of notification system — not sure if push, email, or in-app."</context>
<correct>Invoke sdd-brainstorm. The idea has competing approaches and unresolved trade-offs — explore before specifying.</correct>
<incorrect>Jump straight to sdd-specify with "notification system" as the feature — the competing approaches will surface as [NEEDS CLARIFICATION] items that block the spec.</incorrect>
</example>
<example>
<context>User says "I want to add dark mode, it's clear: a CSS variable toggle. Can we just spec it?"</context>
<correct>If the approach is genuinely settled, go directly to sdd-specify. Brainstorm is for fuzzy ideas — not every idea needs it.</correct>
<incorrect>Invoke sdd-brainstorm for every idea regardless of fuzziness — clear ideas waste brainstorm overhead and slow delivery.</incorrect>
</example>
</examples>

<HARD-GATE>
Do NOT invoke sdd-specify, sdd-plan, or any implementation skill until the user has approved the design. Do NOT write code. This skill produces ONLY a design document.
</HARD-GATE>

## When to Use

- The idea is vague, exploratory, or has competing approaches ("I'm thinking about…", "what if we…")
- Multiple directions are possible and trade-offs need exploring
- NOT when the idea is already clear and concrete — go straight to `sdd-superpowers:sdd-specify`
- NOT when another brainstorm has already produced a `design.md` — skip to `sdd-superpowers:sdd-specify`

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
| 7 | Invoke `sdd-superpowers:sdd-specify` with design doc path |

Key principles: one question per message, YAGNI ruthlessly, always 2-3 approaches before settling, decompose multi-subsystem ideas before brainstorming any single piece.

See [reference.md](reference.md) for full checklist, process flow diagram, design.md template, spec review loop procedure, and visual companion guide.

## Constraints

- Does NOT invoke sdd-specify, sdd-plan, or any implementation skill until the user has explicitly approved the design
- Does NOT write code — this skill produces only design.md
- Does NOT produce a spec — design.md feeds into sdd-specify; they are different artifacts

## Error Handling

- **design.md already exists from a prior brainstorm session**: Skip directly to `sdd-superpowers:sdd-specify` fast-path — do not re-run brainstorm.
- **User wants to jump straight to implementation**: Stop. Redirect through sdd-specify → sdd-plan → sdd-tasks first; implementation without a spec has no source of truth.
- **User requests gate bypass**: The gate is "no sdd-specify or implementation before design approval." Explain that without an approved design, the spec will reflect the first approach considered rather than the best one. Offer to complete the design review — it is a short approval step.
