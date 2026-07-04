---
scope: test-strategy
loaded-by: sdd-plan, sdd-execute, sdd-review
---

# Test Strategy

## Test Framework
Bash test suite: `tests/hooks/run_all.sh` — custom helpers in `tests/hooks/helpers.sh` with `assert_exit_zero`, `assert_contains`, `assert_empty`

## Test Levels
- Unit tests: each hook script in `scripts/hooks/` has a matching `tests/hooks/test_<name>.sh`
- Integration tests: `run_all.sh` runs the full suite end-to-end
- E2E tests: N/A — skill behavior is validated manually by invoking Claude Code

## Coverage Expectations
Every hook file in `scripts/hooks/` must have a corresponding test file. Gate hooks (deny-path) must have at least one negative-path test.

## Mocking Policy
Hook scripts are tested by piping fixture JSON from `tests/hooks/fixtures/` to the script stdin. No external mocking libraries.
