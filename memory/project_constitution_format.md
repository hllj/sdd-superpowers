---
name: project-constitution-format
description: memory/constitution.md uses Mission Charter format (not nine-article), and the PostToolUse:Write hook incorrectly flags it for missing frontmatter
metadata:
  type: project
---

`memory/constitution.md` now uses the Mission Charter format introduced in feature 013 (sdd-init-redesign). It has sections: Mission, Principles, Operational Context, Amendment Process — no YAML frontmatter.

**Why:** The PostToolUse:Write hook validates all files written to `memory/` as memory entries and requires YAML frontmatter. The constitution is not a memory entry; it is a project foundation file with its own schema.

**How to apply:** When the hook fires on a write to `memory/constitution.md` and complains about missing frontmatter — ignore the warning. If updating the hook, whitelist `constitution.md`, `MEMORY.md`, and `memory/steering/*.md` from the frontmatter validation rule.
