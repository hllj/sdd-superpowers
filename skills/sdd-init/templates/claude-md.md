<!-- sdd-init: generated -->
# [Project Name]

## About This Project

[Brief description of what this project does, its purpose, and key components.
Edit this section after init to give Claude context about your codebase.]

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

## Hard Gates (when following SDD)

- NO PLAN without an approved spec
- NO TASKS without a plan
- NO CODE without a prior failing test
- NO COMPLETION CLAIM without fresh verification evidence
