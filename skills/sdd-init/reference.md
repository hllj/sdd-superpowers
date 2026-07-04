# SDD Init: Full Initialisation Procedure

> This file contains the complete step-by-step procedure for `sdd-superpowers:sdd-init`. See [SKILL.md](SKILL.md) for the summary.

**Announce at start:** "I'm using sdd-init to set up the project foundation for this new SDD project."

<HARD-GATE>
Do NOT create any feature specs, plans, or code until the foundation file is approved and the scaffold is written. This skill produces ONLY the project foundation.
</HARD-GATE>

## Step 1: Announce and Orient

Tell the user:
> "Before we begin feature work, I'll walk you through the Mission Charter — four questions that capture your project's purpose and principles. Nothing is written until you approve the final result."

## Step 1.5: Explore Project Context

Before the Mission Charter ceremony, gather context about the project to personalise question examples and pre-fill steering files.

Dispatch a codebase exploration subagent with these instructions:

> "Read the following files if they exist: README.md, package.json, pyproject.toml, Cargo.toml, go.mod, requirements.txt, composer.json. Also list the top-level directory structure (one level deep). Produce a Project Profile with these fields:
> - **Language:** primary language(s)
> - **Framework:** main framework(s) or 'none detected'
> - **Type:** service / library / CLI tool / web app / monorepo / unclear
> - **Tests:** yes/no — framework name if detected
> - **Notable patterns:** any existing architectural conventions visible from directory structure or README
>
> If no files are found, respond: 'Empty project — no context detected.'"

Use the returned Project Profile to personalise the Mission Charter ceremony:

| Question | How to personalise |
|----------|--------------------|
| Q1 — Mission | If README contains a clear purpose statement, surface it as a suggested starting point for the user to edit |
| Q2 — Non-negotiables | Include language-appropriate examples (Python → "we always use type hints"; Node → "we always pin dependencies") |
| Q3 — Failure Modes | Include stack-appropriate examples (e.g., if database detected → "prod migrations break without staging tests") |
| Q4 — Amendment | No personalisation needed — default options apply universally |

The Project Profile is also used in Step 5.2 to pre-fill steering file content.

If the project is empty or exploration returns no useful signal: use the generic question examples as written in Step 2.

### Foundation Existence Check

After the exploration subagent returns, check for existing foundation and legacy files:

- **If `.claude/memory/foundation.md` exists:**
  Announce: "foundation.md already exists — project already initialized. No files will be written."
  **STOP — do not proceed to Step 2 or any scaffold step.**
- **If `.claude/memory/constitution.md` exists and contains `## Article I`:**
  Announce: "An existing nine-article constitution was found at `.claude/memory/constitution.md`. Run migration before re-initializing: rename `.claude/memory/constitution.md` → `.claude/memory/foundation.md`, then re-invoke `sdd-init`. No files will be written."
  **STOP — do not proceed to Step 2 or any scaffold step.**
- **If both `.claude/memory/constitution.md` → (legacy) and `.claude/memory/foundation.md` exist:**
  Announce: "Conflicting state — both `.claude/memory/foundation.md` and the legacy `.claude/memory/constitution.md` → `.claude/memory/foundation.md` migration target exist. Resolve manually before re-invoking `sdd-init`. No files will be written."
  **STOP — do not proceed to Step 2 or any scaffold step.**
- **If `.claude/memory/constitution.md` exists and does NOT contain `## Article I`:**
  Announce: "A mission-charter constitution exists at `.claude/memory/constitution.md`. Rename it to `.claude/memory/foundation.md` to complete migration, then re-invoke `sdd-init`. No files will be written."
  **STOP — do not proceed to Step 2 or any scaffold step.**
- **If `memory/foundation.md` exists at project root (legacy layout — pre-017):**
  Announce: "A `memory/foundation.md` was found at the old location. Migrate it to `.claude/memory/foundation.md` before re-invoking sdd-init: `mkdir -p .claude/memory && mv memory/ .claude/`. No files will be written."
  **STOP — do not proceed to Step 2 or any scaffold step.**
- **If neither file exists:** proceed to Step 2 normally.

---

## Step 2: Mission Charter Ceremony

**If invoked with `--fast` flag:** skip Q3. Ask Q1, Q2, Q4 only.

Present each question using the AskUserQuestion structured UI tool — not plain prose. One question per turn. Wait for a response before presenting the next.

### Q1 — Project Mission

Present as structured question:
- Header: "Project Mission"
- Question: "In one or two sentences: what does this project exist to do, and who does it serve?"

