#!/usr/bin/env bash
# Shared library: source this file — do not execute directly
# Provides:
#   detect_sdd_project <cwd>  — exits 0 if docs/specs/ exists, non-zero otherwise
#   detect_active_spec <cwd>  — prints active spec dir path to stdout (empty if none found);
#                               always exits 0 regardless of match result

detect_sdd_project() {
  local cwd="${1:-${CWD:-$PWD}}"
  [ -d "${cwd}/docs/specs" ]
}

detect_active_spec() {
  local cwd="${1:-${CWD:-$PWD}}"
  local specs_dir="${cwd}/docs/specs"

  [ -d "$specs_dir" ] || return 0

  # Primary: match git branch NNN prefix against spec directory names
  local branch
  branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || true)

  if [ -n "$branch" ]; then
    local spec_num
    spec_num="${branch%%[^0-9]*}"
    if [ -n "$spec_num" ]; then
      local matched
      matched=$(ls -d "${specs_dir}/${spec_num}-"*/ 2>/dev/null | head -1)
      if [ -n "$matched" ]; then
        echo "${matched%/}"
        return 0
      fi
    fi
  fi

  # Fallback: most recently modified spec directory
  local recent
  recent=$(ls -dt "${specs_dir}"/[0-9]*/ 2>/dev/null | head -1)
  echo "${recent%/}"
}
