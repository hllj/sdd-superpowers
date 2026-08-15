# Implementation Plan: <Feature Name>

**Spec:** docs/specs/<NNN>-<feature-slug>/spec.md
**Decisions:** docs/adr/<NNN>-*.md (if applicable)
**Created:** YYYY-MM-DD

---

## Goal

<One sentence: what working software this plan produces.>

---

## Phase 0: Contracts and Tests First

**Implements:** <FRs> | **Satisfies:** <ACs>
**Files:** `path/to/contract-test.ts`, `path/to/integration-test.ts`

<1-3 sentence goal: what this phase locks down before any implementation exists.>

- [ ] Write contract test for <API endpoint/event>: verify request shape, response shape, error codes
  <complete test code>
- [ ] Run contract tests — confirm they FAIL (feature not implemented yet)
- [ ] Commit: `test: add contract tests for <feature>`

---

## Phase 1: <First Component>

**Implements:** FR-1, FR-2 | **Satisfies:** AC-1.1, AC-1.2
**Files:** `src/path/file.ts`, `tests/path/test.ts`

<1-3 sentence goal: what this phase accomplishes and why it belongs here.>

- [ ] Write unit test:
  <complete test code>
- [ ] Run: `<exact test command>` — expect: FAIL
- [ ] Implement:
  <complete implementation code>
- [ ] Run: `<exact test command>` — expect: PASS
- [ ] Commit: `feat: implement <unit>`

> **Complexity note** (only if a Pre-Implementation Gate failed for this phase): Gate: <which gate>. Violation: <what complexity was added>. Justification: <specific spec requirement that forced it>.

---

## Phase N: Integration Verification

**Implements:** All FRs | **Satisfies:** All ACs

- [ ] Run full test suite: `<exact command>`
- [ ] Verify all acceptance criteria from spec manually
- [ ] Commit: `feat: complete <feature name>`

---

## Quickstart Validation

<Concrete sequence of commands or UI steps that confirms the feature works end-to-end>
