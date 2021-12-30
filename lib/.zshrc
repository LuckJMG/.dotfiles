#!/usr/bin/env bash

# Start
if [ "$PWD" = "/mnt/c/Users/Luck" ]; then
    cd ~ || exit
    neofetch
fi

# Export paths
export LANG=en_US.UTF-8
export EDITOR="code"
export MICRO_TRUECOLOR=1

# Options
ZSH_THEME="dracula"
CASE_SENSITIVE="true"

# Plugins
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
. /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh
source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/packages/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Functions
function reset() {
  if [ -n "$1" ]; then
    cd ..
    rm -rf "$1"
    mkdir "$1"
    cd "$1"
  else
    echo "Folder name required"
  fi
}
function update() {
  # Update & Upgrade
  sudo apt update
  sudo apt -y upgrade
  brew update
  brew upgrade
  npm -g update

  # Cleanup
  sudo apt autoremove
  sudo apt autoclean
  brew autoremove
  brew cleanup
}

# Aliases
## Packages
alias newrepo="~/packages/newrepo/src/main.sh"

## Shortcuts
alias ga="git add ."
alias gcm="git commit -v -m"
alias gp="git push origin main test"
alias bat="batcat"
alias del="trash-put"
alias empty="trash-empty -f"
alias release="standard-version"

## Paths
### Files
alias zshrc="micro ~/.zshrc"
alias npmrc="micro ~/.npmrc"
alias gitconfig="micro ~/.gitconfig"

### Folders
alias packages="cd ~/packages"
alias projects="cd ~/projects"
alias tests="cd ~/tests"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias dotfiles="cd ~/.dotfiles && code ~/.dotfiles"
