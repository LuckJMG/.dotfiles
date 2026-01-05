#!/usr/bin/env bash

config() {
	local configPath
	local originalPath=$PWD

	case $1 in
	"zsh") configPath="$HOME/.zshrc" ;;
	"nvim" | "vim") configPath="$HOME/.config/nvim" ;;
	"ohmyposh" | "omp") configPath="$HOME/.config/ohmyposh" ;;
	*) configPath="$HOME/.dotfiles" ;;
	esac

	cd "$configPath" || exit
	"${EDITOR:-vi}" "$configPath"
	cd "$originalPath" || exit
}
