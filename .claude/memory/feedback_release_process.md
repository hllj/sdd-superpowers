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
6. Push branch: `git push -u origin release/vX.Y.Z`
7. Create PR: `gh pr create --base master --head release/vX.Y.Z ...` — do this BEFORE merging
8. Merge to `master` (via PR or locally after PR is open)
9. Create and push git tag: `git tag vX.Y.Z && git push origin vX.Y.Z`

**Why:** Documented by user as the canonical release process for this project. PR must be created before merging — GitHub rejects PRs with no diff (already-merged branches).

**How to apply:** Follow this order exactly when the user asks to release a new version. Never skip the CHANGELOG or README update before tagging. Never merge locally before creating the PR.
