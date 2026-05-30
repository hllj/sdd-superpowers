#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT="$PLUGIN_ROOT/scripts/hooks/post-write-tasks-check.sh"

echo "--- test_post_write_tasks_check.sh ---"

TMP=$(mktemp -d)
mkdir -p "$TMP/docs/specs/012-test"

make_input() {
  jq -n --arg cwd "$1" --arg path "$2" --arg tool "$3" \
    '{"hook_event_name":"PostToolUse","session_id":"t1","cwd":$cwd,
      "tool_name":$tool,"tool_input":{"file_path":$path}}'
}

TASKS="$TMP/docs/specs/012-test/tasks.md"

# AC-2.4: non-tasks.md file → silent
echo "- [ ] task" > "$TMP/something.md"
INPUT=$(make_input "$TMP" "$TMP/something.md" "Write")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "AC-2.4: non-tasks.md file → silent"

# AC-2.5: non-SDD project (no docs/specs/) → silent
TMP2=$(mktemp -d)
echo "- [ ] task" > "$TMP2/tasks.md"
INPUT=$(make_input "$TMP2" "$TMP2/tasks.md" "Write")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "AC-2.5: non-SDD project → silent"
rm -rf "$TMP2"

# AC-2.2: at least one [ ] remains → silent
cat > "$TASKS" <<'EOF'
- [x] task 1
- [ ] task 2
- [x] task 3
EOF
INPUT=$(make_input "$TMP" "$TASKS" "Write")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "AC-2.2: partial completion → silent"

# AC-2.3: no checkbox lines → silent
echo "# Just a heading" > "$TASKS"
INPUT=$(make_input "$TMP" "$TASKS" "Write")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "AC-2.3: no checkbox lines → silent"

# AC-2.1: all tasks [x] → inject additionalContext (Write)
cat > "$TASKS" <<'EOF'
- [x] task 1
- [x] task 2
- [x] task 3
EOF
INPUT=$(make_input "$TMP" "$TASKS" "Write")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_contains "$OUTPUT" "additionalContext" "AC-2.1: all-done injects additionalContext"
assert_contains "$OUTPUT" "plan.md" "AC-2.1: reminder mentions plan.md"
assert_contains "$OUTPUT" "sdd-review" "AC-2.1: reminder mentions sdd-review"

# AC-2.1: fires on Edit tool too
INPUT=$(make_input "$TMP" "$TASKS" "Edit")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_contains "$OUTPUT" "additionalContext" "AC-2.1: fires on Edit tool too"

rm -rf "$TMP"
summarize
