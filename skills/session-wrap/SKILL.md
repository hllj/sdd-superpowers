---
name: session-wrap
description: Use when ending a session to capture memory candidates and narrative lessons before context is lost
---

# Session Wrap

**Announce at start:** "I'm using the session-wrap skill to capture memory and lessons from this session."

Scan the conversation for knowledge worth preserving. Present candidates for approval. Write only what the user approves — skipped candidates produce no files.

## Memory Phase

Scan for facts that are non-obvious from code or git history. Group by type, omit empty groups:

| Type | What to scan for |
|------|-----------------|
| `feedback` | Approach corrections or validations the user gave |
| `project` | Status, goal, or deadline changes that occurred |
| `user` | New preferences or expertise observed |
| `reference` | External resources, tools, or docs encountered |

Present each candidate in this format:

```
**Type:** feedback
**Slug:** my-slug
**Rationale:** Why this is non-obvious (one sentence)

---
name: my-slug
description: one-line summary
metadata:
  type: feedback
---

Body text here.

**Why:** What makes this worth remembering.
**How to apply:** When and how to use this.
```

For each candidate, ask: "Approve (write as-is), Edit (write your version), or Skip?" Only approved or edited entries are written.

**On approval:** Write `.claude/memory/<slug>.md` with the frontmatter above. Add a line to `.claude/memory/MEMORY.md`: `- [Description](slug.md) — one-line summary`.

**Collision check:** If `.claude/memory/<slug>.md` already exists, warn before writing: "A memory file with this name already exists — overwrite or choose a new slug?"

**If no candidates found:** Report "No memory candidates found" and proceed to the lesson phase.

## Lesson Phase

Scan for narrative learnings the team would want to reference in future specs or plans:

- Decisions that required non-obvious reasoning
- Approaches that failed before the working solution was found
- Surprises or constraints discovered during implementation
- Insights that would change how future specs or plans are written

Present each candidate using the lesson template (see `templates/lesson.md`):

```
**Slug:** YYYY-MM-DD-my-slug
**Tags:** [tag1, tag2]
**Spec:** NNN (optional)

---
date: YYYY-MM-DD
spec: "NNN"
tags: [tag1, tag2]
---

# Lesson: <title>

## Context
...

## What happened
...

## What to do next time
...

## Signals to watch for
...
```

For each candidate, ask: "Approve, Edit, or Skip?"

**On approval:** If `docs/lessons/` does not exist, create it. Write the file to `docs/lessons/YYYY-MM-DD-<slug>.md`.

**If no candidates found:** Report "No lesson candidates found."

## Closing Summary

After both phases:

1. Report: "N memories written, M lessons written."
2. If any files were written: "Commit new files to version control — suggested: `chore(memory): capture session learnings`"

## Constraints

- Does NOT spawn subagents — operates entirely from live conversation context
- Does NOT write any file the user has not explicitly approved
- Does NOT re-propose skipped candidates
