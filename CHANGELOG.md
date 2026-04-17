# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-04-17

### Added

- **SDD Workflow skill** (`sdd-workflow`) — entry point establishing mandatory skill invocation rules and routing logic
- **SDD Brainstorm skill** (`sdd-brainstorm`) — fuzzy idea exploration with visual companion, dialogue-driven design, and automatic routing to `sdd-specify`
  - Visual companion server (Node.js + shell) for browser-based mockup sessions
  - Spec document reviewer subagent prompt
- **SDD Specify skill** (`sdd-specify`) — converts clear ideas or design.md artifacts into structured PRDs (`spec.md`), with fast-path when design.md exists
- **SDD Research skill** (`sdd-research`) — technical investigation for unresolved tech choices, performance, and security requirements before planning
- **SDD Plan skill** (`sdd-plan`) — transforms approved specs into implementation plans with architecture, API contracts, and data models
- **SDD Tasks skill** (`sdd-tasks`) — converts implementation plans into flat executable task lists with parallelization hints
- **SDD Execute skill** (`sdd-execute`) — subagent-driven implementation with per-task spec-compliance and code-quality review gates
- **SDD Review skill** (`sdd-review`) — validates spec completeness (pre-plan) and implementation alignment (post-execute) with coverage matrix
- **Bundled Superpowers skills** — key workflow skills cloned and integrated:
  - `systematic-debugging` — root-cause investigation before any fix
  - `verification-before-completion` — evidence required before any completion claim
  - `finishing-a-development-branch` — structured merge/PR/keep/discard decision after all tasks done
  - `test-driven-development` — enforces test-first discipline on every implementation task
  - `using-git-worktrees` — isolated feature workspace setup
  - `requesting-code-review` — phase-boundary review invocation
  - `receiving-code-review` — disciplined review feedback implementation
  - `dispatching-parallel-agents` — concurrent subagent dispatch for independent tasks
  - `subagent-driven-development` — in-session subagent execution with review checkpoints
- **Claude Code marketplace support** — `marketplace.json`, plugin manifest (`claude-plugin.json`), and `README.md` for marketplace publishing
- **The Four Hard Gates** — enforced discipline checkpoints:
  1. No plan without an approved spec
  2. No tasks without a plan
  3. No code without a prior failing test
  4. No completion claim without fresh verification evidence

### Project Structure

```
docs/specs/NNN-feature/
  spec.md        # PRD — source of truth
  research.md    # Technical investigation (optional)
  plan.md        # Implementation plan
  data-model.md  # Entity definitions (optional)
  contracts/     # API/event contracts (optional)
  tasks.md       # Executable task list
  quickstart.md  # Smoke test scenarios
skills/          # All SDD and bundled Superpowers skills
```

[1.0.0]: https://github.com/hllj/sdd-superpowers/releases/tag/v1.0.0
