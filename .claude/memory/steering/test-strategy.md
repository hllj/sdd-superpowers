---
scope: test-strategy
loaded-by: sdd-plan, sdd-execute, sdd-review
---

# Test Strategy

## Test Framework
Custom bash test harness — `tests/hooks/helpers.sh` provides `assert_contains`, `assert_empty`, `assert_equals`; each hook has a dedicated test file; `tests/hooks/run_all.sh` runs all suites

## Test Levels
- Unit tests: each hook script tested in isolation with fixture temp directories
- Integration tests: `run_all.sh` verifies all 9 hook scripts together; quickstart scenarios in spec verify end-to-end hook behavior
- E2E tests: N/A — skill behavior is verified by sdd-review Mode B coverage matrix, not automated

## Coverage Expectations
Every hook script must have a corresponding test file in `tests/hooks/`. Every new AC must have a test that goes RED before implementation and GREEN after.

## Mocking Policy
Real filesystem fixtures only — no mocked file I/O. External commands (git, jq) are real binaries. Test isolation via `mktemp -d` temp directories cleaned up after each test.
