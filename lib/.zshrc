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
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
. /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh
. "$HOME/.cargo/env"
source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/packages/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Functions
function update() {
  # Update & Upgrade
  sudo apt update
  sudo apt -y upgrade
  brew update
  brew upgrade

  # Cleanup
  sudo apt autoremove
  sudo apt autoclean
  brew autoremove
  brew cleanup
}

# Aliases
## Files
alias zshrc="code ~/.zshrc"
alias npmrc="code ~/.npmrc"
alias gitconfig="code ~/.gitconfig"

## Folders
alias packages="cd ~/packages"
alias projects="cd ~/projects"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias dotfiles="cd ~/.dotfiles && code ~/.dotfiles"

## Python
alias venv="source ./.venv/bin/activate"
