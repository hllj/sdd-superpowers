---
name: sdd-workflow
description: Use when starting any conversation in an SDD project — establishes which skill to invoke for each situation and enforces mandatory skill usage before any action
---

# SDD Workflow

The entry point for all Specification-Driven Development work. Establishes skill priority and invocation rules so that every action in the SDD cycle is guided by the right skill.

<EXTREMELY-IMPORTANT>
If you think there is even a 1% chance an SDD skill applies to what you are doing, you MUST invoke it before taking any action — including asking clarifying questions.

This is not optional. This is not negotiable.
</EXTREMELY-IMPORTANT>

## New Project Detection (runs before all routing)

Before evaluating any routing or skill invocation, check whether this project is initialised:

1. Check if `CLAUDE.md` exists in the current working directory
2. Check if `docs/specs/` directory exists

**If NEITHER exists** → this is an uninitialised project:
- Announce: "I'm using sdd-init to set up the Constitutional Foundation for this new SDD project."
- Invoke `sdd-init` before taking any other action
- After `sdd-init` completes, return here and re-evaluate the user's original request using the routing rules below

**If EITHER exists** → project is already initialised:
- Skip this block entirely
- Proceed to routing below

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md, direct requests) — highest priority
2. **SDD skills** — govern the development workflow
3. **Default behavior** — lowest priority

## The SDD Skill Map

| Situation | Invoke |
|-----------|--------|
| Idea is fuzzy, exploratory, or has competing approaches | `sdd-brainstorm` |
| Idea is clear and ready to formalize | `sdd-specify` |
| Need to investigate tech options before committing | `sdd-research` |
| Spec exists, need an implementation plan | `sdd-plan` |
| Plan exists, need executable tasks | `sdd-tasks` |
| Ready to execute tasks with agents | `sdd-execute` |
| Checking spec completeness before planning | `sdd-review` |
| Checking implementation matches spec after coding | `sdd-review` |
| A task fails or behavior is unexpected | `systematic-debugging` |
| About to claim a feature is complete | `verification-before-completion` |
| Implementation complete, deciding how to merge | `finishing-a-development-branch` |
| At a phase boundary during execution, before starting the next phase | `requesting-code-review` |
| Implementing fixes after a code review flagged issues | `receiving-code-review` |
| Dispatching 2+ independent tasks concurrently | `dispatching-parallel-agents` |

## Skill Priority

**Process skills first, execution skills second:**

1. `sdd-brainstorm` (optional) → `sdd-specify` — establish WHAT to build
2. `sdd-research` (optional) — investigate HOW before committing
3. `sdd-plan` — establish the technical approach
4. `sdd-tasks` — establish the ORDER to build it
5. `sdd-execute` — actually build it
6. `sdd-review` + `verification-before-completion` — confirm it was built correctly

Never skip steps. "Let's just code it" means `sdd-brainstorm` or `sdd-specify` first.

## Routing: Brainstorm vs. Specify

When the user describes a new idea, assess before routing:

### Explicit triggers → invoke `sdd-brainstorm`
User language: "brainstorm", "explore", "not sure what to build", "thinking about", "what if we", "some kind of", "a better way to"

### Auto-detected fuzziness signals → suggest `sdd-brainstorm` (advisory)
- No concrete user action or outcome stated ("I want to improve X" with no specifics)
- Multiple competing directions mentioned in one message
- Vague qualifiers: "something like", "some kind of", "not sure how"

When fuzziness signals are detected, **ask before routing** (user can override):
> "Your idea sounds exploratory — there may be a few different directions we could take. Would you like to brainstorm approaches first (`sdd-brainstorm`), or do you have a clear direction and want to go straight to spec (`sdd-specify`)?"

### Multi-subsystem scope → block both paths (mandatory decomposition)
If the idea spans 2+ independent subsystems:
> "This spans multiple independent subsystems. Before we brainstorm or specify, let's decompose it — which piece should we tackle first?"

This is blocking. Neither `sdd-brainstorm` nor `sdd-specify` until scope is agreed.

### Clear idea → invoke `sdd-specify` directly
When the idea contains a concrete user action, clear outcome, and no competing approaches.

## When Each Skill Is Mandatory

**`sdd-brainstorm` is mandatory when:**
- User explicitly asks to brainstorm or explore
- (Advisory) Auto-detected fuzziness signals present and user chooses brainstorm path

**`sdd-specify` is mandatory when:**
- Idea is clear and concrete, OR
- `sdd-brainstorm` has completed and `design.md` exists

**`sdd-research` is mandatory when:**
- Spec has `[NEEDS CLARIFICATION]` items requiring technical investigation
- Non-functional requirements need validation (performance, security)
- Multiple viable technology paths exist

**`sdd-plan` is mandatory when:**
- A spec exists and implementation hasn't started
- User says "plan this" or "how do we implement X"

**`sdd-tasks` is mandatory when:**
- A plan exists and execution is imminent
- User wants to track progress or dispatch agents

**`sdd-execute` is mandatory when:**
- A tasks.md exists and user says "implement", "build", "execute"

**`sdd-review` is mandatory when:**
- Spec is about to be handed to planning (spec review mode)
- Implementation claims to be complete (implementation review mode)

**`requesting-code-review` is mandatory when:**
- Completing a phase in `sdd-execute` before starting the next phase

**`receiving-code-review` is mandatory when:**
- A spec-compliance or code-quality review returns issues requiring fixes

**`dispatching-parallel-agents` is mandatory when:**
- Dispatching a parallel task group in `sdd-execute` (2+ independent tasks concurrently)

## The Hard Gates

```
NO PLAN without an approved spec
NO TASKS without a plan
NO CODE without a prior failing test
NO COMPLETION CLAIM without fresh verification evidence
```

## Red Flags — Stop and Check Skills

| Thought | Action |
|---------|--------|
| "This is small, I'll just code it" | `sdd-specify` first |
| "The plan is obvious, skip planning" | `sdd-plan` first |
| "I know what tests to write" | `sdd-tasks` first |
| "I'm sure it works" | `verification-before-completion` |
| "Tests pass so it's done" | `sdd-review` to confirm spec alignment |
| "Let me just fix this quickly" | `systematic-debugging` first |

## Announcing Skill Usage

Always announce before invoking a skill:

> "I'm using [skill-name] to [purpose]."

This gives your human partner a chance to redirect before work begins.
