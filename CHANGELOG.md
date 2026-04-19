# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.4.0] - 2026-04-19

### Changed

- **`sdd-workflow`** — added `<SUBAGENT-STOP>` gate, `<EXTREMELY-IMPORTANT>` 1% rule block, Instruction Priority section, skill invocation decision flowchart, TodoWrite requirement, and Skill Types (Rigid/Flexible) classification; `routing.md` adds `subagent-driven-development` to full skill map and mandatory conditions, plus Reality column in Red Flags table
- **`subagent-driven-development`** — fixed all `superpowers:` namespace references to `sdd-superpowers:`; added SDD Source Files table (`tasks.md`/`spec.md`/`plan.md` roles); updated example workflow paths to `docs/specs/NNN-feature/`; fixed all prompt templates: `implementer-prompt.md` now mandates TDD and `using-git` conventions, `spec-reviewer-prompt.md` injects `spec.md` as authoritative source, `code-quality-reviewer-prompt.md` corrects skill namespace
- **`dispatching-parallel-agents`** — added `<SUBAGENT-STOP>` gate and SDD context in overview; rewrote When to Use flowchart to start from `tasks.md`; rewrote agent prompt template with SDD artifact injection and file-ownership constraints; replaced debugging example with SDD implementation example; rewrote post-dispatch review section as 6-step SDD process with correct spec-compliance (via `spec-reviewer-prompt.md`) and code-quality (via `requesting-code-review`) split
- **`receiving-code-review`** — added "From Reviewer Subagents (SDD)" source category as first handler; added YAGNI override rule (`spec.md` takes precedence); added re-dispatch requirement after fixes; added Integration section mapping callers and post-fix flow
- **`requesting-code-review`** — fixed `superpowers:code-reviewer` → `sdd-superpowers:code-reviewer`; clarified this skill handles code quality only (spec compliance handled separately by `spec-reviewer-prompt.md`); added `subagent-driven-development` and `dispatching-parallel-agents` to mandatory invocation contexts; added Integration section; `code-reviewer.md` updated with SDD artifact injection guidance
- **`test-driven-development`** — removed `@testing-anti-patterns.md` force-load syntax; added SDD checklist item (tests must verify spec requirements, not just implementation behavior); added Integration (SDD) section naming callers and spec context
- **`sdd-execute`** — added mid-flight spec change procedure (`STOP → sdd-update → propagate → resume`) to both SKILL.md and reference.md; added `verification-before-completion` as explicit hard gate before `sdd-review` in both the Quick Reference flow and reference.md Step 4
- **`finishing-a-development-branch`** — fixed integration section: added Prerequisites block (`sdd-review` + `verification-before-completion`), corrected all bare skill names to `sdd-superpowers:` namespace, replaced `executing-plans` with `sdd-superpowers:sdd-execute`

## [2.3.0] - 2026-04-19

### Added

- **`sdd-update` skill** — new skill intercepting mid-flight spec changes; classifies them as PATCH/MINOR/MAJOR, versions the spec, and propagates changes downstream in strict artifact order (spec → plan → tasks → flag code)
  - HARD-GATE blocks all downstream artifact updates until change is understood, version bump assigned, and user confirms scope
  - Spec versioning table: PATCH (clarification/wording, spec only), MINOR (new requirement, spec+plan+tasks), MAJOR (breaks/rewrites existing requirement, full review + flag code)
  - Graphviz flowchart: clarify → classify → per-path update → user confirms → propagate
  - 5-question clarification protocol; stops when change is expressible as testable acceptance criterion
  - `reference.md` with 7-step full process: clarification → classification → spec versioning → plan update → tasks update → code flagging → resume rules
- **Integration sections** — explicit sub-skill registration tables added to all relevant SDD skills:
  - `sdd-execute` Integration table extended with `dispatching-parallel-agents`, `subagent-driven-development`, `using-git`, `receiving-code-review`, `systematic-debugging`
  - `sdd-tasks` — new Integration section: `using-git` (branch creation + doc-first commit)
  - `sdd-review` — new Integration section: `verification-before-completion` (before claiming review complete)
  - `sdd-update` — Integration section: `using-git` (committing versioned artifacts after propagation)
- **`sdd-workflow` Quick Reference** extended with 6 previously missing bundled support skills: `using-git`, `test-driven-development`, `requesting-code-review`, `receiving-code-review`, `dispatching-parallel-agents`, `subagent-driven-development`

### Changed

- **`sdd-workflow` routing table** — added `sdd-update` row: mandatory for any change or addition to an approved spec
- **`sdd-workflow` Common Mistakes** — added: updating tasks/plan without running `sdd-update` first
- **`sdd-workflow` routing.md** — skill map, priority ordering, mandatory conditions, and red flags updated for `sdd-update`
- **`CLAUDE.md` skills table and workflow diagram** — `sdd-update` added with mid-flight change loop
- **README Bundled Support Skills** — replaced `using-git-worktrees` with `using-git`; SDD uses convention enforcement (branch naming + commit format), not isolated workspaces

