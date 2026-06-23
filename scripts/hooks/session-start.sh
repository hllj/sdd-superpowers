#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
CWD="${CWD:-$PWD}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/lib/detect-active-spec.sh"

detect_sdd_project "$CWD" || exit 0

MAX_CHARS=8000
CONTEXT=""

append_section() {
  local label="$1" content="$2"
  [ -n "$content" ] || return 0
  CONTEXT="${CONTEXT}
=== ${label} ===
${content}"
}

if [ -f "${CWD}/memory/foundation.md" ]; then
  append_section "memory/foundation.md" "$(cat "${CWD}/memory/foundation.md")"
fi

if [ -f "${CWD}/memory/MEMORY.md" ]; then
  append_section "memory/MEMORY.md" "$(cat "${CWD}/memory/MEMORY.md")"
fi

ACTIVE_SPEC_DIR=$(detect_active_spec "$CWD")
if [ -n "$ACTIVE_SPEC_DIR" ] && [ -f "${ACTIVE_SPEC_DIR}/spec.md" ]; then
  append_section "Active spec: ${ACTIVE_SPEC_DIR}/spec.md (first 50 lines)" \
    "$(head -50 "${ACTIVE_SPEC_DIR}/spec.md")"
fi

if [ -n "$ACTIVE_SPEC_DIR" ] && [ -f "${ACTIVE_SPEC_DIR}/tasks.md" ]; then
  OPEN=$(grep '^- \[ \]' "${ACTIVE_SPEC_DIR}/tasks.md" 2>/dev/null || true)
  [ -n "$OPEN" ] && append_section "Open tasks" "$OPEN"
fi

[ -n "$CONTEXT" ] || exit 0

CONTEXT=$(printf '%s' "$CONTEXT" | head -c "$MAX_CHARS")

jq -n --arg ctx "$CONTEXT" '{
  hookSpecificOutput: {
    hookEventName: "SessionStart",
    additionalContext: $ctx
  }
}'
