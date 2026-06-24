---
scope: tech-stack
loaded-by: sdd-specify, sdd-plan, sdd-execute, sdd-research, sdd-review
---

# Tech Stack

## Languages
Bash (hook scripts, test harness) — primary implementation language for all automation

## Frameworks
Claude Code plugin framework (superpowers) — skills are markdown files read by the Skill tool; hooks are shell scripts registered in hooks/hooks.json

## Infrastructure
No external infrastructure — runs entirely within Claude Code sessions; hooks execute as subprocesses via the Claude Code harness

## Package Manager
None — no compiled dependencies; jq required at runtime for JSON processing in hooks
