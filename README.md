# SDD Superpowers

A Claude Code plugin implementing **Specification-Driven Development (SDD)** — a methodology where specifications are the source of truth and code is their generated expression.

Built on the [superpowers](https://github.com/obra/superpowers) framework: skills enforce discipline through hard gates, iron laws, and verification requirements.

## Installation

```bash
# From superpowers-marketplace
/plugin install sdd-superpowers@superpowers-marketplace

# From claude-plugins-official
/plugin install sdd-superpowers
```

## What Is SDD?

SDD inverts the traditional relationship between specs and code. Instead of writing code and hoping it matches intent, you write precise specifications first, then generate code from them. The spec is the authoritative artifact; code is its expression in a particular language and framework.

**Key principles:**
- **Specifications as lingua franca** — PRD and implementation plan are the primary artifacts
- **Executable specifications** — specs are precise enough to generate working, testable code
- **Test-first always** — no implementation code without a prior failing test
- **Traceability** — every technical decision traces back to a specific requirement
- **Evidence before assertions** — no completion claims without running verification commands

## The Four Hard Gates

```
NO PLAN without an approved spec
NO TASKS without a plan
NO CODE without a prior failing test
NO COMPLETION CLAIM without fresh verification evidence
```

## Skills

| Skill | When to Use |
|-------|-------------|
| `sdd-workflow` | Start of any conversation — establishes mandatory skill invocation |
| `sdd-brainstorm` | Idea is fuzzy/exploratory → dialogue + 2-3 approaches + design.md |
| `sdd-specify` | Idea is clear, or design.md exists → structured PRD (spec.md) |
| `sdd-research` | Unresolved tech choices, performance/security requirements before planning |
| `sdd-plan` | Spec exists → architecture, contracts, data models, test-first plan |
| `sdd-tasks` | Plan exists → flat executable task list with parallelization hints |
| `sdd-execute` | Tasks exist → invokes `subagent-driven-development` to orchestrate per-task subagents with spec-compliance + code-quality review |
| `sdd-spec-update` | Change or addition to an approved spec → classify impact (PATCH/MINOR/MAJOR), version spec, propagate downstream |
| `sdd-review` | Spec completeness check (pre-plan) or implementation alignment (post-execute) |

## Workflow

```
Idea (fuzzy)                    Idea (clear)
 │                               │
 ▼                               │
sdd-brainstorm ──────────────────┤
 │  dialogue + 2-3 approaches    │
 │  design.md + spec-review      │
 │                               │
 └───────────────────────────────┘
                                 │
                                 ▼
sdd-specify ──────────────────► docs/specs/NNN-feature/spec.md
                                 + feature branch created
 │
 ▼
sdd-plan ─────────────────────► docs/specs/NNN-feature/plan.md
                                 docs/specs/NNN-feature/data-model.md
                                 docs/specs/NNN-feature/contracts/
 │
 ▼
sdd-tasks ────────────────────► docs/specs/NNN-feature/tasks.md
 │
 ▼
sdd-execute ──────────────────► Implementation with per-task subagents
 │    ▲                          Spec-compliance review after each task
 │    │ (mid-flight change)      Code-quality review after each task
 │  sdd-spec-update ────────────────► classify PATCH/MINOR/MAJOR
 │    │                          version spec, propagate downstream
 │    └── resume execution
 │
 ▼
sdd-review ───────────────────► Coverage matrix + test verification
 │
 ▼
finishing-a-development-branch ──► merge / PR / keep / discard
```

## Quick Start

```bash
# Fuzzy idea path:
# 1. Invoke sdd-brainstorm with your idea
# 2. Answer questions, pick from 2-3 approaches, approve design
# 3. sdd-brainstorm automatically invokes sdd-specify (fast-path)

# Clear idea path:
# 1. Use sdd-specify to create a spec
# 2. Use sdd-plan to plan the feature
# 3. Use sdd-tasks to generate the task list
# 4. Use sdd-execute to implement it
#    (if requirements change mid-flight: use sdd-spec-update first)
# 5. Use sdd-review to validate the implementation
```

## Bundled Support Skills

These skills are invoked at specific SDD workflow points:

| Situation | Skill |
|-----------|-------|
| Task fails or behavior unexpected | `systematic-debugging` |
| About to claim anything is complete | `verification-before-completion` |
| All tasks done, tests passing | `finishing-a-development-branch` |
| Any git operation — branches, commits, convention | `using-git` |
| At a phase boundary during execution | `requesting-code-review` |
| Implementing fixes after review feedback | `receiving-code-review` |
| Dispatching 2+ independent tasks concurrently | `dispatching-parallel-agents` |
| Executing tasks in current session with subagents | `subagent-driven-development` |
| Each implementer subagent (dispatched from `subagent-driven-development`) | `test-driven-development` |

**Skill hierarchy during execution:** `sdd-execute` (controller) → invokes `subagent-driven-development` → dispatches implementer subagents → each subagent invokes `test-driven-development`. TDD is enforced at the implementer-subagent level, not by the controller directly.

## Project Context (CLAUDE.md)

When sdd-init creates `CLAUDE.md` for a new project, it includes pointers to context sources that Claude should read at the start of each conversation:

| Source | What it contains |
|--------|-----------------|
| `memory/constitution.md` | Nine Articles — immutable architectural principles |
| `memory/MEMORY.md` | Index of all persistent memory files |
| `docs/git-convention.md` | Branch naming regex, commit format, allowed types |
| `docs/specs/` | All feature specs, plans, and task lists |

This ensures Claude always starts with full project context rather than re-deriving conventions from scratch.

## Requirements

- [superpowers](https://github.com/obra/superpowers) plugin installed (`/plugin install superpowers@superpowers-marketplace`)

## License

MIT
