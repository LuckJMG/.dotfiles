#!/usr/bin/env bash

# Start
if [ "$PWD" = "/mnt/c/Users/Luck" ]; then
    cd ~ || exit
fi

# Export paths
export LANG=C.UTF-8
export LANGUAGE=C.UTF-8
export LC_ALL=C.UTF-8
export LC_CTYPE=C.UTF-8
export EDITOR="code"

# Options
ZSH_THEME="dracula"
CASE_SENSITIVE="true"

# Plugins
plugins=(
  colored-man-pages
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source "$HOME/.cargo/env"
source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/packages/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh

# Functions
function update() {
  # Update & Upgrade
  sudo apt update
  sudo apt -y upgrade

  # Cleanup
  sudo apt autoremove
  sudo apt autoclean
}

# Aliases
alias aptls='apt list --installed | grep "\[installed\]"'
alias venv="source ./.venv/bin/activate"
