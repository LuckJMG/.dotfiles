#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Post oh-my-zsh
## Start at home directory
cd ~ || exit

## Set Dracula Theme
ln -s "$LIB_PATH"/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme

## Install packages
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

## Cleanup
rm -rf ~/.zshrc
if [ "$PWD" = "/root" ]; then
  apt autoremove
  apt autoclean
else
  sudo apt autoremove
  sudo apt autoclean
fi

## Configure zsh
ln -s "$LIB_PATH"/.zshrc ~/.zshrc
zsh
