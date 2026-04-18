---
name: sdd-review
description: Use when a spec needs a completeness check before planning, or when implementation claims to be complete and needs spec-alignment validation
---

# SDD: Review

**Announce at start:** "I'm using the sdd-review skill to validate spec-implementation alignment."

## Overview

Two-mode skill: Mode A validates a spec is complete and implementable before planning; Mode B validates that implementation matches the spec after execution. In SDD, the spec is truth — this skill surfaces drift between spec and code before it becomes technical debt.

## When to Use

**Mode A (spec review):** before running `sdd-superpowers:sdd-plan`, when a spec has `[NEEDS CLARIFICATION]` items, or when a spec feels underspecified.

**Mode B (implementation review):** after `sdd-superpowers:sdd-execute` completes, before merging — confirms every acceptance criterion has a passing test.

**NOT for:** style reviews, code quality opinions, or general debugging.

## Quick Reference

| Mode | Trigger | Output |
|------|---------|--------|
| Mode A — Spec Review | "Review the spec before we plan" | READY TO PLAN or NEEDS REVISION |
| Mode B — Implementation Review | "Review the implementation for NNN" | SPEC-ALIGNED, DRIFT DETECTED, or INCOMPLETE |

```
NO COMPLETION CLAIMS WITHOUT RUNNING VERIFICATION COMMANDS AND READING THEIR OUTPUT
```

"Tests pass" requires running the command and reading output. "Spec-aligned" requires a line-by-line coverage matrix — not a general impression.

See [reference.md](reference.md) for Mode A checklist (completeness, ambiguity scan, feasibility check), Mode B procedure (coverage matrix, drift detection, contract validation, test run), and full report templates.
