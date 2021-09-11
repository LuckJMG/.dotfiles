#!/usr/bin/env bash

# Start
if [ "$PWD" = "/mnt/c/Users/Luck" ]; then
  cd ~ || exit
fi

# Zsh configuration
## Export paths
export ZSH="/home/luck/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"

## App config
### nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"

## Options
ZSH_THEME="dracula"
CASE_SENSITIVE="true"

## Plugins
plugins=(git)
. /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh
source $ZSH/oh-my-zsh.sh
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/apps/zsh-syntax-dracula/zsh-syntax-highlighting.sh
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration
## Options
export LANG=en_US.UTF-8
export EDITOR="code"

## Functions
### Shortcuts
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

## Aliases
### Paths
#### Files
alias zshrc="code ~/.zshrc"
alias npmrc="code ~/.npmrc"
alias gitconfig="code ~/.gitconfig"

#### Folders
alias apps="cd ~/apps"
alias projects="cd ~/projects"
alias tests="cd ~/tests"
alias ohmyzsh="code ~/.oh-my-zsh"
alias dotfiles="code ~/.dotfiles"

### Shortcuts
alias del="rm -rf"

### Apps
alias newrepo="~/apps/newrepo/src/main.sh"
