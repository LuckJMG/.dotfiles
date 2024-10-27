#!/usr/bin/zsh

export DOTFILES=$HOME/.dotfiles/lib/zsh

source $DOTFILES/oh-my-zsh.sh
source $DOTFILES/plugins/init.sh
source $DOTFILES/filetype/init.sh
source $DOTFILES/aliases.sh
source $DOTFILES/settings.sh

# Avoid TMUX recursion
if [ "$TMUX" = "" ]; then tmux; fi

