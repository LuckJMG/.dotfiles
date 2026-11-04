#!/bin/sh
# Link the shared agent config in ~/.dotfiles/agents into each agent's home.
# Run again after adding a skill. A real file or directory at a target moves to ~/.agents-backup.
set -eu
A="$HOME/.dotfiles/agents"

link() { # link <source> <target>
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then mkdir -p "$HOME/.agents-backup" && mv "$2" "$HOME/.agents-backup/$(basename "$2").$(date +%s)"; fi
  ln -sfn "$1" "$2"
}

# Claude: one link per skill, because Claude keeps its own skills in the same directory.
link "$A/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link "$A/commands"  "$HOME/.claude/commands"
for s in "$A"/skills/*/; do link "${s%/}" "$HOME/.claude/skills/$(basename "$s")"; done

# Antigravity: global root is ~/.gemini/config. GEMINI.md is the documented IDE rules file.
link "$A/AGENTS.md" "$HOME/.gemini/config/AGENTS.md"
link "$A/AGENTS.md" "$HOME/.gemini/GEMINI.md"
link "$A/skills"    "$HOME/.gemini/config/skills"
