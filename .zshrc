setopt no_beep

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory sharehistory hist_ignore_space
setopt hist_ignore_all_dups hist_find_no_dups

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

zle -N zle-line-init zle-keymap-select

bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Plugins
[[ -r ~/.config/zsh/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.config/zsh/znap
source ~/.config/zsh/znap/znap.zsh

znap prompt sindresorhus/pure
znap source zsh-users/zsh-autosuggestions
eval "$(zoxide init --cmd cd zsh)"

znap eval fzf "fzf --zsh"
znap source Aloxaf/fzf-tab
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Aliases
alias ls="eza --all --classify --group-directories-first --sort=extension"
alias lsa="ls --long --icons --header --no-permissions --no-user"
alias tree="eza --tree --icons --level=3 --git-ignore"
alias vim=nvim
alias cloud-sync="rclone bisync gdrive:/ ~/Cloud --drive-skip-shortcuts --drive-acknowledge-abuse --verbose"
alias jupyter="uv run --with jupyter jupyter lab"
mkcd() {
	mkdir -p "$1" && cd "$1" || return
}

znap source zdharma-continuum/fast-syntax-highlighting

# Exports
export PATH="$HOME/Apps/Odin:$PATH"

# opencode
export PATH=/home/luck/.opencode/bin:$PATH
