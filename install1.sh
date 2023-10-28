#!/usr/bin/env bash

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
LIB_PATH="$BASE_DIR/lib"

# Home
cd ~ || exit

## Files and folders
mv .zshrc .pre-dotfiles-zshrc
mv .gitconfig .pre-dotfiles-gitconfig
ln -s "$LIB_PATH"/.gitconfig ~/.gitconfig
mkdir Projects Packages 

# Packages
sudo dnf install ripgrep nodejs util-linux-user  # Dependencies
sudo dnf install neovim zoxide exa bat zsh tmux

git clone https://github.com/LuckJMG/Neovim-Config.git ~/.config/nvim
git clone https://github.com/dracula/zsh.git ~/Packages/dracula-zsh
git clone https://github.com/dracula/zsh-syntax-highlighting.git ~/Packages/dracula-zsh-syntax-highlighting

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#* execute install2.sh
