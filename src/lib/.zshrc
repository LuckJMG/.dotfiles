#!/usr/bin/env bash

# Zsh configuration
## Export paths
export ZSH="/home/luck/.oh-my-zsh"
export ZSH_SYNTAX_HIGHLIGHTING="/home/luck/apps/zsh-syntax-highlighting"

## Options
ZSH_THEME="dracula"
CASE_SENSITIVE="true"

## Plugins
plugins=(
    git
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
source $ZSH_SYNTAX_HIGHLIGHTING/dracula-theme/zsh-syntax-highlighting.sh

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

### Shortcuts
alias del="rm -rf"

### Apps
alias newrepo="~/apps/newrepo/src/main.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
