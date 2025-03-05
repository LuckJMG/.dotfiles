#!/usr/bin/env zsh

# System
alias reset="source $HOME/.zshrc"

# Editor
function vim {
	if [[ -z $1 ]]; then
		nvim
		return
	fi

	z_error=$(z "$1" 2>&1)
	if [[ $z_error == "zoxide: no match found" ]]; then
		nvim "$1"
		return
	fi

	z "$1"
	nvim .
}

