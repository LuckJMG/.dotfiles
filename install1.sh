#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Home
cd ~ || exit

## Files and folders
rm -rf .Brewfile .zshrc .npmrc .gitconfig .gitignore_global .bashrc .profile .zprofile
ln -s "$LIB_PATH"/.gitconfig ~/.gitconfig
ln -s "$LIB_PATH"/.gitignore_global ~/.gitignore_global
ln -s "$LIB_PATH"/.npmrc ~/.npmrc
ln -s "$LIB_PATH"/.Brewfile ~/.Brewfile
mkdir packages projects

## Update system
if [ "$PWD" = "/root" ]; then
  apt update
  apt upgrade -y
  apt install -y curl git zsh build-essential
else
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y curl git zsh build-essential
fi


# Git
## Packages
git clone https://github.com/dracula/zsh.git ~/packages/dracula-zsh
git clone https://github.com/dracula/zsh-syntax-highlighting.git ~/packages/dracula-zsh-syntax-highlighting

# Homebrew
## Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

## Install packages
brew bundle --global

# Node
npm install --global npm

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#* execute install2.sh
