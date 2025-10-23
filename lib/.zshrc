if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export DOTFILES="$HOME/.dotfiles/lib/zsh"

source "$DOTFILES/oh-my-zsh.sh"
source "$DOTFILES/settings.sh"
source "$DOTFILES/aliases.sh"
source "$DOTFILES/plugins/init.sh"
source "$DOTFILES/filetype/init.sh"

if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    tmux attach || tmux new
fi

