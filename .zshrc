DOTFILES="$HOME/.dotfiles"
LIB="$DOTFILES/lib"

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory sharehistory hist_ignore_space
setopt hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Editor
export EDITOR=nvim
export VISUAL=$EDITOR
export MANPAGER="nvim +Man!"

# Aliases
alias c="clear"
alias ls="eza --all --classify --group-directories-first --sort=extension"
alias lsa="ls --long --icons --header --no-permissions --no-user"
alias tree="eza --tree --icons --level=3 --git-ignore"
alias update="sudo apt update && sudo apt upgrade -y && brew upgrade && antidote update"
alias vim=nvim
alias z="source $HOME/.zshrc"


