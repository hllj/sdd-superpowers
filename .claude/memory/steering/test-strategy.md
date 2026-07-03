---
scope: test-strategy
loaded-by: sdd-plan, sdd-execute, sdd-review
---

# Test Strategy

## Test Framework
Bash — test scripts in `tests/hooks/` with a `run_all.sh` runner

## Test Levels
- Unit tests: per-hook bash scripts testing individual hook behaviours
- Integration tests: `run_all.sh` runs all hook test suites in sequence
- E2E tests: N/A — skills are prose; hooks are the executable boundary

## Coverage Expectations
Every hook change must have a corresponding test update. New acceptance criteria → new test assertions before implementation.

## Mocking Policy
Tests use fixture files (JSON inputs, stub memory dirs) — no external calls mocked since hooks are pure shell scripts
