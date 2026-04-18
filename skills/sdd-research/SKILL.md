---
name: sdd-research
description: Use when a spec has unresolved technology choices, performance targets, security requirements, or external integrations that need investigation before planning
---

# SDD: Research

**Announce at start:** "I'm using the sdd-research skill to gather technical context for this feature."

## Overview

Gather critical technical context before committing to an implementation plan. Research agents investigate options so the plan is grounded in real-world constraints — library compatibility, performance characteristics, security implications — not assumptions.

## When to Use

Run when the feature involves:
- **Library choices** — multiple viable options exist and trade-offs are non-obvious
- **Performance requirements** — spec has measurable performance criteria to validate
- **Security requirements** — authentication, authorization, data protection, compliance
- **External integrations** — third-party APIs, databases, infrastructure services
- **Architectural risk** — hidden complexity or failure modes possible

Skip for purely UI/UX features with no new dependencies or infrastructure.

## Quick Reference

Output: `docs/specs/<NNN>-<feature-slug>/research.md`

Research document sections:
- **Summary of Findings** — 3-5 bullet points that will affect implementation decisions
- **Per question** — Context → Findings (Option A/B/C with pros/cons) → Recommendation
- **Resolved Clarifications** — `[NEEDS CLARIFICATION]` items from spec that research answered
- **Remaining Open Questions** — `[DECISION NEEDED]` items requiring human decision
- **Constraints Discovered** — technical/organizational constraints the plan must respect

After research, update `spec.md` to replace resolved `[NEEDS CLARIFICATION]` markers with concrete requirements.

See [reference.md](reference.md) for the full investigation procedure, research.md template, per-domain investigation guides (library comparison, performance, security, integration), and quality standards.
