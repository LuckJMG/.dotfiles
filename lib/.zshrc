#!/usr/bin/env bash

# Start
if [ "$PWD" = "/mnt/c/Users/Luck" ]; then
    cd ~ || exit
fi

# Export paths
export LANG=en_US.UTF-8
export EDITOR="code"
export NVM_DIR="$HOME/.nvm"

# Options
ZSH_THEME="dracula"
CASE_SENSITIVE="true"

# Packages config
## nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# Plugins
plugins=(git)
. /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh
source ~/.oh-my-zsh/oh-my-zsh.sh
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/packages/zsh-syntax-dracula/zsh-syntax-highlighting.sh
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
  sudo apt update
  sudo apt -y upgrade
  sudo apt autoclean
  brew update
  brew upgrade
  brew cleanup
  nvm deactivate
  nvm uninstall node
  nvm install node
  npm install --global standard-version husky @commitlint/{config-conventional,cli} npm
}

# Aliases
## Packages
alias bat="batcat"
alias release="standard-version"
alias newrepo="~/packages/newrepo/src/main.sh"

## Shortcuts
alias del="rm -rf"

## Paths
### Files
alias zshrc="code ~/.zshrc"
alias npmrc="code ~/.npmrc"
alias gitconfig="code ~/.gitconfig"

### Folders
alias apps="cd ~/apps"
alias projects="cd ~/projects"
alias tests="cd ~/tests"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias dotfiles="cd ~/.dotfiles && code ~/.dotfiles"
