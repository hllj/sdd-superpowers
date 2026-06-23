---
scope: test-strategy
loaded-by: sdd-plan, sdd-execute, sdd-review
---

# Test Strategy

## Test Framework
Smoke scenarios in `docs/specs/NNN-feature/quickstart.md` — manual or subagent-executed scenario walkthroughs (no automated test runner detected)

## Test Levels
- Unit tests: skill reference.md step verification (read the file, confirm the block is present)
- Integration tests: smoke scenarios in quickstart.md — invoke the skill end-to-end and observe output
- E2E tests: full SDD workflow walkthrough from sdd-init to sdd-review on a real project

## Coverage Expectations
Each feature spec must have at least 4 smoke scenarios: happy path, fast/flag variant, error detection, and skill-loading integration

## Mocking Policy
No mocks — skills are invoked against real project state; test scenarios use real file reads and subagent dispatch
