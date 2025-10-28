PLUGINS=$DOTFILES/plugins

source $PLUGINS/bat.sh
source $PLUGINS/eza.sh

eval "$(zoxide init zsh --cmd cd)"
alias grep=rg
alias gsync="$SCRIPTS/gsync/gsync.sh"

