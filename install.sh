#!/usr/bin/env bash
set -euo pipefail # Exit on error, undefined vars, pipe failures

BACKUP_DIR="$HOME/pre-dotfiles-backup"
DOTFILES_DIR="$HOME/.dotfiles"

echo "Updating system"
sudo apt update && sudo apt upgrade -y

echo "Installing curl and zsh"
sudo apt install curl zsh

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "Installing packages"
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "Generating backup"
mkdir "$BACKUP_DIR"
mkdir "$BACKUP_DIR/.config"
if [ -f "$HOME/.zshrc" ]; then
	echo "Making backup of .zshrc"
	mv "$HOME/.zshrc" "$BACKUP_DIR/.zshrc"
fi
if [ -d "$HOME/.config/nvim" ]; then
	echo "Making backup of .config/nvim"
	mv "$HOME/.config/nvim" "$BACKUP_DIR/.config/nvim"
fi
if [ -d "$HOME/.config/ohmyposh" ]; then
	echo "Making backup of .config/ohmyposh"
	mv "$HOME/.config/ohmyposh" "$BACKUP_DIR/.config/ohmyposh"
fi

echo "Generating symlinks"
cd "$DOTFILES_DIR"
stow . -t "$HOME"

echo "Changing default shell to zsh"
chsh -s "$(which zsh)"
exec zsh
