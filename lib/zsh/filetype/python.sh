#!/usr/bin/zsh

source $HOME/.local/bin

function venv() {
	if [ -f ./.venv/bin/activate ]; then
		source ./.venv/bin/activate
	else
		echo "venv: ./.venv/bin/activate does not exists"
	fi
}

