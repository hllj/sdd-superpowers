#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT="$PLUGIN_ROOT/scripts/hooks/session-start.sh"

echo "--- test_session_start.sh ---"

TMP=$(mktemp -d)
mkdir -p "$TMP/docs/specs/011-plugin-hooks"
mkdir -p "$TMP/memory"
echo "# Constitution content" > "$TMP/memory/constitution.md"
echo "- [Memory](test.md)" > "$TMP/memory/MEMORY.md"
cat > "$TMP/docs/specs/011-plugin-hooks/spec.md" <<'EOF'
# Feature 011: Plugin Hooks
**Status:** Approved
## Problem Statement
Test spec content line 3
EOF
cat > "$TMP/docs/specs/011-plugin-hooks/tasks.md" <<'EOF'
- [x] done task
- [ ] open task 1
- [ ] open task 2
EOF

INPUT=$(jq -n --arg cwd "$TMP" \
  '{"hook_event_name":"SessionStart","session_id":"t1","cwd":$cwd}')

# AC-1.1: constitution and MEMORY.md injected
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" CWD="$TMP" bash "$SCRIPT" <<< "$INPUT")
assert_contains "$OUTPUT" "Constitution content" "AC-1.1: constitution.md injected"
assert_contains "$OUTPUT" "Memory" "AC-1.1: MEMORY.md injected"

# AC-1.2: active spec summary injected (mock git to match branch)
OUTPUT=$(cd "$TMP" && git() { echo "011-plugin-hooks"; }; export -f git; \
         CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" CWD="$TMP" bash "$SCRIPT" <<< "$INPUT")
assert_contains "$OUTPUT" "Feature 011" "AC-1.2: spec.md first 50 lines injected"

# AC-1.3: unchecked tasks injected, checked excluded
assert_contains "$OUTPUT" "open task 1" "AC-1.3: unchecked task 1 included"
assert_contains "$OUTPUT" "open task 2" "AC-1.3: unchecked task 2 included"
if echo "$OUTPUT" | grep -q "done task"; then
  FAIL=$((FAIL + 1)); echo "  FAIL: AC-1.3: checked task must not appear"
else
  PASS=$((PASS + 1)); echo "  PASS: AC-1.3: checked task excluded"
fi

# AC-1.4: silent outside SDD project
TMP_NOSDD=$(mktemp -d)
INPUT_NOSDD=$(jq -n --arg cwd "$TMP_NOSDD" \
  '{"hook_event_name":"SessionStart","session_id":"t1","cwd":$cwd}')
OUTPUT_NOSDD=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT_NOSDD")
assert_empty "$OUTPUT_NOSDD" "AC-1.4: no output outside SDD project"

rm -rf "$TMP" "$TMP_NOSDD"
summarize
