#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT="$PLUGIN_ROOT/scripts/hooks/pre-write-tasks-gate.sh"

echo "--- test_pre_write_tasks_gate.sh ---"

TMP=$(mktemp -d)
mkdir -p "$TMP/docs/specs/001-test"

make_input() {
  jq -n --arg cwd "$1" --arg path "$2" \
    '{"hook_event_name":"PreToolUse","session_id":"t1","cwd":$cwd,
      "tool_name":"Write","tool_input":{"file_path":$path}}'
}

# AC-3.1: deny when plan.md missing
INPUT=$(make_input "$TMP" "$TMP/docs/specs/001-test/tasks.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_json_field "$OUTPUT" '.hookSpecificOutput.permissionDecision' "deny" \
  "AC-3.1: deny when plan.md missing"
assert_contains "$OUTPUT" "sdd-plan" "AC-3.1: denial names sdd-plan"

# AC-3.2: allow when plan.md exists
touch "$TMP/docs/specs/001-test/plan.md"
INPUT=$(make_input "$TMP" "$TMP/docs/specs/001-test/tasks.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "AC-3.2: no output when plan.md exists"

# AC-3.3: silent for non-tasks.md writes
INPUT=$(make_input "$TMP" "$TMP/docs/specs/001-test/notes.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "AC-3.3: silent for non-tasks.md paths"

# Must-not: silent for tasks.md outside docs/specs/
INPUT=$(make_input "$TMP" "/tmp/other/tasks.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "FR-5 must-not: silent for tasks.md outside docs/specs/"

rm -rf "$TMP"
summarize
