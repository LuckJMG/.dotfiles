#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Home
cd ~ || exit

## Files and folders
rm -rf .zshrc .gitconfig .gitignore_global
ln -s "$LIB_PATH"/.gitconfig ~/.gitconfig
ln -s "$LIB_PATH"/.gitignore_global ~/.gitignore_global
mkdir packages projects

## Update system
if [ "$PWD" = "/root" ]; then
  apt update
  apt upgrade -y
  apt install -y curl git zoxide exa batcat zsh
else
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y curl git zsh
fi

# Packages
git clone https://github.com/dracula/zsh.git ~/packages/dracula-zsh
git clone https://github.com/dracula/zsh-syntax-highlighting.git ~/packages/dracula-zsh-syntax-highlighting

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#* execute install2.sh
