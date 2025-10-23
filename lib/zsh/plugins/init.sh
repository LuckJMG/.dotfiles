PLUGINS=$DOTFILES/plugins

source $PLUGINS/bat.sh
source $PLUGINS/eza.sh
source $PLUGINS/gsync.sh

eval "$(zoxide init zsh --cmd cd)"
alias grep=rg

