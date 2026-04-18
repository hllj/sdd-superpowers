# SDD Plan: Full Process Reference

> Complete planning procedure, templates, and quality rules. See [SKILL.md](SKILL.md) for the summary.

## Prerequisites

Before planning:
1. `docs/specs/<NNN>-<feature-slug>/spec.md` must exist and be approved
2. `docs/specs/<NNN>-<feature-slug>/research.md` should exist if research was done
3. No `[NEEDS CLARIFICATION]` markers should remain in the spec

## Step 1: Read All Inputs

Read in order:
1. `docs/specs/<NNN>-<feature-slug>/spec.md`
2. `docs/specs/<NNN>-<feature-slug>/research.md` (if exists)
3. Any existing project architecture docs or CLAUDE.md

Map each functional requirement to a technical component. If a requirement has no obvious technical home, flag it before planning.

## Step 2: Pre-Implementation Gates

Validate these gates. Document any failures in the plan's "Complexity Tracking" section.

**Simplicity Gate:**
- [ ] Can this be implemented with ≤3 major components/modules?
- [ ] Are we building only what the spec requires (no future-proofing)?
- [ ] If adding a new dependency, is it truly necessary?

**Anti-Abstraction Gate:**
- [ ] Are we using framework features directly rather than wrapping them?
- [ ] Is there a single, canonical model representation (no parallel DTO/entity/view model chains)?

**Integration-First Gate:**
- [ ] Are API contracts defined before implementation starts?
- [ ] Are contract tests written before implementation code?

If a gate fails and the complexity is genuinely justified, document why in "Complexity Tracking."

## Step 3: Write Supporting Documents

Write these BEFORE the main plan, since the plan references them.

### `data-model.md` (if applicable)

```markdown
# Data Model: <Feature Name>

## Entities

### <EntityName>

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | uuid | PK, not null | Primary identifier |
| <field> | <type> | <constraints> | <purpose> |

**Indexes:** <list indexed fields and why>
**Relationships:** <foreign keys and cardinality>
**Spec requirement:** <FR-X that drives this entity>

---
```

### `contracts/api.md` (if applicable)

```markdown
# API Contracts: <Feature Name>

## <VERB> /path/to/endpoint

**Purpose:** <What this endpoint does>
**Spec requirement:** <FR-X, Story Y>

### Request

{
  "field": "type — description"
}

### Response (200 OK)

{
  "field": "type — description"
}

### Error Responses

| Status | Condition | Body |
|--------|-----------|------|
| 400 | <validation failure> | {"error": "message"} |
| 404 | <not found condition> | {"error": "Not found"} |
| 409 | <conflict condition> | {"error": "message"} |
```

## Step 4: Write the Main Plan

Generate `docs/specs/<NNN>-<feature-slug>/plan.md`:

```markdown
# Implementation Plan: <Feature Name>

> **For agentic workers:** Use sdd-tasks to generate an executable task list from this plan.

**Spec:** docs/specs/<NNN>-<feature-slug>/spec.md
**Research:** docs/specs/<NNN>-<feature-slug>/research.md (if applicable)
**Created:** YYYY-MM-DD

---

## Goal

<One sentence: what working software this plan produces.>

## Architecture

<2-4 sentences describing the technical approach. Reference key decisions from research.md. Every sentence should connect to a spec requirement.>

## Tech Stack

| Layer | Technology | Justification |
|-------|-----------|---------------|
| <layer> | <tech> | <spec/research rationale> |

## File Structure

- `src/path/to/file.ts` — <responsibility>
- `src/path/to/other.ts` — <responsibility>
- `tests/path/to/test.ts` — <what it tests>

## Complexity Tracking

<If any Pre-Implementation Gate failed, document here:>
- **Gate:** <which gate>
- **Violation:** <what complexity was added>
- **Justification:** <specific spec requirement that forced it>

(Empty section = all gates passed)

---

## Phase 0: Contracts and Tests First

**Principle:** Define contracts and write tests before any implementation code.

### 0.1 Write Contract Tests

- [ ] Write contract test for <API endpoint/event>: verify request shape, response shape, error codes
- [ ] Run contract tests — confirm they FAIL (feature not implemented yet)
- [ ] Commit: `test: add contract tests for <feature>`

### 0.2 Write Integration Tests

- [ ] Write integration test for <Story 1 acceptance criterion>
- [ ] Run — confirm FAIL
- [ ] Commit: `test: add integration tests for <feature>`

---

## Phase 1: <First Component>

**Implements:** FR-1, FR-2
**Files:** `src/path/file.ts`, `tests/path/test.ts`

### 1.1 <Specific Unit>

- [ ] Write unit test:
  <complete test code>
- [ ] Run: `<exact test command>` — expect: FAIL
- [ ] Implement:
  <complete implementation code>
- [ ] Run: `<exact test command>` — expect: PASS
- [ ] Commit: `feat: implement <unit>`

---

## Phase N: Integration Verification

- [ ] Run full test suite: `<exact command>`
- [ ] Verify all acceptance criteria from spec manually
- [ ] Commit: `feat: complete <feature name>`

---

## Quickstart Validation

<Concrete sequence of commands or UI steps that confirms the feature works end-to-end>
```

## Step 5: Self-Review

After writing all documents, check the plan against the spec:

**Spec coverage:** For each functional requirement in the spec, can you point to a specific phase/task in the plan that implements it? List gaps.

**Traceability check:** Does every technical decision have a spec requirement driving it? Flag decisions without spec backing.

**No-placeholder scan:** Find and eliminate any "TBD", "implement as needed", "handle errors", "similar to above" in the plan.

**Code completeness:** Every step that creates or modifies code must show actual code, not pseudocode or descriptions.

**Test-first verification:** Does every implementation step have a prior failing test step?

Fix issues inline before presenting to user.

## Step 6: Verification Gate

Before claiming the plan is ready, confirm:
- [ ] Every FR in spec has a corresponding plan phase
- [ ] Every phase header lists the FR/story it implements
- [ ] Zero placeholders remain
- [ ] Pre-implementation gates documented
- [ ] All code in steps is complete, not pseudocode

**Do not say "plan complete" without passing this gate.**

## Step 7: Handoff

> "Implementation plan complete. Artifacts:
> - `docs/specs/NNN-feature/plan.md` — main plan
> - `docs/specs/NNN-feature/data-model.md` (if created)
> - `docs/specs/NNN-feature/contracts/` (if created)
>
> **Next steps:**
> 1. Run `sdd-superpowers:sdd-review` (spec mode) to validate plan-spec alignment before execution
> 2. Run `sdd-superpowers:sdd-tasks` to generate a flat, executable task list
> 3. Run `sdd-superpowers:sdd-execute` to implement with subagent dispatch and two-stage review"

## Plan Quality Rules

**Every step is one action (2-5 min):**
- "Write the failing test" — one step
- "Run it to confirm it fails" — one step
- "Write minimal implementation" — one step
- "Run tests to confirm pass" — one step
- "Commit" — one step

**Complete code in every step:** Show the entire function/test, not just changed lines.

**Exact commands with expected output:**
- `pytest tests/feature/test_auth.py::test_login -v`
- Expected: `PASSED` (not "tests should pass")

**Requirements trace in every phase header:**
- `**Implements:** FR-1, FR-2, Story 3`
