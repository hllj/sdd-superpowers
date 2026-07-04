---
name: session-wrap
description: Use when ending a session to capture memory candidates and narrative lessons before context is lost
---

# Session Wrap

**Announce at start:** "Starting session-wrap to capture session memory and lessons."

Scan the conversation for knowledge worth preserving. Present candidates for approval. Write only what the user approves — skipped candidates produce no files.

## Quick Mode (auto-digest)

**When invoked by an endpoint skill (e.g., `finishing-a-development-branch`) or routed via `sdd-workflow`.** Scan the conversation and produce a digest of up to 5 candidates labeled by type:

```
**Memory candidates:**
- [feedback] <summary>

**Lesson candidates:**
- [lesson] <summary>

Save these?
1. **Save all** — write all to standard locations; report "N memories written, M lessons written"; suggest commit
2. **Select** — name bullets to keep; write only those
3. **Skip** — save nothing
4. **Deep Mode** — hand off to Deep Mode below
```

**Select with no bullets named:** Treat as Skip — write nothing.
**No candidates:** Report "Nothing worth saving found this session." Close without prompting.
**Over 5:** Present top 5 by significance; note more are available in deep mode.
**On write:** Memory → `.claude/memory/<slug>.md` + `MEMORY.md`. Lessons → `docs/lessons/YYYY-MM-DD-<slug>.md` (create if needed). On memory slug collision, warn before overwriting. Suggest `chore(memory): capture session learnings`.

## Deep Mode (full review)

**When invoked directly by the user.** Scan and review each candidate individually.

### Memory Phase

Scan for facts that are non-obvious from code or git history. Group by type, omit empty groups:

| Type | What to scan for |
|------|-----------------|
| `feedback` | Approach corrections or validations the user gave |
| `project` | Status, goal, or deadline changes that occurred |
| `user` | New preferences or expertise observed |
| `reference` | External resources, tools, or docs encountered |

For each candidate, present: type, slug, rationale, and body (Why + How to apply). Ask: Approve, Edit, or Skip? On approval, write `.claude/memory/<slug>.md` and add to `MEMORY.md`. Warn before overwriting an existing slug.

**If no candidates found:** Report "No memory candidates found" and proceed to the lesson phase.

### Lesson Phase

Scan for narrative learnings worth referencing in future specs or plans:

- Decisions that required non-obvious reasoning
- Approaches that failed before the working solution was found
- Surprises or constraints discovered during implementation
- Insights that would change how future specs or plans are written

Present each candidate using the lesson template (see `templates/lesson.md`).

**On approval:** If `docs/lessons/` does not exist, create it. Write to `docs/lessons/YYYY-MM-DD-<slug>.md` (replacing `YYYY-MM-DD` with today's ISO 8601 date).

**If no candidates found:** Report "No lesson candidates found."

### Closing Summary

Report "N memories written, M lessons written." If files were written, suggest: `chore(memory): capture session learnings`.

## Constraints

- Does NOT spawn subagents — operates entirely from live conversation context
- Does NOT write any file the user has not explicitly approved
- Does NOT re-propose skipped candidates
- Quick Mode does NOT auto-write files — the user must explicitly choose "Save all" or "Select"
