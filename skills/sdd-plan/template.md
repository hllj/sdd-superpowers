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

- [ ] Write contract test for <API endpoint/event>: verify request shape, response shape, error codes (targets AC-N.M)
- [ ] Run contract tests — confirm they FAIL (feature not implemented yet)
- [ ] Commit: `test: add contract tests for <feature>`

### 0.2 Write Integration Tests

- [ ] Write integration test for <Story 1 acceptance criterion>
- [ ] Run — confirm FAIL
- [ ] Commit: `test: add integration tests for <feature>`

---

## Phase 1: <First Component>

**Implements:** FR-1, FR-2 | **Satisfies:** AC-1.1, AC-1.2
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

**Implements:** All FRs | **Satisfies:** All ACs
- [ ] Run full test suite: `<exact command>`
- [ ] Verify all acceptance criteria from spec manually
- [ ] Commit: `feat: complete <feature name>`

---

## Quickstart Validation

<Concrete sequence of commands or UI steps that confirms the feature works end-to-end>
