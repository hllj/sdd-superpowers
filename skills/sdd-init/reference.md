# SDD Init: Full Initialisation Procedure

> This file contains the complete step-by-step procedure for `sdd-superpowers:sdd-init`. See [SKILL.md](SKILL.md) for the summary.

**Announce at start:** "I'm using sdd-init to set up the project foundation for this new SDD project."

<HARD-GATE>
Do NOT create any feature specs, plans, or code until the constitution is approved and the scaffold is written. This skill produces ONLY the project foundation.
</HARD-GATE>

## Step 1: Announce and Orient

Tell the user:
> "Before we begin feature work, I'll walk you through the Mission Charter — four questions that capture your project's purpose and principles. Nothing is written until you approve the final result."

## Step 1.5: Explore Project Context

Before presenting any Articles, gather context about the project to personalise defaults.

Dispatch a codebase exploration subagent with these instructions:

> "Read the following files if they exist: README.md, package.json, pyproject.toml, Cargo.toml, go.mod, requirements.txt, composer.json. Also list the top-level directory structure (one level deep). Produce a Project Profile with these fields:
> - **Language:** primary language(s)
> - **Framework:** main framework(s) or 'none detected'
> - **Type:** service / library / CLI tool / web app / monorepo / unclear
> - **Tests:** yes/no — framework name if detected
> - **Notable patterns:** any existing architectural conventions visible from directory structure or README
>
> If no files are found, respond: 'Empty project — no context detected.'"

Use the returned Project Profile to tailor the default text for each Article before presenting it:

| Article | How to personalise |
|---------|-------------------|
| I | If existing library structure detected → "This project already has library structure; maintain it." If monolith → emphasise the library-first split. |
| II | Use language-appropriate CLI tools in examples (Python → click/argparse, Node → commander, Go → cobra, Rust → clap). |
| III | Reference the detected test framework in examples (pytest, Jest, go test, RSpec, etc.). |
| VII | If the project is already large → note "applies to all new features added from this point." |
| IX | Tailor database/service examples to detected stack (PostgreSQL, MongoDB, Redis, etc. if inferable). |
| IV–VI | Stubs remain as `[NEEDS CLARIFICATION]` regardless of project context. |

If the project is empty or exploration returns no useful signal: use the generic defaults as written below.

### Constitution Existence Check

After the exploration subagent returns, check `memory/constitution.md`:

- **If `memory/constitution.md` does not exist:** proceed to Step 2 normally.
- **If `memory/constitution.md` exists and contains `## Article I`:**
  Announce: "An existing nine-article constitution was found at `memory/constitution.md`. Migration to the new mission-charter format is not yet supported. To start fresh: rename or delete the existing file, then re-invoke `sdd-init`. No files will be written."
  **STOP — do not proceed to Step 2 or any scaffold step.**
- **If `memory/constitution.md` exists and does NOT contain `## Article I`:**
  Announce: "A constitution already exists at `memory/constitution.md`. Skipping Phase 1 — proceeding to steering file scaffold."
  Jump to Step 5.2 (steering file generation).

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

**Must not** include SDD methodology rules (Library-First, TDD, CLI Mandate, Simplicity Gate, Anti-Abstraction, Integration-First) in the constitution.

## Step 3: Write memory/constitution.md

Announce: "Writing `memory/constitution.md`."

Create `memory/` directory if it does not exist.

Write `memory/constitution.md` using the approved draft. The file must contain exactly these sections in this order:

```markdown
# [Project Name] Constitution

> Loaded every session. To amend, follow the Amendment Process below.

## Mission
[Synthesized from Q1]

## Principles
1. [Derived from Q2 + Q3 — stated as a positive invariant]
2. [...]
3. [...]

## Operational Context
Steering files in `memory/steering/` carry project-specific operational context
(tech stack, test strategy, conventions, team practices). Each file's `loaded-by`
frontmatter lists which skills silently incorporate it during that skill's session.
Edit steering files freely — they are not subject to the amendment process.

## Amendment Process
[From Q4]
```

## Step 5: Scaffold Creation

Create files in this order. Announce each file before creating it.

