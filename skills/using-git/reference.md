# Using Git: Full Operations Reference

> Complete convention loading, all four operations, error table, and worktrees guide. See [SKILL.md](SKILL.md) for the summary.

## Convention Loading

**Applies before every operation.**

Read `docs/git-convention.md` from the project root. Parse YAML frontmatter:
- `branch_pattern` — POSIX regex for valid branch names
- `ticket_prefix` — expected ticket ID prefix (empty string if none)
- `commit_format` — commit message format string
- `allowed_types` — list of valid commit type prefixes

**If `docs/git-convention.md` is missing:**
- No `CLAUDE.md` in project root (new project): halt — "Run `sdd-init` first to establish a git convention."
- `CLAUDE.md` exists (existing project): offer one-time creation dialogue:
  > "I need to set up your git convention. I'll ask 4 quick questions."
  Ask the same 4 questions as `sdd-init` Step 5.4. Write `docs/git-convention.md`. Continue.
- If user declines the dialogue: halt — do not perform any git operation.

## Direct Invocation — Operation Menu

When invoked without a specified operation, present:

> "Which git operation?
> 1. Create branch
> 2. Ad-hoc commit
> 3. Merge commit message
> 4. Show convention"

Wait for selection, then run the corresponding operation.

**Option (4) Show convention:** Read `docs/git-convention.md` and display:
- Branch pattern: `<branch_pattern>` regex
- Commit format: `<commit_format>`
- Allowed types: `<allowed_types list>`
- Examples section from the file

## Operation A — Branch Creation

**Invoked by:** `sdd-tasks` Step 5, or directly via menu option (1)

**Inputs:** spec folder path (`docs/specs/NNN-slug/`), optional ticket ID

**Steps:**

1. Load convention.

2. Prompt for ticket ID if not already provided:
   > "Do you have an external ticket ID? (e.g. PROJ-123) Press Enter to skip."

3. Generate branch name suggestions:
   - **A:** `NNN-<feature-slug>` derived from the spec folder name
   - **B:** ticket-ID-based per `branch_pattern` (only if ticket ID provided)
   - **C:** "Type a custom name"

4. Present:
   > "Choose a branch name:
   > A) `<suggestion A>`
   > B) `<suggestion B>` (if ticket ID provided)
   > C) Type a custom name"

5. Validate chosen name against `branch_pattern` regex:
   - Matches → proceed
   - Doesn't match → warn: "Branch name `<name>` doesn't match the convention pattern `<pattern>`. Proceed anyway? (yes/no)" — require explicit yes

6. If branch already exists:
   > "Branch `<name>` already exists. Options:
   > 1. Switch to existing branch
   > 2. Choose a different name
   > 3. Abort"
   Wait for selection.

7. If on `main` or `master`: refuse — "Cannot create a branch from the default branch. Check out a base branch first."

8. Create:
   ```bash
   git checkout -b <name>
   ```

**Output:** Branch name created (reported back to caller or confirmed to user)

## Operation B — Doc-First Commit

**Invoked by:** `sdd-tasks` Step 5 immediately after Operation A

**Inputs:** spec folder path (`docs/specs/NNN-slug/`)

**Steps:**

1. Stage spec folder contents only:
   ```bash
   git add docs/specs/<NNN>-<feature-slug>/
   ```
   Do NOT stage any source code or test files outside `docs/specs/`.

2. Propose commit message:
   > "Proposed commit: `docs(<NNN>-<feature-slug>): add spec, plan, and tasks`
   > Confirm this message, or type an alternative:"

3. Validate confirmed message against `commit_format` and `allowed_types`. If invalid:
   > "Message `<message>` violates the convention: `<reason>`. Expected format: `<commit_format>`.
   > Type a valid message:"
   Re-prompt until valid.

4. Execute:
   ```bash
   git commit -m "<confirmed message>"
   ```

5. If commit fails (nothing staged, git error):
   > "Commit failed: `<exact git error output>`. Resolve the issue and re-run this step."
   Halt. Do not proceed until resolved.

**Output:** Commit SHA (confirm with `git log --oneline -1`, report to caller)

## Operation C — Per-Task Commit

**Invoked by:** `sdd-execute` Step 3e (delegation only — NOT available in the direct menu)

**Inputs:** prior commit SHA (from caller), task description

**Steps:**

1. Check for merge conflicts:
   ```bash
   git status
   ```
   If output contains `<<<<<<`, `=======`, or `>>>>>>>`:
   > "Merge conflicts detected in: `<file list>`. Resolve conflicts, then re-run this step."
   Halt until conflicts cleared.

2. Stage files modified or added since prior SHA:
   ```bash
   git add $(git diff --name-only HEAD)
   git add $(git ls-files --others --exclude-standard)
   ```
   Do NOT re-stage files already committed before this task began (verified against prior SHA).

3. Propose commit message:
   > "Proposed commit: `feat(<NNN>-<slug>): <task description>`
   > Confirm this message, or type an alternative:"

4. Validate confirmed message against `commit_format` and `allowed_types`. If invalid, show violation reason + corrected suggestion + re-prompt until valid.

5. Execute:
   ```bash
   git commit -m "<confirmed message>"
   ```

6. Verify and report:
   ```bash
   git log --oneline -1
   ```

**Output:** New commit SHA returned to caller (`sdd-execute`)

## Operation D — Merge Commit Message

**Invoked by:** `finishing-a-development-branch` Step 2.5, or directly via menu option (3)

**Inputs:** current branch name

**Steps:**

1. Derive feature scope from branch name (e.g. `002-git-flow-integration` → scope `002-git-flow-integration`).

2. Suggest compliant message:
   > "Proposed merge commit: `feat(<scope>): merge <feature-description>`
   > Confirm this message, or type an alternative:"

3. Validate:
   - Type must be in `allowed_types`
   - Format must match `commit_format`

   If invalid, show violation + corrected suggestion + re-prompt until valid.

4. Do NOT validate or reject the source branch name — only the commit message is enforced.

**Output:** Confirmed message returned to caller

## Error Reference

| Scenario | Behavior |
|----------|----------|
| `docs/git-convention.md` missing, new project | Halt: "Run `sdd-init` first" |
| `docs/git-convention.md` missing, existing project | Offer 4-question creation dialogue |
| User declines convention creation | Halt without git operation |
| Branch name violates `branch_pattern` | Warn + "Proceed anyway? (yes/no)" — require explicit yes |
| Branch already exists | Offer: switch / choose different / abort |
| On `main`/`master` at branch creation | Refuse; instruct to check out a base branch |
| Merge conflicts at per-task commit | Halt; list conflicting files; wait for resolution |
| Commit message violates convention | Show violation + corrected suggestion + re-prompt |
| Commit fails (nothing staged, git error) | Report exact git output; halt until resolved |
| Git not initialised | Detect; offer `git init && git add -A && git commit -m "chore: initial commit"` |

## Advanced: Parallel Workstreams with Worktrees

> **This is not part of the standard SDD workflow.** Use only when you need multiple branches checked out simultaneously.

### Before creating a worktree

Verify the target directory is gitignored:

```bash
git check-ignore -q .worktrees
```

If not ignored, add `.worktrees/` to `.gitignore` and commit before proceeding.

### Create a worktree

```bash
git worktree add .worktrees/my-feature -b feat/my-feature
cd .worktrees/my-feature
```

### Remove a worktree

```bash
git worktree remove .worktrees/my-feature
git branch -d feat/my-feature
```
