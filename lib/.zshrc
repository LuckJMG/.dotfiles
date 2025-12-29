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

# Keymaps
bindkey -v
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Aliases
alias c="clear"
alias ls="eza --all --classify --group-directories-first --sort=extension"
alias lsa="ls --long --icons --header --no-permissions --no-user"
alias tree="eza --tree --icons --level=3 --git-ignore"
alias vim=nvim

# Initialize Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Plugins
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

## Completion
source "$HOME/Packages/fzf-tab/fzf-tab.plugin.zsh"
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

	autoload -Uz compinit
	compinit
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

## Zoxide
eval "$(zoxide init --cmd cd zsh)"

## Fuzzy Finder
source <(fzf --zsh)

