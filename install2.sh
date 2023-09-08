#!/usr/bin/env bash

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
LIB_PATH="$BASE_DIR/lib"

# Post oh-my-zsh
## Start at home directory
cd ~ || exit

## Set Dracula Theme
ln -s ~/Packages/dracula-zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme 

## Install packages
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

## Configure zsh
ln -s "$LIB_PATH"/.zshrc ~/.zshrc
zsh