### Step 5.1 Create memory/constitution.md

Announce: "Creating `memory/constitution.md` with your approved Mission Charter."

Create `memory/` directory if it does not exist.

Write `memory/constitution.md` using the approved draft from Step 3.

### Step 5.2 Generate Steering Files

Announce: "Generating steering files from your project context. Edit these to match reality."

Use the Project Profile from Step 1.5 to pre-fill each file. If the profile has no signal for a field, write `[Edit to match reality]` as the placeholder. Create `memory/steering/` if it does not exist.

Write all four files:

**`memory/steering/tech-stack.md`**

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


**`memory/steering/test-strategy.md`**

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


**`memory/steering/conventions.md`**

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


**`memory/steering/team-practices.md`**

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
> "Steering files created in `memory/steering/`:
> - `tech-stack.md` — pre-filled with detected stack
> - `test-strategy.md` — pre-filled with detected test framework
> - `conventions.md` — pre-filled with detected structure
> - `team-practices.md` — pre-filled from git convention
>
> Edit these files to match reality — they are loaded automatically by skills when relevant."

**Abort handling:** If interrupted mid-generation, files already written are kept. No rollback. Warn: "Steering files partially created — edit `memory/steering/` to complete them."

### Step 5.3 Create docs/specs/.gitkeep

Announce: "Creating `docs/specs/` directory for feature specifications."

Create `docs/specs/.gitkeep` (empty file so the directory is tracked by git).

### Step 5.4 Create or update CLAUDE.md

**Detection order:**
1. If `CLAUDE.md` does not exist → create it (see template below)
2. If `CLAUDE.md` exists and contains `## Project Foundation` → skip (already initialised)
3. If `CLAUDE.md` exists and contains `## SDD Workflow` but not `## Project Foundation` → append the `## Project Foundation` block; show the user exactly what will be appended and get approval before writing
4. If `CLAUDE.md` exists with neither marker → append the `## Project Foundation` block after showing diff and getting approval

**`## Project Foundation` block to write or append:**

```markdown
## Project Foundation

Before any feature work, read:
- `memory/constitution.md` — Mission and principles. Loaded every session.
- `memory/steering/` — Operational context. Loaded by skills when relevant.
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
git add memory/constitution.md memory/steering/ docs/specs/.gitkeep CLAUDE.md docs/git-convention.md
git commit -m "chore: initial SDD scaffold with mission charter, steering files, and git convention"
```

## Step 6: Handoff

After all scaffold files are created, report using "Created" for new files, "Updated" for files that were appended to, and "Skipped" for files that already had SDD content:

> "Constitutional Foundation complete.
> - `memory/constitution.md` — [Created/Updated] Mission Charter governing all implementation plans
> - `docs/specs/` — [Created] ready for feature specifications
> - `CLAUDE.md` — [Created/Updated/Skipped] SDD workflow instructions
>
> Returning to your original request now."

Then return control to `sdd-superpowers:sdd-workflow` to route the user's original request.

## Abort Handling

If the user exits the flow at any point before Step 5 begins:
- Write NO files
- Say: "Init aborted. No files were created. Run `sdd-superpowers:sdd-workflow` again to restart the constitutional setup."

**Important:** Once Step 5 begins, write all scaffold files in one uninterrupted sequence (constitution.md → steering files → .gitkeep → CLAUDE.md → git-convention.md) without pausing for user input between files. This prevents partial scaffold state if the session is interrupted mid-write.

## Error Scenarios

| Scenario | Handling |
|----------|----------|
| User aborts during Article review | No files written; show abort message |
| `memory/constitution.md` exists but `docs/specs/` does not | Skip Step 5.1 only; continue with Steps 5.2–5.6 as normal; warn: "constitution already exists — creating steering files, docs/specs/, and configuring CLAUDE.md only" |
| `CLAUDE.md` exists but has no SDD content | Append SDD section after showing diff and getting approval |
| User skips git convention Q&A (presses Ctrl-C during Step 5.4) | Write no files for Step 5.4; warn: "git-convention.md not created — git-touching skills will prompt you to create it on first use." Proceed with the rest of the scaffold. |
