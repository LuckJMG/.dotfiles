#!/usr/bin/env bash

config() {
	local originalPath=$PWD
	local configPath
	local tool

	tool=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	case "$tool" in
	"zsh" | ".zshrc") configPath="$HOME/.zshrc" ;;
	"nvim" | "vim" | "neovim") configPath="$HOME/.config/nvim" ;;
	"ohmyposh" | "omp") configPath="$HOME/.config/ohmyposh" ;;
	*) configPath="$HOME/.dotfiles" ;;
	esac

	cd "$configPath" || exit
	"${EDITOR:-vi}" "$configPath"
	cd "$originalPath" || exit
}
