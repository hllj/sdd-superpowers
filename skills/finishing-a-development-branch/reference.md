# Finishing a Development Branch: Full Process Reference

> Complete step-by-step procedure for each integration option. See [SKILL.md](SKILL.md) for the summary.

## Step 1: Verify Tests

**Before presenting options, verify tests pass:**

```bash
npm test / cargo test / pytest / go test ./...
```

**If tests fail:**
```
Tests failing (<N> failures). Must fix before completing:

[Show failures]

Cannot proceed with merge/PR until tests pass.
```

Stop. Don't proceed to Step 2.

**If tests pass:** Continue to Step 2.

## Step 2: Determine Base Branch

```bash
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

Or ask: "This branch split from main - is that correct?"

## Step 2.5: Prepare Merge Commit Message

Invoke `sdd-superpowers:using-git` — **Merge Commit Message**

Pass to `sdd-superpowers:using-git`:
- Current branch name: `git branch --show-current`

`sdd-superpowers:using-git` will handle: convention loading, scope derivation, message suggestion, validation, re-prompting on violation.

Store the confirmed message returned by `sdd-superpowers:using-git` as `<merge-commit-message>`.

## Step 3: Present Options

Present exactly these 4 options:

```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work

Which option?
```

**Don't add explanation** - keep options concise.

## Step 4: Execute Choice

### Option 1: Merge Locally

```bash
git checkout <base-branch>
git pull
git merge --no-ff <feature-branch> -m "<merge-commit-message>"
<test command>
git branch -d <feature-branch>
```

Then: Cleanup worktree (Step 5)

### Option 2: Push and Create PR

```bash
git push -u origin <feature-branch>
gh pr create --title "<merge-commit-message>" --body "$(cat <<'EOF'
## Summary
<2-3 bullets of what changed>

## Test Plan
- [ ] <verification steps>
EOF
)"
```

Then: Cleanup worktree (Step 5)

### Option 3: Keep As-Is

Report: "Keeping branch <name>. Worktree preserved at <path>."

**Don't cleanup worktree.**

### Option 4: Discard

**Confirm first:**
```
This will permanently delete:
- Branch <name>
- All commits: <commit-list>
- Worktree at <path>

Type 'discard' to confirm.
```

Wait for exact confirmation. If confirmed:
```bash
git checkout <base-branch>
git branch -D <feature-branch>
```

Then: Cleanup worktree (Step 5)

## Step 5: Cleanup Worktree (if applicable)

This step applies only if the branch was created inside a git worktree. In the standard SDD flow, branches are created directly in the main checkout — no worktree cleanup is needed; skip this step.

**For Options 1, 2, 4 (only if a worktree was used):**

```bash
git worktree list | grep $(git branch --show-current)
```

If yes:
```bash
git worktree remove <worktree-path>
```

**For Option 3:** Keep worktree.

## Integration

**Called by:**
- **subagent-driven-development** (Step 7) — after all tasks complete
- **executing-plans** (Step 5) — after all batches complete

**Pairs with:**
- **using-git** — merge commit message (Step 2.5) and worktree cleanup (Step 5, when in use)
