# SDD Superpowers

A set of Claude skills implementing **Specification-Driven Development (SDD)** — a methodology where specifications are the source of truth and code is their generated expression.

## What Is SDD?

SDD inverts the traditional relationship between specs and code. Instead of writing code and hoping it matches intent, you write precise specifications first, then generate code from them. The spec is the authoritative artifact; code is its expression in a particular language and framework.

Key principles:
- **Specifications as lingua franca** — the PRD and implementation plan are the primary artifacts
- **Executable specifications** — specs are precise enough to generate working, testable code
- **Test-first always** — no implementation code without a prior failing test
- **Traceability** — every technical decision traces back to a specific requirement
- **Bidirectional feedback** — production learnings flow back to update specs

## Skills

| Skill | When to Use |
|-------|-------------|
| `sdd-specify` | Starting any new feature — turns an idea into a structured PRD |
| `sdd-research` | Before planning complex features — investigates tech options, constraints |
| `sdd-plan` | After specify — translates requirements into architecture, contracts, tests |
| `sdd-tasks` | After plan — generates flat executable task list with parallelization hints |
| `sdd-review` | Before planning (spec review) or after implementation (alignment check) |

## Workflow

```
Idea
 │
 ▼
sdd-specify ──► specs/NNN-feature/spec.md
 │
 ▼ (optional, for complex features)
sdd-research ──► specs/NNN-feature/research.md
 │
 ▼
sdd-plan ──► specs/NNN-feature/plan.md
             specs/NNN-feature/data-model.md
             specs/NNN-feature/contracts/
 │
 ▼
sdd-tasks ──► specs/NNN-feature/tasks.md
 │
 ▼
Execute tasks (manually or with an agent)
 │
 ▼
sdd-review ──► Spec-implementation alignment report
```

## Directory Structure

```
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
  sdd-specify/SKILL.md
  sdd-research/SKILL.md
  sdd-plan/SKILL.md
  sdd-tasks/SKILL.md
  sdd-review/SKILL.md
```

## Quick Start

To start a new feature with SDD:

1. Tell Claude: "Use sdd-specify to create a spec for: [your feature idea]"
2. Answer clarifying questions about requirements
3. Approve the spec
4. Tell Claude: "Use sdd-plan to plan this feature"
5. Tell Claude: "Use sdd-tasks to generate the task list"
6. Execute the tasks
7. Tell Claude: "Use sdd-review to validate the implementation"

## SDD Commandments

1. **No code before spec** — if there's no spec.md, write it first
2. **No plan before spec is approved** — clarification markers must be resolved
3. **No implementation before tests** — every task follows red-green-commit
4. **No merge before review** — run sdd-review before declaring a feature complete
5. **Specs evolve, they don't rot** — when requirements change, update the spec first, then the code
