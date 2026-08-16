# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

This is a Claude Code plugin — skills are Markdown, hooks are Bash. There is no build step or package manager; "testing" this repo means running the hook test suite and validating skill/config structure.

```bash
# Run the full hook test suite (all tests/hooks/test_*.sh)
bash tests/hooks/run_all.sh

# Run a single hook test
bash tests/hooks/test_stop.sh

# Lint skill structure (SKILL.md ≤500 lines, required <examples> blocks, Phase 1 example-count rules)
bash tests/016-verify-skill-structure.sh

# Validate JSON config files (must be strict JSON — no trailing commas/comments)
jq . hooks/hooks.json
jq . .claude-plugin/plugin.json
jq . .claude-plugin/marketplace.json

# Shell-lint a hook script (if shellcheck is installed)
shellcheck --severity=warning scripts/hooks/<script>.sh
```

Each `tests/hooks/test_*.sh` sources `tests/hooks/helpers.sh` for assertions and must end by calling `summarize`; JSON fixtures live in `tests/hooks/fixtures/`, never inlined.

## Architecture

**Plugin anatomy:** `.claude-plugin/plugin.json` and `marketplace.json` declare the plugin; `skills/*/SKILL.md` are the loadable skill instructions (plus `agents/code-reviewer.md`); `hooks/hooks.json` registers lifecycle hooks that shell out to scripts in `scripts/hooks/`, with shared detection logic in `scripts/hooks/lib/detect-active-spec.sh`. All hook and skill paths use `${CLAUDE_PLUGIN_ROOT}` rather than hardcoded paths.

**Hook lifecycle** (see `hooks/hooks.json` and `scripts/hooks/`): every hook first calls `detect_sdd_project` and no-ops outside a project with a `docs/specs/` tree.
- `SessionStart` → `session-start.sh` injects `foundation.md`, `MEMORY.md`, and the active spec into context.
- `PreToolUse` on `Write` → `pre-write-plan-gate.sh` blocks writing `plan.md` unless a sibling `spec.md` has `Status: Approved`; `pre-write-edit-state.sh` (also on `Edit`) records that a write happened this session.
- `PostToolUse` on `Write` → `post-write-memory-validate.sh` checks memory files have valid frontmatter and an index entry in `MEMORY.md`.
- `SubagentStart` → `subagent-start.sh` injects the active spec into dispatched subagents, which otherwise start cold.
- `Stop` → `stop.sh` emits an end-of-session reminder (session-wrap, verification) only if files were written this session.

**SDD skill lifecycle:** `sdd-workflow` (entry point for every conversation) routes to `sdd-init` (bootstraps a new project's foundation/steering/rules) or the feature pipeline: `sdd-brainstorm`/`sdd-specify` → `sdd-plan` → `sdd-execute` (invokes `subagent-driven-development`, which dispatches implementer subagents that each invoke `test-driven-development`) → `sdd-review` → `finishing-a-development-branch`. Mid-flight spec changes go through `sdd-spec-update`. `sdd-tasks` is retired — `sdd-execute` now goes straight from plan to implementation.

**Three-tier memory**, all under `.claude/memory/`: `foundation.md` (mission + principles, loaded every session), `steering/*.md` (tech-stack/test-strategy/conventions/team-practices — each has a `loaded-by` frontmatter field naming which skills pull it in), and `MEMORY.md` (index of ad hoc memory entries). This repo dogfoods the plugin on itself — its own `.claude/memory/` and `docs/specs/` are real SDD artifacts, not fixtures.

<!-- sdd-init: generated -->
## Working in This Project

For small tasks (typo fixes, config tweaks, answering questions, quick edits) —
work directly without ceremony.

For feature development, new functionality, or any change with meaningful scope —
follow the SDD workflow: invoke `sdd-superpowers:sdd-workflow` to get started.

Use judgment: if a task could break something or spans multiple files, SDD applies.

## Memory

Memory lives in `.claude/memory/` — see `.claude/memory/MEMORY.md` for the index.
Project identity is in `.claude/memory/foundation.md`.
Steering files in `.claude/memory/steering/` are loaded by skills when relevant.

**At session end:** Before closing a conversation, invoke `sdd-superpowers:session-wrap`.
It scans the session for memory candidates (feedback, project, user, reference) and
lesson candidates (decisions, surprises, failed approaches), then writes approved entries
to `.claude/memory/` and `docs/lessons/`. Takes under 5 minutes; saves what a fresh
session cannot rediscover from code or git history alone.

## Hard Gates (when following SDD)

- NO PLAN without an approved spec
- NO TASKS without a plan
- NO CODE without a prior failing test
- NO COMPLETION CLAIM without fresh verification evidence
