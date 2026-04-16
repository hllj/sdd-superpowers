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

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md, direct requests) — highest priority
2. **SDD skills** — govern the development workflow
3. **Default behavior** — lowest priority

## The SDD Skill Map

| Situation | Invoke |
|-----------|--------|
| Starting a new feature idea | `sdd-specify` |
| Need to investigate tech options before committing | `sdd-research` |
| Spec exists, need an implementation plan | `sdd-plan` |
| Plan exists, need executable tasks | `sdd-tasks` |
| Ready to execute tasks with agents | `sdd-execute` |
| Checking spec completeness before planning | `sdd-review` |
| Checking implementation matches spec after coding | `sdd-review` |
| A task fails or behavior is unexpected | `superpowers:systematic-debugging` |
| About to claim a feature is complete | `superpowers:verification-before-completion` |
| Implementation complete, deciding how to merge | `superpowers:finishing-a-development-branch` |

## Skill Priority

**Process skills first, execution skills second:**

1. `sdd-specify` / `sdd-research` — establish WHAT to build
2. `sdd-plan` — establish HOW to build it
3. `sdd-tasks` — establish the ORDER to build it
4. `sdd-execute` — actually build it
5. `sdd-review` + `superpowers:verification-before-completion` — confirm it was built correctly

Never skip steps. "Let's just code it" means `sdd-specify` first.

## When Each Skill Is Mandatory

**`sdd-specify` is mandatory when:**
- User describes a feature, idea, or problem without a spec existing
- User says "build X", "add X", "I want X"

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
| "I'm sure it works" | `superpowers:verification-before-completion` |
| "Tests pass so it's done" | `sdd-review` to confirm spec alignment |
| "Let me just fix this quickly" | `superpowers:systematic-debugging` first |

## Announcing Skill Usage

Always announce before invoking a skill:

> "I'm using [skill-name] to [purpose]."

This gives your human partner a chance to redirect before work begins.
