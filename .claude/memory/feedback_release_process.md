---
name: feedback_release_process
description: End-to-end release checklist: branch, changelog, README, version bump in .claude-plugin/plugin.json AND .claude-plugin/marketplace.json, tag, push
metadata:
  type: feedback
---

Release steps in order:

1. Create release branch: `git checkout -b release/vX.Y.Z`
2. Bump version in `.claude-plugin/plugin.json` — `"version"` field, semver
3. Bump version in `.claude-plugin/marketplace.json` — `"plugins"[0]."version"` field, must match plugin.json exactly
4. Update `CHANGELOG.md` — add new `## [X.Y.Z] - YYYY-MM-DD` section above the previous release
5. Update `README.md` — any version badge or "latest release" references
6. Commit: `chore(release): bump version to vX.Y.Z`
7. Push branch: `git push -u origin release/vX.Y.Z`
8. Create PR: `gh pr create --base master --head release/vX.Y.Z ...` — do this BEFORE merging
9. Merge to `master` (via PR or locally after PR is open)
10. Create and push git tag: `git tag vX.Y.Z && git push origin vX.Y.Z`

**Why:** Documented by user as the canonical release process for this project. PR must be created before merging — GitHub rejects PRs with no diff (already-merged branches). `marketplace.json` was found stale at 2.8.0 during the v2.10.0 release (missed across the 2.8.1 and 2.9.0 releases too) — it has its own independent `"version"` field under `plugins[0]` that plugin.json's bump does NOT update, since they are separate files with no cross-reference.

**How to apply:** Follow this order exactly when the user asks to release a new version. Never skip the CHANGELOG or README update before tagging. Never merge locally before creating the PR. Always grep both `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` for the old version string before considering the version-bump step done — a match in only one file means the other was missed.
