#!/usr/bin/env bash
# shellcheck source=/dev/null

# Export paths
export LANG=C.UTF-8
export LANGUAGE=C.UTF-8
export LC_ALL=C.UTF-8
export LC_CTYPE=C.UTF-8
export EDITOR="code"
export BAT_THEME="Dracula"
export EXA_COLORS="uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36:"
export ZSH_THEME="dracula"
export CASE_SENSITIVE="true"

# Plugins
export plugins=(
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/Packages/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh
source "$HOME/.cargo/env"
eval "$(zoxide init zsh)"

# Aliases
alias ls="exa  --icons --classify --group-directories-first"
alias ll="exa  --icons --header --classify --long --group-directories-first"
alias tree="exa --tree --icons --all"
alias cat="bat"
alias cd="z"

function vim {
    if [[ -z $1 ]]; then
        nvim
        return
    fi

    z_error=$(z "$1" 2>&1)
    if [[ $z_error == "zoxide: no match found" ]]; then
        nvim "$1"
        return
    fi

    z "$1"
    nvim .
}

function update {
    sudo dnf update
    sudo dnf autoremove
    sudo dnf clean all
}

set -o vi
