#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
CWD="${CWD:-$PWD}"
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/lib/detect-active-spec.sh"

detect_sdd_project "$CWD" || exit 0

case "$FILE_PATH" in
  */docs/specs/*/tasks.md) ;;
  *) exit 0 ;;
esac

SPEC_DIR=$(dirname "$FILE_PATH")

if [ ! -f "${SPEC_DIR}/plan.md" ]; then
  jq -n --arg reason "SDD Gate: plan.md not found in ${SPEC_DIR}. Run sdd-plan first." '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: $reason
    }
  }'
fi

exit 0
