#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Home
cd ~ || exit

## Files and folders
rm -rf .Brewfile .zshrc .npmrc .gitconfig .gitignore_global .bashrc .profile
ln -s "$LIB_PATH"/.gitconfig ~/.gitconfig
ln -s "$LIB_PATH"/.gitignore_global ~/.gitignore_global
ln -s "$LIB_PATH"/.npmrc ~/.npmrc
ln -s "$LIB_PATH"/.Brewfile ~/.Brewfile
mkdir packages projects tests

## Update system
sudo apt update
sudo apt upgrade
sudo apt install -y curl micro bat git zsh build-essential

# Git
## Packages
git clone https://github.com/dracula/zsh.git ~/packages/zsh-dracula
git clone https://github.com/dracula/zsh-syntax-highlighting.git ~/packages/zsh-syntax-dracula
git clone https://github.com/dracula/micro.git ~/packages/micro-dracula
git clone https://github.com/LuckJMG/newrepo.git ~/packages/newrepo


# Node
## Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

## Install and configure node
nvm install node
npm install --global standard-version husky @commitlint/{config-conventional,cli} npm
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js


# Homebrew
## Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "eval '$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)'" >> ~/.zprofile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

## Install packages
brew bundle --global

## Configure packages
mkdir ~/.config/micro/colorschemes
mv ~/packages/micro-dracula/dracula.micro ~/.config/micro/colorschemes/dracula.micro
printf "{\n    \"colorscheme\": \"dracula\"\n}" >> settings.json


# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#* execute install2.sh
