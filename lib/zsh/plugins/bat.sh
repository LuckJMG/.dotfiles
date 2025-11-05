# Settings
export BAT_THEME="Dracula"
export BAT_PAGER="less -R"
export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p --paging=always'"
export MANROFFOPT="-c" 

# Aliases
function cat {
    if [ -t 1 ]; then
        bat --plain "$@"
    else
        command cat "$@"
    fi
}

