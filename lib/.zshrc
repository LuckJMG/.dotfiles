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
export BAT_THEME="Dracula"
export EXA_COLORS="uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36:"

# Options
ZSH_THEME="dracula"
CASE_SENSITIVE="true"

# Plugins
plugins=(
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source "$HOME/.cargo/env"
source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/packages/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh
eval "$(zoxide init zsh)"

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
alias ls="exa --classify --oneline --group-directories-first"
alias ll="exa --header --all --classify --long --group-directories-first --no-user"
alias cat="batcat"
alias cd="z"
alias zz="z -"
alias aptls='apt list --installed | grep "\[installed\]"'
alias venv="source ./.venv/bin/activate"
