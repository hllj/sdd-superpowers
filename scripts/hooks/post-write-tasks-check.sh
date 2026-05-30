#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
CWD="${CWD:-$PWD}"
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
if [[ "$FILE_PATH" != /* ]]; then
  FILE_PATH="${CWD}/${FILE_PATH}"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/lib/detect-active-spec.sh"

detect_sdd_project "$CWD" || exit 0

case "$FILE_PATH" in
  */tasks.md) ;;
  *) exit 0 ;;
esac

[ -f "$FILE_PATH" ] || exit 0

grep -q '\[ \]' "$FILE_PATH" 2>/dev/null && exit 0

grep -qE '\[[ x]\]' "$FILE_PATH" 2>/dev/null || exit 0

jq -n '{
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: "All tasks in tasks.md are complete.\n\nNext steps:\n1. Add [DONE] inline to each completed phase heading in plan.md\n   Example: \"## Phase 1: Foundation\" → \"## Phase 1: Foundation [DONE]\"\n2. Invoke sdd-review Mode B to validate spec-implementation alignment."
  }
}'
