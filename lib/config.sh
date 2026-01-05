#!/usr/bin/env bash

config() {
	local configPath

	case $1 in
	"zsh") configPath="$HOME/.zshrc" ;;
	"nvim" | "vim") configPath="$HOME/.config/nvim" ;;
	"ohmyposh" | "omp") configPath="$HOME/.config/ohmyposh" ;;
	*) configPath="$HOME/.dotfiles" ;;
	esac

	"${EDITOR:-vi}" "$configPath"
}
