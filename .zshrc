DOTFILES="$HOME/.dotfiles"
LIB="$DOTFILES/lib"

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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


# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Plugins
source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
antidote load "$HOME/.dotfiles/.zsh_plugins.txt"

# CLI Tools
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
source <(fzf --zsh)

# Completion
zstyle ':plugin:ez-compinit' 'compstyle' 'ohmy'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

# Scripts (last for priority in execution)
source "$LIB/config.sh"
source "$LIB/wezterm.sh"
source "$LIB/vim-mode.zsh"
