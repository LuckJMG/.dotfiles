# System
alias zsource="source $HOME/.zshrc"
alias vim=nvim

# Editor
function zvim {
	if [[ -z $1 ]]; then
		nvim
		return
	fi

	z_error=$(zoxide "$1" 2>&1)
	if [[ $z_error == "zoxide: no match found" ]]; then
		nvim "$1"
		return
	fi

	cd "$1" || return
	nvim .
}

