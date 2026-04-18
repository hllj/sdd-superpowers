# SDD Superpowers

A set of Claude skills implementing **Specification-Driven Development (SDD)** — a methodology where specifications are the source of truth and code is their generated expression.

Built on the [superpowers](https://github.com/obra/superpowers) framework philosophy: skills enforce discipline through hard gates, iron laws, and verification requirements.

## Project Context

Before starting any work, read these sources to understand the current state of the project:

| Source | What it contains |
|--------|-----------------|
| `memory/constitution.md` | Nine Articles — immutable architectural principles governing all implementation |
| `memory/MEMORY.md` | Index of all persistent memory files — user preferences, project decisions, feedback |
| `docs/git-convention.md` | Branch naming regex, commit format, allowed types |
| `docs/specs/` | All feature specs, plans, and task lists from past and ongoing work |

Always check `docs/specs/` for existing specs before starting a new feature — a spec may already exist for what you're about to build.

## What Is SDD?

SDD inverts the traditional relationship between specs and code. Instead of writing code and hoping it matches intent, you write precise specifications first, then generate code from them. The spec is the authoritative artifact; code is its expression in a particular language and framework.

Key principles:
- **Specifications as lingua franca** — PRD and implementation plan are the primary artifacts
- **Executable specifications** — specs are precise enough to generate working, testable code
- **Test-first always** — no implementation code without a prior failing test
- **Traceability** — every technical decision traces back to a specific requirement
- **Evidence before assertions** — no completion claims without running verification commands

## Skills

| Skill | When to Use |
|-------|-------------|
| `sdd-workflow` | Start of any conversation — establishes mandatory skill invocation |
| `sdd-brainstorm` | Idea is fuzzy/exploratory → dialogue + 2-3 approaches + design.md |
| `sdd-specify` | Idea is clear, or design.md exists → structured PRD (spec.md) |
| `sdd-research` | Unresolved tech choices, performance/security requirements before planning |
| `sdd-plan` | Spec exists → architecture, contracts, data models, test-first plan |
| `sdd-tasks` | Plan exists → flat executable task list with parallelization hints |
| `sdd-execute` | Tasks exist → subagent dispatch with spec-compliance + code-quality review |
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
 │  (fast-path if design.md       + feature branch created
 │   already exists)
 │
 ├─(complex features)──────────►
 │                              sdd-research ──► docs/specs/NNN-feature/research.md
 │ ◄────────────────────────────┘
 │
 ├─(optional pre-plan check)───►
 │                              sdd-review (spec mode)
 │ ◄────────────────────────────┘
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
 │                               Spec-compliance review after each task
 │                               Code-quality review after each task
 │
 ▼
sdd-review (impl mode) ───────► Coverage matrix + test verification
 │
 ▼
finishing-a-development-branch ──► merge / PR / keep / discard
```

## The Four Hard Gates

```
NO PLAN without an approved spec
NO TASKS without a plan
NO CODE without a prior failing test
NO COMPLETION CLAIM without fresh verification evidence
```

## Bundled Skills (cloned from Superpowers)

These skills are invoked at specific SDD workflow points and are included in this repo:

| Situation | Skill |
|-----------|-------|
| Task fails or behavior unexpected | `systematic-debugging` |
| About to claim anything is complete | `verification-before-completion` |
| All tasks done, tests passing | `finishing-a-development-branch` |
| Any git operation in an SDD project (branches, commits, convention) | `using-git` |
| Any implementation task (every task) | `test-driven-development` |
| At a phase boundary during execution | `requesting-code-review` |
| Implementing fixes after review feedback | `receiving-code-review` |
| Dispatching 2+ independent tasks concurrently | `dispatching-parallel-agents` |
| Executing tasks in current session with subagents | `subagent-driven-development` |

## Directory Structure

```
memory/
  constitution.md   # Nine Articles — immutable architectural principles
  MEMORY.md         # Index of all persistent memory files
  *.md              # Individual memory files (user, feedback, project, reference)
docs/
  git-convention.md # Branch naming regex, commit format, allowed types
  specs/
    001-feature-name/
      spec.md          # PRD — the source of truth
      research.md      # Technical investigation (optional)
      plan.md          # Implementation plan
      data-model.md    # Entity definitions (optional)
      contracts/       # API/event contracts (optional)
        api.md
        events.md
      tasks.md         # Executable task list
      quickstart.md    # Smoke test scenarios
skills/
  sdd-workflow/           # Entry point — skill invocation rules + routing
  sdd-brainstorm/         # Fuzzy idea → design.md (visual companion + spec-reviewer subagent)
    scripts/              # Visual companion server (Node.js + shell)
    visual-companion.md   # Guide for browser-based mockup sessions
    spec-document-reviewer-prompt.md
  sdd-specify/            # Clear idea or design.md → spec.md (fast-path if design.md exists)
  sdd-research/           # Technical investigation
  sdd-plan/               # Spec → implementation plan
  sdd-tasks/              # Plan → executable task list
  sdd-execute/            # Tasks → subagent-driven implementation
  sdd-review/             # Spec/implementation alignment validation
  systematic-debugging/   # Root-cause investigation before any fix
    root-cause-tracing.md
    defense-in-depth.md
    condition-based-waiting.md
  verification-before-completion/  # Evidence required before any completion claim
  finishing-a-development-branch/  # Merge / PR / keep / discard after all tasks done
```

## Quick Start

```
# Fuzzy idea path:
1. "Use sdd-brainstorm to explore: [your idea]"
2. Answer questions, pick from 2-3 approaches, approve design
3. sdd-brainstorm automatically invokes sdd-specify (fast-path)

# Clear idea path:
1. "Use sdd-specify to create a spec for: [your idea]"
2. Answer clarifying questions, approve the spec
3. "Use sdd-plan to plan this feature"
4. "Use sdd-tasks to generate the task list"
5. "Use sdd-execute to implement it"
6. "Use sdd-review to validate the implementation"
```
