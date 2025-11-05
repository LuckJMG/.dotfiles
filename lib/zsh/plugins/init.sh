PLUGINS=$DOTFILES/plugins

source "$PLUGINS/bat.sh"
source "$PLUGINS/eza.sh"

eval "$(zoxide init zsh --cmd cd)"
alias gsync="$SCRIPTS/gsync/gsync.sh"

function grep {
    if [ -t 1 ]; then
        rg --smart-case "$@"
    else
        command grep "$@"
    fi
}
alias grep=grep