### Q2 — Non-negotiables

Present as structured question:
- Header: "Non-negotiables"
- Question: "What are 1–3 things your team will never compromise on? (e.g. 'we never ship without a test', 'CLI-first always', 'no external dependencies without a spike')"

### Q3 — What Failure Looks Like (skip if --fast)

Present as structured question:
- Header: "Failure Modes"
- Question: "What does a bad outcome look like for this project? (e.g. 'feature works locally but breaks in prod', 'specs drift from code', 'every PR needs a rewrite')"

### Q4 — Amendment Process

Present as structured question:
- Header: "Amendment Process"
- Question: "How should these principles change over time?"
- Options:
  - "Document rationale → explicit team approval → backwards-compatibility check (Recommended)"
  - "Custom (I'll describe it)"

If the user selects "Custom": ask a follow-up open-text question for their amendment process.

### Draft Constitution

After collecting all answers:

1. Synthesize into a draft:
   - **Mission:** from Q1
   - **Principles:** from Q2 stated as positive invariants. If NOT `--fast`, also invert Q3 failure modes into positive invariants and merge. Total: 3–5 principles.
   - **Operational Context:** fixed pointer block (see Step 5.1 template)
   - **Amendment Process:** from Q4

2. Present the full draft to the user.

3. Ask: "Does this capture your project's principles accurately? Say yes to write it, or describe what to change."

4. If changes requested: revise and re-present without re-asking questions. Repeat until approved.

5. On approval: proceed to Step 3.

**Must not** include SDD methodology rules (Library-First, TDD, CLI Mandate, Simplicity Gate, Anti-Abstraction, Integration-First) in the foundation file.

## Step 3: Write .claude/memory/foundation.md

Announce: "Writing `.claude/memory/foundation.md`."

Create `.claude/memory/` directory if it does not exist.

Write `.claude/memory/foundation.md` using the approved draft. The file must contain exactly these sections in this order:

```markdown
# [Project Name] Foundation

> Loaded every session. To amend, follow the Amendment Process below.

## Mission
[Synthesized from Q1]

## Principles
1. [Derived from Q2 + Q3 — stated as a positive invariant]
2. [...]
3. [...]

## Operational Context
Steering files in `.claude/memory/steering/` carry project-specific operational context
(tech stack, test strategy, conventions, team practices). Each file's `loaded-by`
frontmatter lists which skills silently incorporate it during that skill's session.
Edit steering files freely — they are not subject to the amendment process.

## Amendment Process
[From Q4]
```

## Step 4: Rules Generation Phase

### Step 4.1: Detect Tech Stack

Use the Project Profile returned by the codebase exploration subagent in Step 1.5.

If any manifest files were not yet read, read them now: `package.json` (dependencies, devDependencies, scripts), `pyproject.toml`, `requirements.txt`, `Cargo.toml`, `go.mod`, `composer.json`, `Gemfile`, `build.gradle`, `pom.xml`.

Produce a **Stack Context** string: language(s), frameworks, test runners, linters, and notable tools. Example: "TypeScript, Next.js 14, Prisma, Jest, ESLint/Prettier".

**Fallback:** If no manifest files are found and Step 1.5 returned "Empty project — no context detected.", ask exactly one question: "What is the primary language and framework for this project?" Use the answer as Stack Context. No further questions.

### Step 4.2: Dispatch Research Subagents (Parallel)

Announce: "Researching best practices, security rules, and automation patterns for your stack. Running three parallel lookups."

Dispatch exactly **three subagents concurrently** (not sequentially), each receiving the Stack Context.

**Subagent 1 — Conventions:**

