---
name: Release process — plugin version files
description: Always bump .claude-plugin/plugin.json and .claude-plugin/marketplace.json as part of every release, not just CHANGELOG.md
type: feedback
---

Always bump the version in `.claude-plugin/plugin.json` AND `.claude-plugin/marketplace.json` as part of every release — not just CHANGELOG.md.

**Why:** User caught this omission during the v2.3.0 release; the push was blocked until plugin files were updated.

**How to apply:** When creating a release branch and tag, the release checklist is:
1. CHANGELOG.md — new version section + comparison link
2. `.claude-plugin/plugin.json` — bump `version` field
3. `.claude-plugin/marketplace.json` — bump `version` field inside the plugins array
4. Also update the `description` field in both plugin files if the skill count or workflow changes
5. Commit all three together (or as a separate "bump plugin version" commit), then tag
