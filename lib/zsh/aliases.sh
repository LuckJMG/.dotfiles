# System
alias reset="source $HOME/.zshrc"

# Editor
function vim {
    if z "$1" 2>/dev/null; then
        nvim .
    else
        nvim "$1"
    fi
}


