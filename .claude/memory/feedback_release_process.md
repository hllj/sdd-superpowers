---
name: feedback_release_process
description: End-to-end release checklist: branch, changelog, README, version bump in .claude-plugin/plugin.json, tag, push
metadata:
  type: feedback
---

Release steps in order:

1. Create release branch: `git checkout -b release/vX.Y.Z`
2. Bump version in `.claude-plugin/plugin.json` — `"version"` field, semver
3. Update `CHANGELOG.md` — add new `## [X.Y.Z] - YYYY-MM-DD` section above the previous release
4. Update `README.md` — any version badge or "latest release" references
5. Commit: `chore(release): bump version to vX.Y.Z`
6. Push branch and merge to `master`
7. Create and push git tag: `git tag vX.Y.Z && git push origin vX.Y.Z`

**Why:** Documented by user as the canonical release process for this project.

**How to apply:** Follow this order exactly when the user asks to release a new version. Never skip the CHANGELOG or README update before tagging.
