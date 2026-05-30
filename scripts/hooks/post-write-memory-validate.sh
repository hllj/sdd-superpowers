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
  */memory/*.md) ;;
  *) exit 0 ;;
esac

[ -f "$FILE_PATH" ] || exit 0

ISSUES=""
add_issue() { ISSUES="${ISSUES}\n- $1"; }

if ! grep -q '^---' "$FILE_PATH"; then
  add_issue "Missing YAML frontmatter. Add --- delimiters and required fields: name, description, metadata.type"
else
  FRONTMATTER=$(awk 'BEGIN{p=0} /^---/{p++; if(p==2)exit; next} p==1{print}' "$FILE_PATH")
  echo "$FRONTMATTER" | grep -q '^name:' || add_issue "Missing 'name' field in frontmatter"
  echo "$FRONTMATTER" | grep -q '^description:' || add_issue "Missing 'description' field in frontmatter"
  echo "$FRONTMATTER" | grep -q 'type:' || \
    add_issue "Missing 'metadata.type' field in frontmatter (under metadata:)"

  NAME_SLUG=$(echo "$FRONTMATTER" | grep '^name:' | \
    sed "s/^name:[[:space:]]*//" | tr -d '"'"'")

  if [ -n "$NAME_SLUG" ]; then
    if [ ! -f "${CWD}/memory/MEMORY.md" ]; then
      add_issue "memory/MEMORY.md does not exist. Create it and add: '- [Title]($(basename "$FILE_PATH")) — description'"
    elif ! grep -q "$NAME_SLUG" "${CWD}/memory/MEMORY.md"; then
      add_issue "Name slug '${NAME_SLUG}' not found in memory/MEMORY.md. Add: '- [Title]($(basename "$FILE_PATH")) — one-line description'"
    fi
  fi
fi

[ -n "$ISSUES" ] || exit 0

jq -n --arg issues "$(printf '%b' "$ISSUES")" '{
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: ("Memory file validation issues:\n" + $issues +
      "\n\nFix these before the session ends.")
  }
}'
