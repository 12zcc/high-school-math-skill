#!/usr/bin/env bash
# Install the high-school-math skill for common AI coding tools.
# Usage: ./install.sh [--project]

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_DIR="$ROOT/high-school-math"
NAME="high-school-math"

HOME_DIR="${HOME:-$USERPROFILE}"

install_skill() { # label dest
  local label="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  cp -r "$SKILL_DIR" "$dst"
  echo "  [ok] $label: $dst"
}

install_rule() { # label src dest
  local label="$1" src="$2" dst="$3"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "  [ok] $label: $dst"
}

echo "high-school-math skill installer"
echo "=================================================="

install_skill "claude code" "$HOME_DIR/.claude/skills/$NAME"
install_skill "opencode" "$HOME_DIR/.config/opencode/skills/$NAME"
install_skill "agents/skills" "$HOME_DIR/.agents/skills/$NAME"
install_rule "cursor (rule)" "$ROOT/.cursor/rules/$NAME.mdc" "$HOME_DIR/.cursor/rules/$NAME.mdc"

if [[ "${1:-}" == "--project" ]]; then
  CWD="$(pwd)"
  install_skill "opencode (project)" "$CWD/.opencode/skills/$NAME"
  install_skill "claude (project)" "$CWD/.claude/skills/$NAME"
  install_rule "copilot (project)" "$ROOT/.github/copilot-instructions.md" "$CWD/.github/copilot-instructions.md"
fi

echo "=================================================="
echo "Done. Restart your AI tool(s) to (re)load the skill."
