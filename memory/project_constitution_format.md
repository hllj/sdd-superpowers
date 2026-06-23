---
name: project-constitution-format
description: memory/foundation.md is the Tier 0 project identity file — no frontmatter required; hook whitelist exempts it from validation
metadata:
  type: project
---

`memory/foundation.md` is the project foundation file introduced in feature 014 (tiered-memory-architecture). It holds Mission, Principles, Operational Context pointer, and Amendment Process — no YAML frontmatter.

**Why:** The PostToolUse:Write hook validates all files written to `memory/` as memory entries and required YAML frontmatter. `foundation.md` is not a memory entry; it is the Tier 0 project identity file. Feature 014 added a hook whitelist that exempts `foundation.md`, `MEMORY.md`, and `steering/*.md` from frontmatter validation — the hook is now silent for these files.

**How to apply:** No action needed. The whitelist handles it automatically. If the hook fires on `foundation.md` in a project that has not yet applied feature 014's hook update, the old guidance applies: ignore the warning.
