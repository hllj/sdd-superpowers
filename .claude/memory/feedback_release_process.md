---
name: release-process
description: End-to-end release process — branch, changelog, README, version bump, tag, push
metadata:
  type: feedback
---

Always follow this sequence when cutting a release. Every step is required; don't skip or reorder.

**Why:** Partial releases (missing plugin files, stale README, wrong branch) have caused push failures and user-visible inconsistencies. This process was codified after v2.8.0 to prevent recurrence.

**How to apply:** Run through the checklist in order on every release, regardless of how small the change.

## Version number

Determine the next version using semver against the previous tag:
- **PATCH** — fixes only (no new skills, no new hooks, no workflow changes)
- **MINOR** — new features, new skills, new hooks, workflow additions (backward-compatible)
- **MAJOR** — breaking changes to skill interfaces or gate behaviour

Check `git log <last-tag>..HEAD --oneline` to assess the scope.

## Release checklist

### 1. Create the release branch from master

```bash
git checkout master
git checkout -b release/vX.Y.Z
```

All release commits go on this branch — never directly on master.

### 2. Update CHANGELOG.md

Add a new `## [X.Y.Z] - YYYY-MM-DD` section above the previous release.
Structure: `### Added`, `### Changed`, `### Fixed` — only include sections that apply.
Each bullet: `**Feature name** (spec NNN) — one-line description of what changed and why it matters.`

### 3. Bump version in `.claude-plugin/plugin.json`

Update the `"version"` field to `"X.Y.Z"`.
Also update `"description"` if the skill count or core workflow has changed.

### 4. Bump version in `.claude-plugin/marketplace.json`

Update the `"version"` field inside the `plugins` array entry to `"X.Y.Z"`.
Also update `"description"` in the same entry if warranted.

### 5. Update README.md

Audit for stale references introduced by this release's changes:
- New skills → add row to the Skills table
- Renamed files (e.g. `constitution.md` → `foundation.md`) → update all references
- New architectural concepts → update relevant sections (e.g. "Project Context")
- Hook table → ensure script descriptions match current hook behaviour

### 6. Commit everything on the release branch

```bash
git add CHANGELOG.md .claude-plugin/plugin.json .claude-plugin/marketplace.json README.md
git commit -m "chore: release vX.Y.Z"
```

Additional fix commits (e.g. README follow-up) can be added to the release branch before tagging.

### 7. Tag the release commit

```bash
git tag vX.Y.Z
```

Tag after all release commits are in place.

### 8. Push branch and tag

```bash
git push origin release/vX.Y.Z --tags
```

Do **not** merge the release branch back into master unless the project convention explicitly calls for it.
