# Settings
export BAT_THEME="Dracula"
export BAT_PAGER=""
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Aliases
function cat {
    if [ -t 1 ]; then
        bat --plain "$@"
    else
        command cat "$@"
    fi
}