---

## [2.2.1] - 2026-04-19

### Fixed

- **`CLAUDE.md` Project Context section** — added explicit context sources table pointing to `memory/constitution.md`, `memory/MEMORY.md`, `docs/git-convention.md`, and `docs/specs/`; Claude now knows where to look at the start of every conversation
- **`CLAUDE.md` Directory Structure** — expanded to show `memory/` and `docs/` as top-level entries with their contents
- **`sdd-init` CLAUDE.md template** — generated `CLAUDE.md` for new projects now includes the same Project Context table so the context-loading pattern is inherited automatically
- **`README.md` Project Context section** — added explanation of the generated CLAUDE.md context sources for plugin users

---

## [2.2.0] - 2026-04-18

### Added

- **`memory/constitution.md`** — Nine Articles constitutional foundation establishing immutable architectural principles for the sdd-superpowers project itself
- **`sdd-plan`: Scope Check section** — prompts splitting multi-subsystem specs into sub-specs before planning begins
- **`sdd-plan`: File Structure section** — requires mapping all files and responsibilities before defining phases
- **`sdd-plan`: No Placeholders section** — lists forbidden plan patterns (TBD, "Similar to Phase N", steps without code)
- **`sdd-plan`: Self-Review section** — inline checklist: spec coverage, placeholder scan, type/signature consistency
- **`sdd-plan`: Execution Handoff section** — offers `sdd-tasks` as next step after plan is saved
- **`sdd-tasks`: Bite-Sized Task Granularity section** — defines one-action-per-step rule with write/verify/implement/verify/commit examples
- **`sdd-tasks`: No Placeholders section** — lists forbidden task patterns
- **`sdd-tasks`: Remember section** — key rules: exact paths, complete code, exact commands with expected output
- **`sdd-tasks`: Execution Handoff section** — offers `sdd-execute` as next step after tasks.md is saved
- **`sdd-execute`: When to Stop and Ask section** — explicit stop conditions: missing dependency, repeated failure, unclear instruction, plan gap
- **`sdd-execute`: Remember section** — follow plan exactly, don't skip verifications, stop when blocked
- **`sdd-execute`: Integration section** — required sub-skills table: test-driven-development, requesting-code-review, verification-before-completion, sdd-review, finishing-a-development-branch
- **`sdd-specify`: Remember section** — WHAT not HOW, testable acceptance criteria, `[NEEDS CLARIFICATION]` usage
- **`sdd-specify`: Self-Review section** — inline checklist: testability, no placeholders, goals/non-goals, open questions
- **`sdd-specify`: Execution Handoff section** — status update Draft→Approved + offer `sdd-plan` as next step

### Changed

- **`sdd-plan` and `sdd-tasks` HARD-GATEs** — now require `spec.md` status to be `Approved` (not `Draft`) before planning or task generation begins
- **`sdd-workflow` routing table** — `sdd-review` (post-implementation) is now an explicit required step after `sdd-execute`, before `finishing-a-development-branch`
- **`sdd-workflow` Common Mistakes** — added: "Skipping `sdd-review` after implementation"
- **`sdd-workflow` routing.md** — `sdd-review` mandatory condition now states "REQUIRED before `finishing-a-development-branch`"
- **`sdd-specify` Quick Reference** — removed duplicate "Key rules" list (now canonical in Remember section)

---

## [2.1.0] - 2026-04-18

### Added

- **`reference.md` overflow files** — each rewritten skill now has a companion `reference.md` containing full process steps, templates, and examples; `SKILL.md` links to it for progressive disclosure
- **`skills/writing-skills/`** — writing-skills moved from repo root into `skills/` so it is discoverable alongside all other skills
- **HARD-GATE blocks in `sdd-plan` and `sdd-tasks`** — enforces the Four Hard Gates at the skill level:
  - `sdd-plan` blocks until `spec.md` is user-approved and all `[NEEDS CLARIFICATION]` items are resolved
  - `sdd-tasks` blocks until `plan.md` is explicitly approved by the user
- **`verify.sh`** — automated compliance script checking CSO descriptions, word budgets, section structure, and content preservation across all skills

### Changed

- **All `SKILL.md` descriptions** rewritten to CSO format: start with "Use when", state triggering condition only, no workflow summaries
- **Word budgets enforced**: `sdd-workflow` ≤200 words; all other skills ≤500 words; overflow moved to `reference.md`
- **Standard section structure** applied to all rewritten skills: `## Overview`, `## When to Use`, `## Quick Reference`, `## Common Mistakes` (discipline skills)
- **`sdd-workflow`** — routing rules, red flags, and new-project detection moved to `routing.md`; SKILL.md trimmed to 199 words
- **All cross-skill references** updated from bare names (e.g. `` `sdd-plan` ``) to fully-qualified `sdd-superpowers:` namespace (e.g. `` `sdd-superpowers:sdd-plan` ``) to match the `Skill` tool invocation format

