---
name: feedback-follow-sdd-workflow
description: Always follow the SDD workflow (brainstorm/specify/plan/tasks/execute) — never directly edit skill files without going through the workflow
metadata:
  type: feedback
---

Never directly edit skill files in this project without going through the SDD workflow first.

**Why:** The user rejected a direct-edit approach. Changes to skills must go through the spec → plan → tasks → execute pipeline. Even when the analysis is already done, the workflow enforces traceability and prevents unreviewed changes.

**How to apply:** When improving or modifying any skill in this repo, use `sdd-superpowers:sdd-brainstorm` (if fuzzy) or `sdd-superpowers:sdd-specify` (if clear) as the first step — not direct file edits. The prior analysis in conversation context can feed into the spec, but edits happen only via sdd-execute.
