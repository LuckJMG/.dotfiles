#!/usr/bin/env bash

cfg() {
	local RED="\e[0;31m"
	local YELLOW="\e[0;33m"
	local NC="\e[0m"

	local originalPath=$PWD
	local configPath
	local tool

	tool=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	case "$tool" in
	"zsh" | ".zshrc") configPath="$HOME/.zshrc" ;;
	"nvim" | "vim" | "neovim") configPath="$HOME/.config/nvim" ;;
	"ohmyposh" | "omp") configPath="$HOME/.config/ohmyposh" ;;
	"" | "dot" | "dotfiles" | ".dotfiles" | ".") configPath="$HOME/.dotfiles" ;;
	*)
		echo -e "${RED}[ERROR] Tool${NC} ${YELLOW}$1${NC} ${RED}not recognized${NC}"
		return
		;;
	esac

	cd "$configPath" || return
	"${EDITOR:-vi}" "$configPath"
	cd "$originalPath" || return
}