### Exempt (intentionally unchanged)

- `subagent-driven-development`, `systematic-debugging`, `test-driven-development` — exempt from word-count reduction and section standardization; verbose content is intentional

---

## [2.0.0] - 2026-04-17

### Added

- **`using-git` skill** — single source of truth for all SDD git operations; replaces `using-git-worktrees` as the canonical git skill
  - **Operation A — Branch Creation**: loads `docs/git-convention.md`, suggests branch names (slug / ticket-ID / custom), validates against `branch_pattern` regex, creates branch
  - **Operation B — Doc-First Commit**: stages only `docs/specs/NNN-slug/`, proposes convention-compliant message, confirms, commits
  - **Operation C — Per-Task Commit** (delegation-only, called by `sdd-execute`): conflict detection, SHA-bounded staging, message validation, returns new commit SHA
  - **Operation D — Merge Commit Message**: derives scope from branch name, suggests and validates merge commit message, returns confirmed message to caller
  - **Direct Invocation Menu**: users can invoke `using-git` directly to create a branch, ad-hoc commit, prepare a merge message, or display the active convention
  - **Advanced: Parallel Workstreams with Worktrees** — opt-in documentation for manual worktree usage; not part of the standard workflow
- **`docs/git-convention.md`** — project-level git convention file (YAML frontmatter + Markdown body) established during `sdd-init` and read by `using-git` before every operation

### Changed

- **`sdd-tasks` Step 5** — now a single delegation block: "Invoke `using-git` — Branch Creation and Doc-First Commit"; all inline branch/commit logic moved to `using-git`
- **`sdd-execute` Step 3e** — now a single delegation block: "Invoke `using-git` — Per-Task Commit"; all inline conflict checking, staging, and commit logic moved to `using-git`
- **`finishing-a-development-branch` Step 2.5** — now a single delegation block: "Invoke `using-git` — Merge Commit Message"; all inline convention loading and validation moved to `using-git`
- **`subagent-driven-development`** — Integration section updated to reference `using-git` instead of `using-git-worktrees`
- **`CLAUDE.md` bundled skills table** — entry updated from `using-git-worktrees` to `using-git`

### Removed

- **`using-git-worktrees` skill** — removed entirely; worktree guidance preserved as an Advanced opt-in section inside `using-git`

---

## [1.2.0] - 2026-04-17

### Added

- **Git convention setup in `sdd-init`** — new Step 5.4 walks through a 4-question Q&A (branch prefix strategy, ticket ID format, commit types, merge style) and writes `docs/git-convention.md`; Step 5.5 commits it as part of the initial scaffold
- **Branch creation + doc-first commit in `sdd-tasks`** — new Step 5 loads the project's git convention, suggests branch names (slug / ticket-ID / custom), creates the feature branch, and makes the doc-first commit before handing off to `sdd-execute`
- **Per-task commits in `sdd-execute`** — Step 3e adds commit staging, message proposal (convention-compliant), and user confirmation after each task; Step 1 now halts if running on main/master and loads the convention
- **Merge commit validation in `finishing-a-development-branch`** — new Step 2.5 loads convention, suggests a compliant merge commit message, and validates it against `allowed_types` + `commit_format` before proceeding

### Changed

- **`sdd-specify`** — Step 7 (branch creation) removed; branch creation is now deferred to `sdd-tasks` to eliminate the `using-git-worktrees` dependency at spec time
- **`sdd-tasks`** — now owns the full branch lifecycle (load convention → suggest name → create branch → doc-first commit)
- **`sdd-execute`** — guards against accidental commits to main/master; per-task commit flow replaces ad-hoc git usage

---

## [1.1.0] - 2026-04-17

### Added

- **SDD Init skill** (`sdd-init`) — Constitutional Foundation setup for new projects: codebase exploration to build a Project Profile, interactive Nine Articles review (one per turn, with governance sentences and stack-personalised defaults), atomic scaffold creation (`memory/constitution.md`, `docs/specs/`, `CLAUDE.md`), and handoff back to `sdd-workflow`
- **New Project Detection in `sdd-workflow`** — automatically triggers `sdd-init` when neither `CLAUDE.md` nor `docs/specs/` exist in the current working directory; resumes normal routing after init completes

### Changed

- `sdd-workflow` now checks for project initialisation before any routing logic (non-breaking — only activates in uninitialised projects)

---

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

[2.3.0]: https://github.com/hllj/sdd-superpowers/compare/v2.2.1...v2.3.0
[2.2.1]: https://github.com/hllj/sdd-superpowers/compare/v2.2.0...v2.2.1
[2.2.0]: https://github.com/hllj/sdd-superpowers/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/hllj/sdd-superpowers/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/hllj/sdd-superpowers/compare/v1.2.0...v2.0.0
[1.2.0]: https://github.com/hllj/sdd-superpowers/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/hllj/sdd-superpowers/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/hllj/sdd-superpowers/releases/tag/v1.0.0
