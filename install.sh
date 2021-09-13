#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Home
## Start at home
cd ~ || exit

## Create folders
mkdir apps packages tests

# Homebrew
## Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Install packages
"$LIB_PATH"/Brewfile
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Configure brew packages
chsh -s /bin/zsh  # Set zsh as default shell

# Dotfiles
## Delete original files
rm -rf .zshrc .npmrc .gitconfig .gitignore_global

## Create symbolic links
ln -s "$LIB_PATH"/.zshrc ~/.zshrc
ln -s "$LIB_PATH"/.npmrc ~/.npmrc
ln -s "$LIB_PATH"/.gitconfig ~/.gitconfig
ln -s "$LIB_PATH"/.gitignore_global ~/.gitignore_global

# Node
## Install node lts version
nvm install --lts
nvm use node

## Install node packages
npm install --global standard-version husky @commitlint/{config-conventional,cli}

## Configure node packages
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js

# Git
## Clone git packages
cd apps || exit
git clone https://github.com/dracula/zsh.git
mv ./zsh ./zsh-dracula
git clone https://github.com/dracula/zsh-syntax-highlighting.git
mv ./zsh-syntax-highlighting ./zsh-highlighting-dracula
git clone https://github.com/LuckJMG/newrepo.git

## Config packages
mv ./zsh-dracula/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
ln -s ~/.oh-my-zsh/themes/dracula.zsh-theme ./zsh-dracula/dracula.zsh-theme
