#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT="$PLUGIN_ROOT/scripts/hooks/post-write-memory-validate.sh"

echo "--- test_post_write_memory_validate.sh ---"

TMP=$(mktemp -d)
mkdir -p "$TMP/docs/specs" "$TMP/memory"

make_input() {
  jq -n --arg cwd "$1" --arg path "$2" \
    '{"hook_event_name":"PostToolUse","session_id":"t1","cwd":$cwd,
      "tool_name":"Write","tool_input":{"file_path":$path}}'
}

# AC-4.1: inject when frontmatter missing
echo "# No frontmatter" > "$TMP/memory/bad.md"
INPUT=$(make_input "$TMP" "$TMP/memory/bad.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_contains "$OUTPUT" "frontmatter" "AC-4.1: mentions missing frontmatter"

# AC-4.1: inject when required fields missing
cat > "$TMP/memory/partial.md" <<'EOF'
---
name: partial-test
---
# Body
EOF
INPUT=$(make_input "$TMP" "$TMP/memory/partial.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_contains "$OUTPUT" "description" "AC-4.1: mentions missing description"
assert_contains "$OUTPUT" "type" "AC-4.1: mentions missing metadata.type"

# AC-4.2: inject when slug not in MEMORY.md
cat > "$TMP/memory/valid.md" <<'EOF'
---
name: valid-memory
description: A test memory
metadata:
  type: feedback
---
# Valid memory
EOF
echo "# Memory Index" > "$TMP/memory/MEMORY.md"
INPUT=$(make_input "$TMP" "$TMP/memory/valid.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_contains "$OUTPUT" "MEMORY.md" "AC-4.2: mentions MEMORY.md entry needed"

# AC-4.3: silent when valid and indexed
echo "- [valid-memory](valid.md) — test" >> "$TMP/memory/MEMORY.md"
INPUT=$(make_input "$TMP" "$TMP/memory/valid.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "AC-4.3: silent when valid and indexed"

# Must-not: silent for writes outside memory/
INPUT=$(make_input "$TMP" "$TMP/docs/specs/001-test/spec.md")
OUTPUT=$(CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$SCRIPT" <<< "$INPUT")
assert_empty "$OUTPUT" "FR-6 must-not: silent for non-memory writes"

rm -rf "$TMP"
summarize