> "You are researching development best practices for: [Stack Context].
>
> Search the web for:
> 1. Naming conventions (files, functions, variables, modules)
> 2. Recommended project directory structure
> 3. Linting and formatting best practices
> 4. Commonly cited best practices (dos) for this stack
> 5. Commonly cited anti-patterns (don'ts) to avoid
>
> Based on your research, propose a set of per-topic rule files for `.claude/rules/`. Infer the topics from the stack — do NOT use a fixed list. For each topic:
> - `filename`: descriptive, e.g. `testing.md`, `api-design.md`
> - `subdir` (optional): use when the stack has distinct layers, e.g. `frontend/`, `backend/`
> - `rules`: 5–10 rules mixing best practices (✓ do), anti-patterns (✗ avoid), and conventions
>
> Return a structured list. Do NOT return raw web text — synthesize into actionable rules only."

**Subagent 2 — Security & Permissions:**

> "You are researching security and permission needs for: [Stack Context].
>
> Search the web for:
> 1. Dangerous shell commands that should be blocked when working with this stack
> 2. Safe CLI tools developers commonly allow in Claude Code for this stack
> 3. Sensitive file patterns that should be protected
> 4. Security anti-patterns specific to this stack
>
> Return a structured summary with exactly these keys:
> - `allowedTools`: list of safe CLI command prefixes (e.g. `npm`, `jest`, `prisma`)
> - `blockedTools`: dangerous commands to block (e.g. `rm -rf`, `DROP TABLE`)
> - `ignorePatterns`: sensitive file/directory patterns (e.g. `.env`, `*.pem`, `secrets/`)
>
> Do NOT return raw web text — synthesize into concrete, actionable entries only."

**Subagent 3 — Automation & Hooks:**

> "You are researching automation and hook patterns for: [Stack Context].
>
> Search the web for:
> 1. Common pre-commit checks for this stack (lint, format, type check)
> 2. Format-on-save patterns
> 3. Test-on-push patterns
> 4. Community-recommended Claude Code hook setups for this stack
>
> Return a structured list of hooks for Claude Code's `.claude/settings.json`. For each hook:
> - `event`: one of `PreToolUse`, `PostToolUse`, `Stop`, `Notification`
> - `matcher` (optional): tool name pattern to match
> - `command`: the shell command to run
>
> Do NOT return raw web text — synthesize into concrete, actionable entries only."

**Empty result handling:** If a subagent returns no usable results, mark its section as empty and note: "No [conventions / security / automation] rules could be generated — you can add these manually later." Init does not fail.

### Step 4.3: User Review Flow

After all three subagents complete, present proposals in two sections. Do NOT write any files during this step.

**Section A — Rule files (from Subagent 1 results):**

**If Subagent 1 returned no results:** Skip Section A entirely. Show the user: "No convention rule files could be generated for your stack — you can create `.claude/rules/` files manually later." Proceed directly to Section B.

For each proposed `.claude/rules/` file, present in sequence:

```
Proposed: .claude/rules/[subdir/]filename.md

[full proposed file content]

Approve as-is, tweak the content, or skip this file? (approve / tweak / skip)
```

**Conflict check:** Before presenting each file, check whether it already exists at `.claude/rules/[subdir/]filename.md`. If it does, note this in the presentation: "Note: this file already exists — approving will overwrite it." The user's approve/tweak/skip response covers both the content decision and the overwrite decision.

- **approve**: mark for writing; move to next file
- **tweak**: show content in editable block; when user confirms, mark for writing; move to next file
- **skip**: mark as skipped; do not prompt for this file again; move to next file

**Section B — `.claude/settings.json` (from Subagents 2 and 3):**

Merge both subagents' results into a single `.claude/settings.json` block:

```json
{
  "allowedTools": ["<tool>", "..."],
  "blockedTools": ["<tool>", "..."],
  "ignorePatterns": ["<pattern>", "..."],
  "hooks": [
    {
      "event": "<PreToolUse|PostToolUse|Stop|Notification>",
      "matcher": "<optional>",
      "command": "<shell command>"
    }
  ]
}
```

**Conflict check:** Before presenting, check whether `.claude/settings.json` already exists.
- If it exists: announce "A `.claude/settings.json` already exists. Choose: (merge) add proposed entries alongside existing ones, (overwrite) replace the file entirely, or (skip) leave the file unchanged."
- If it does not exist: present the block directly.

When a conflict handling mode (merge / overwrite / skip) has been chosen, the subsequent "approve / tweak / skip" prompt governs the **content** of the proposed block only. "Approve" means accept the content as written; "tweak" means edit the content; "skip" overrides any prior conflict choice and writes nothing.

Then ask: "Approve this `.claude/settings.json` block, tweak it, or skip it? (approve / tweak / skip)"

### Step 4.4: Write Approved Files (Atomic)

Write all approved files in one uninterrupted pass — no user interaction between writes.

1. **Rule files:** For each approved rule file:
   - Create parent directory if needed (e.g. `mkdir -p .claude/rules/frontend/`)
   - Write the approved content

2. **`.claude/settings.json`:**
   - If approved with **merge**: read existing file, merge entries (union lists for arrays, no duplicates), write merged result
   - If approved with **overwrite**: write proposed block as new file
   - If approved with **no conflict**: write proposed block as new file
   - If skipped: write nothing

After writing, announce:
> "Rules generation complete:
> - `.claude/rules/` — [N] files written ([list filenames])
> - `.claude/settings.json` — [written / merged / skipped]"

Proceed to Step 5.

## Step 5: Scaffold Creation

Create files in this order. Announce each file before creating it.

### Step 5.1 Confirm .claude/memory/foundation.md

Confirm that `.claude/memory/foundation.md` was written in Step 3. If Phase 1 was bypassed (foundation already existed), skip this step entirely — proceed to Step 5.2.

### Step 5.2 Generate Steering Files

Announce: "Generating steering files from your project context. Edit these to match reality."

Use the Project Profile from Step 1.5 to pre-fill each file. If the profile has no signal for a field, write `[Edit to match reality]` as the placeholder. Create `.claude/memory/steering/` if it does not exist.

Write all four files:

**`.claude/memory/steering/tech-stack.md`**

---
scope: tech-stack
loaded-by: sdd-specify, sdd-plan, sdd-execute, sdd-research, sdd-review
---

# Tech Stack

## Languages
[Detected: {{language}} — edit to match reality]

## Frameworks
[Detected: {{framework}} — edit to match reality]

## Infrastructure
[Detected: {{infra}} — edit to match reality]

## Package Manager
[Detected: {{pkg_manager}} — edit to match reality]


**`.claude/memory/steering/test-strategy.md`**

---
scope: test-strategy
loaded-by: sdd-plan, sdd-execute, sdd-review
---

# Test Strategy

## Test Framework
[Detected: {{test_framework}} — edit to match reality]

## Test Levels
- Unit tests: [describe scope]
- Integration tests: [describe scope]
- E2E tests: [describe scope or N/A]

## Coverage Expectations
[e.g., ≥80% line coverage on business logic; 100% on critical paths]

## Mocking Policy
[e.g., Real databases in integration tests; mock only external HTTP calls]


**`.claude/memory/steering/conventions.md`**

---
scope: conventions
loaded-by: sdd-specify, sdd-plan, sdd-execute, sdd-review
---

# Conventions

## File Naming
[Detected: {{file_naming}} — edit to match reality]

## Directory Structure
[Detected: {{dir_structure}} — edit to match reality]

## Code Style
[Detected: {{code_style}} — edit to match reality]

## Architectural Patterns
[e.g., repository pattern for data access, composition over inheritance — edit to match reality]


**`.claude/memory/steering/team-practices.md`**

---
scope: team-practices
loaded-by: sdd-plan, sdd-review, using-git
---

# Team Practices

## Branching
[From docs/git-convention.md if detected — edit to match reality]

## Code Review
[e.g., 1 approver required, 24h turnaround target — edit to match reality]

## Release Process
[e.g., tag on main, semantic versioning — edit to match reality]


After writing all four files, show a one-line summary per file:
> "Steering files created in `.claude/memory/steering/`:
> - `tech-stack.md` — pre-filled with detected stack
> - `test-strategy.md` — pre-filled with detected test framework
> - `conventions.md` — pre-filled with detected structure
> - `team-practices.md` — pre-filled from git convention
>
> Edit these files to match reality — they are loaded automatically by skills when relevant."

**Abort handling:** If interrupted mid-generation, files already written are kept. No rollback. Warn: "Steering files partially created — edit `.claude/memory/steering/` to complete them."

### Step 5.3 Create docs/specs/.gitkeep

Announce: "Creating `docs/specs/` directory for feature specifications."

Create `docs/specs/.gitkeep` (empty file so the directory is tracked by git).

### Step 5.4 Create or update .claude/CLAUDE.md

**Detection order:**
1. If `.claude/CLAUDE.md` does not exist → write from `skills/sdd-init/templates/claude-md.md`, substituting `[Project Name]` with the project name detected in Step 1.5
2. If `.claude/CLAUDE.md` first line is `<!-- sdd-init: generated -->` → skip (already initialised by sdd-init)
3. If `.claude/CLAUDE.md` exists without the sentinel → append the `## Project Foundation` block below after showing the user what will be appended and getting approval

**`## Project Foundation` block to append (backward-compat path):**

```markdown
## Project Foundation

Before any feature work, read:
- `.claude/memory/foundation.md` — Mission and principles. Loaded every session.
- `.claude/memory/steering/` — Operational context. Loaded by skills when relevant.
  Each file's `loaded-by` frontmatter shows which skills incorporate it silently.
```

### Step 5.5 Create docs/git-convention.md

Announce: "Setting up your git convention. I'll ask four quick questions."

Ask the following questions **one at a time**, waiting for each answer:

**Q1 — Branch naming pattern:**
> "What branch naming pattern would you like? Examples:
> - `NNN-slug` (e.g. `002-git-flow-integration`)
> - `feat/NNN-slug` (e.g. `feat/002-git-flow-integration`)
> - `feat/TICKET-slug` (e.g. `feat/PROJ-123-git-flow`)
> Type a pattern or pick A/B/C:"

**Q2 — Ticket ID prefix (optional):**
> "Do you use an external issue tracker (JIRA, GitHub Issues, Linear)? If yes, what is the ticket prefix? (e.g. `PROJ-`, `GH-`, or press Enter to skip)"

**Q3 — Commit message format:**
> "Commit message format? Default is Conventional Commits: `<type>(<scope>): <message>`. Press Enter to accept, or type your format:"

**Q4 — Allowed commit types:**
> "Allowed commit types? Default: feat, fix, docs, chore, refactor, test. Press Enter to accept, or list yours comma-separated:"

After collecting answers, derive the POSIX regex for the chosen branch pattern:
- `NNN-slug` → `"^[0-9]+-[a-z0-9-]+$"`
- `feat/NNN-slug` → `"^(feat|fix|docs|chore|refactor|test)/[0-9]+-[a-z0-9-]+$"`
- `feat/TICKET-slug` → `"^(feat|fix|docs|chore|refactor|test)/[A-Z]+-[0-9]+-[a-z0-9-]+$"`
- Custom → generate best-effort regex and show it to the user for confirmation

Write `docs/git-convention.md` with YAML frontmatter:

```yaml
---
branch_pattern: "<derived regex>"
ticket_prefix: "<answer or empty string>"
commit_format: "<answer or default>"
allowed_types:
  - <type1>
  - <type2>
  ...
---

# Git Convention

This file is read by SDD skills to enforce branch naming and commit message standards.
To change these settings, edit this file directly.

## Examples

### Branch names
- `<example using pattern A>`
- `<example using pattern B>`

### Commit messages
- `<example using commit_format with allowed_types[0]>`
- `<example using commit_format with allowed_types[1]>`
```

**Must not:** proceed to Step 6 without this file written.

### Step 5.6 Initial Commit

After all scaffold files are written, stage and commit the foundation:

```bash
git add .claude/memory/foundation.md .claude/memory/steering/ docs/specs/.gitkeep .claude/CLAUDE.md docs/git-convention.md
git commit -m "chore: initial SDD scaffold with mission charter, steering files, and git convention"
```

## Step 6: Handoff

After all scaffold files are created, report using "Created" for new files, "Updated" for files that were appended to, and "Skipped" for files that already had SDD content:

> "Constitutional Foundation complete.
> - `.claude/memory/foundation.md` — [Created/Updated] Foundation file: mission and principles loaded every session
> - `docs/specs/` — [Created] ready for feature specifications
> - `.claude/CLAUDE.md` — [Created/Updated/Skipped] SDD workflow instructions
>
> Returning to your original request now."

Then return control to `sdd-superpowers:sdd-workflow` to route the user's original request.

## Abort Handling

If the user exits the flow at any point before Step 5 begins:
- Write NO files
- Say: "Init aborted. No files were created. Run `sdd-superpowers:sdd-workflow` again to restart the foundation setup."

**Important:** Once Step 5 begins, write all scaffold files in one uninterrupted sequence (foundation.md → steering files → .gitkeep → .claude/CLAUDE.md → git-convention.md) without pausing for user input between files. This prevents partial scaffold state if the session is interrupted mid-write.

## Error Scenarios

| Scenario | Handling |
|----------|----------|
| User aborts during Mission Charter ceremony (before foundation approval) | No files written; show abort message |
| `.claude/memory/foundation.md` exists but `docs/specs/` does not | Skip Step 5.1 only; continue with Steps 5.2–5.6 as normal; warn: "foundation already exists — creating steering files, docs/specs/, and configuring CLAUDE.md only" |
| `.claude/CLAUDE.md` exists but has no SDD content | Append SDD section after showing diff and getting approval |
| User skips git convention Q&A (presses Ctrl-C during Step 5.4) | Write no files for Step 5.4; warn: "git-convention.md not created — git-touching skills will prompt you to create it on first use." Proceed with the rest of the scaffold. |
