#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Home
cd ~ || exit

## Files and folders
mv .zshrc .pre-dotfiles-zshrc
mv .gitconfig .pre-dotfiles-gitconfig
ln -s "$LIB_PATH"/.gitconfig ~/.gitconfig
mkdir Projects Packages 

# Packages
sudo dnf install neovim zoxide exa bat zsh
git clone https://github.com/LuckJMG/Neovim-Config.git ~/.config/nvim
git clone https://github.com/dracula/zsh.git ~/packages/dracula-zsh
git clone https://github.com/dracula/zsh-syntax-highlighting.git ~/packages/dracula-zsh-syntax-highlighting

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#* execute install2.sh
