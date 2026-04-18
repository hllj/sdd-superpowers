# SDD Workflow — Full Routing Rules and Red Flags

This file contains the complete routing logic, mandatory skill conditions, red flags, and decision rules referenced from `SKILL.md`.    

---

## New Project Detection (runs before all routing)

Before evaluating any routing or skill invocation, check whether this project is initialised:

1. Check if `CLAUDE.md` exists in the current working directory
2. Check if `docs/specs/` directory exists in the current working directory

**If NEITHER exists** → this is an uninitialised project:
- Announce: "I'm using sdd-init to set up the Constitutional Foundation for this new SDD project."
- Invoke `sdd-superpowers:sdd-init` before taking any other action
- After `sdd-superpowers:sdd-init` completes, return here and re-evaluate the user's original request using the routing rules below

**If EITHER exists** → project is already initialised:
- Skip this block entirely
- Proceed to routing below

---

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md, direct requests) — highest priority
2. **SDD skills** — govern the development workflow
3. **Default behavior** — lowest priority

---

## The SDD Skill Map (Full)

| Situation | Invoke |
|-----------|--------|
| Idea is fuzzy, exploratory, or has competing approaches | `sdd-superpowers:sdd-brainstorm` |
| Idea is clear and ready to formalize | `sdd-superpowers:sdd-specify` |
| Need to investigate tech options before committing | `sdd-superpowers:sdd-research` |
| Spec exists, need an implementation plan | `sdd-superpowers:sdd-plan` |
| Plan exists, need executable tasks | `sdd-superpowers:sdd-tasks` |
| Ready to execute tasks with agents | `sdd-superpowers:sdd-execute` |
| Checking spec completeness before planning | `sdd-superpowers:sdd-review` |
| Checking implementation matches spec after coding | `sdd-superpowers:sdd-review` |
| A task fails or behavior is unexpected | `sdd-superpowers:systematic-debugging` |
| About to claim a feature is complete | `sdd-superpowers:verification-before-completion` |
| Implementation complete, deciding how to merge | `sdd-superpowers:finishing-a-development-branch` |
| At a phase boundary during execution, before starting the next phase | `sdd-superpowers:requesting-code-review` |
| Implementing fixes after a code review flagged issues | `sdd-superpowers:receiving-code-review` |
| Dispatching 2+ independent tasks concurrently | `sdd-superpowers:dispatching-parallel-agents` |

---

## Skill Priority Ordering

**Process skills first, execution skills second:**

1. `sdd-superpowers:sdd-brainstorm` (optional) → `sdd-superpowers:sdd-specify` — establish WHAT to build
2. `sdd-superpowers:sdd-research` (optional) — investigate HOW before committing
3. `sdd-superpowers:sdd-plan` — establish the technical approach
4. `sdd-superpowers:sdd-tasks` — establish the ORDER to build it
5. `sdd-superpowers:sdd-execute` — actually build it
6. `sdd-superpowers:sdd-review` + `sdd-superpowers:verification-before-completion` — confirm it was built correctly

Never skip steps. "Let's just code it" means `sdd-superpowers:sdd-brainstorm` or `sdd-superpowers:sdd-specify` first.

---

## Routing: Brainstorm vs. Specify

When the user describes a new idea, assess before routing:

### Explicit triggers → invoke `sdd-superpowers:sdd-brainstorm`

User language: "brainstorm", "explore", "not sure what to build", "thinking about", "what if we", "some kind of", "a better way to"

### Auto-detected fuzziness signals → suggest `sdd-superpowers:sdd-brainstorm` (advisory)

- No concrete user action or outcome stated ("I want to improve X" with no specifics)
- Multiple competing directions mentioned in one message
- Vague qualifiers: "something like", "some kind of", "not sure how"

When fuzziness signals are detected, **ask before routing** (user can override):
> "Your idea sounds exploratory — there may be a few different directions we could take. Would you like to brainstorm approaches first (`sdd-superpowers:sdd-brainstorm`), or do you have a clear direction and want to go straight to spec (`sdd-superpowers:sdd-specify`)?"

### Multi-subsystem scope → block both paths (mandatory decomposition)

If the idea spans 2+ independent subsystems:
> "This spans multiple independent subsystems. Before we brainstorm or specify, let's decompose it — which piece should we tackle first?"

This is blocking. Neither `sdd-superpowers:sdd-brainstorm` nor `sdd-superpowers:sdd-specify` until scope is agreed.

### Clear idea → invoke `sdd-superpowers:sdd-specify` directly

When the idea contains a concrete user action, clear outcome, and no competing approaches.

---

## When Each Skill Is Mandatory

**`sdd-superpowers:sdd-brainstorm` is mandatory when:**
- User explicitly asks to brainstorm or explore
- (Advisory) Auto-detected fuzziness signals present and user chooses brainstorm path

**`sdd-superpowers:sdd-specify` is mandatory when:**
- Idea is clear and concrete, OR
- `sdd-superpowers:sdd-brainstorm` has completed and `design.md` exists

**`sdd-superpowers:sdd-research` is mandatory when:**
- Spec has `[NEEDS CLARIFICATION]` items requiring technical investigation
- Non-functional requirements need validation (performance, security)
- Multiple viable technology paths exist

**`sdd-superpowers:sdd-plan` is mandatory when:**
- A spec exists and implementation hasn't started
- User says "plan this" or "how do we implement X"

**`sdd-superpowers:sdd-tasks` is mandatory when:**
- A plan exists and execution is imminent
- User wants to track progress or dispatch agents

**`sdd-superpowers:sdd-execute` is mandatory when:**
- A tasks.md exists and user says "implement", "build", "execute"

**`sdd-superpowers:sdd-review` is mandatory when:**
- Spec is about to be handed to planning (spec review mode)
- Implementation claims to be complete (implementation review mode)

**`sdd-superpowers:requesting-code-review` is mandatory when:**
- Completing a phase in `sdd-superpowers:sdd-execute` before starting the next phase

**`sdd-superpowers:receiving-code-review` is mandatory when:**
- A spec-compliance or code-quality review returns issues requiring fixes

**`sdd-superpowers:dispatching-parallel-agents` is mandatory when:**
- Dispatching a parallel task group in `sdd-superpowers:sdd-execute` (2+ independent tasks concurrently)

---

## Red Flags — Stop and Check Skills

| Thought | Action |
|---------|--------|
| "This is small, I'll just code it" | `sdd-superpowers:sdd-specify` first |
| "The plan is obvious, skip planning" | `sdd-superpowers:sdd-plan` first |
| "I know what tests to write" | `sdd-superpowers:sdd-tasks` first |
| "I'm sure it works" | `sdd-superpowers:verification-before-completion` |
| "Tests pass so it's done" | `sdd-superpowers:sdd-review` to confirm spec alignment |
| "Let me just fix this quickly" | `sdd-superpowers:systematic-debugging` first |

---

## Announcing Skill Usage

Always announce before invoking a skill:

> "I'm using [skill-name] to [purpose]."

This gives your human partner a chance to redirect before work begins.
