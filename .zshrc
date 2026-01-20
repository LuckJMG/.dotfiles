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

# vi-mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]]; then
		print -Pn -- "\e[2 q"
	else
		print -Pn -- "\e[6 q"
	fi
}
zle -N zle-keymap-select

zle-line-init() { zle-keymap-select; }
zle -N zle-line-init

bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Integration
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
	function wezterm_osc7() { print -Pn "\e]7;file://%m$PWD\e\\" }
	function wezterm_semantic_precmd() { print -Pn "\e]133;A\e\\"; wezterm_osc7 }
	function wezterm_semantic_preexec() { print -Pn "\e]133;C\e\\" }
	autoload -Uz add-zsh-hook
	add-zsh-hook precmd wezterm_semantic_precmd
	add-zsh-hook preexec wezterm_semantic_preexec
fi

setopt no_beep

# Plugins
source ~/.config/zsh/znap/znap.zsh

znap prompt sindresorhus/pure
znap source zsh-users/zsh-autosuggestions
znap eval zoxide "zoxide init --cmd cd zsh"
source "$LIB/config.sh"

znap eval fzf "fzf --zsh"
znap source Aloxaf/fzf-tab
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Aliases
alias c="clear"
alias ls="eza --all --classify --group-directories-first --sort=extension"
alias lsa="ls --long --icons --header --no-permissions --no-user"
alias tree="eza --tree --icons --level=3 --git-ignore"
alias update="sudo apt update && sudo apt upgrade -y && brew upgrade && znap pull"
alias vim=nvim
alias z="source $HOME/.zshrc"

znap source zdharma-continuum/fast-syntax-highlighting

