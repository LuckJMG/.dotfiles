bindkey -v  # Set vi-mode
export KEYTIMEOUT=1  # Don't wait too long

# Navigate history with k and j
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Set cursor based on mode
zle-keymap-select() {
	if [[ ${KEYMAP} == vicmd ]]; then
		echo -ne "\e[2 q"
	else
		echo -ne "\e[6 q"
	fi
}
zle -N zle-keymap-select

# Init cursor in insert mode
zle-line-init() {
	zle -K viins
	echo -ne "\e[6 q"
}
zle -N zle-line-init
