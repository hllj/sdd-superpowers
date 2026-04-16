---
name: sdd-specify
description: "Use when starting any new feature or product idea. Transforms a vague idea into a structured, executable PRD through iterative dialogue. MUST be run before sdd-plan."
---

# SDD: Specify

Turn ideas into precise, executable Product Requirements Documents (PRDs).

**Announce at start:** "I'm using the sdd-specify skill to create a feature specification."

**Core principle:** The specification is the source of truth. Code serves specifications — not the other way around. A spec written here will drive all downstream planning, research, and code generation.

<HARD-GATE>
Do NOT write any implementation code, scaffold any project, or make any architectural decisions until a spec is approved and written. This skill produces ONLY the specification. Implementation comes later.
</HARD-GATE>

## Output Location

Save the completed spec to: `specs/<NNN>-<feature-slug>/spec.md`

Where:
- `NNN` = next available feature number (scan `specs/` directory, pad to 3+ digits)
- `feature-slug` = kebab-case name derived from the idea

Example: `specs/003-user-authentication/spec.md`

## The Process

### Step 1: Scan Existing Specs

Before anything else:
1. Check the `specs/` directory for existing feature numbers
2. Determine the next available number
3. Check for related or overlapping specs that might affect scope

### Step 2: Understand the Idea

Ask clarifying questions **one at a time** to understand:

- **What problem** does this solve? Who experiences it?
- **Who are the users?** What do they want to accomplish?
- **What does success look like?** How do we know it works?
- **What are the constraints?** Performance, security, compliance, timeline?
- **What's out of scope?** What explicitly will NOT be included?
- **What already exists?** Related systems, APIs, or data this touches?

Prefer multiple-choice questions when the space is bounded. Ask only what you need — stop when you have enough to write a complete spec.

### Step 3: Propose the Spec Structure

Before writing, present a brief outline:
- The problem statement and user need
- 2-3 key user stories
- Proposed acceptance criteria scope
- Any `[NEEDS CLARIFICATION]` items you've identified

Get user approval on the structure before writing the full document.

### Step 4: Write the Specification

Generate `specs/<NNN>-<feature-slug>/spec.md` using this template:

```markdown
# Feature NNN: <Feature Name>

**Status:** Draft
**Created:** YYYY-MM-DD
**Branch:** `NNN-<feature-slug>`

---

## Problem Statement

<Clear description of the problem being solved. Focus on the WHY — what user pain or business need drives this? 2-4 sentences.>

## Goals

- <Specific, measurable goal>
- <Specific, measurable goal>

## Non-Goals

- <What this feature explicitly does NOT do>
- <Scope boundary that prevents scope creep>

## Users and Context

**Primary users:** <Who uses this feature>
**Usage context:** <When and how they use it>
**User mental model:** <What users expect, their vocabulary>

## User Stories

### Story 1: <Name>
**As a** <type of user>
**I want to** <perform some action>
**So that** <I achieve some goal>

**Acceptance criteria:**
- [ ] <Specific, testable outcome>
- [ ] <Specific, testable outcome>
- [ ] <Specific, testable outcome>

### Story 2: <Name>
...

## Functional Requirements

### FR-1: <Requirement Name>
<Description of what the system must do. Focus on WHAT, not HOW.>

**Must:**
- <Specific behavior>

**Must not:**
- <Explicit prohibition>

### FR-2: <Requirement Name>
...

## Non-Functional Requirements

### Performance
- <Response time targets, throughput requirements>

### Security
- <Authentication, authorization, data protection requirements>

### Reliability
- <Availability, error handling, recovery requirements>

## Error Scenarios

| Scenario | Expected Behavior |
|----------|-------------------|
| <What goes wrong> | <What the system should do> |

## Open Questions

- [NEEDS CLARIFICATION: <specific question about ambiguous requirement>]
- [NEEDS CLARIFICATION: <decision needed before implementation>]

## Out of Scope (Future Considerations)

- <Feature that was discussed but explicitly deferred>
```

### Step 5: Self-Review the Spec

After writing, review the spec yourself (do NOT delegate this):

**Coverage check:** Does every user story have acceptance criteria? Does every functional requirement have clear must/must-not statements?

**Placeholder scan:** Search for "TODO", "TBD", "etc.", vague phrases like "appropriate handling" or "as needed." Replace with specifics or add `[NEEDS CLARIFICATION]`.

**Abstraction check:** Does any requirement mention implementation technology (React, PostgreSQL, REST)? If so, move it to Open Questions — specs describe WHAT, not HOW.

**Testability check:** Can each acceptance criterion be verified with a concrete test? If not, rewrite it.

Fix issues inline. Do not move on until the spec passes this review.

### Step 6: Get User Approval

Present the spec to the user and ask for explicit approval:

> "Spec saved to `specs/NNN-feature-slug/spec.md`. Please review — does this capture your intent correctly? Any requirements missing or misstated?"

If changes requested: update the spec and re-review.
If approved: proceed to handoff.

### Step 7: Handoff

After approval:

> "Specification complete. Next steps in the SDD workflow:
>
> **Option A — Research first (recommended for complex features):**
> Use `sdd-research` to investigate technology options, performance implications, and constraints before planning.
>
> **Option B — Plan directly:**
> Use `sdd-plan` to create the implementation plan from this spec.
>
> Which would you like?"

## Rules

**Focus on WHAT, not HOW:**
- ✅ "Users must be able to filter results by date range"
- ❌ "Use a date picker component from the UI library"

**Mark ambiguity explicitly:**
- ✅ `[NEEDS CLARIFICATION: should this work offline?]`
- ❌ Assume offline is not required and skip it

**Write testable requirements:**
- ✅ "Search returns results within 200ms for queries under 1000 characters"
- ❌ "Search should be fast"

**Don't guess on business decisions:**
- If the user hasn't specified a behavior, mark it `[NEEDS CLARIFICATION]`
- Make no assumptions about authentication method, data retention, pricing, or access control

## No Placeholders

These are spec failures — never appear in a finished spec:
- "TBD", "TODO", "as appropriate", "etc."
- "Handle errors gracefully" (without specifying what graceful means)
- "Standard validation" (without specifying the rules)
- "Similar to existing feature" (name the feature and be explicit)
- Requirements that cannot be converted to a passing/failing test
