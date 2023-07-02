#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Post oh-my-zsh
## Start at home directory
cd ~ || exit

## Set Dracula Theme
ln -s "$LIB_PATH"/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme

## Cleanup
rm -rf ~/.zshrc
if [ "$PWD" = "/root" ]; then
  apt autoremove
  apt autoclean
else
  sudo apt autoremove
  sudo apt autoclean
fi
brew cleanup
brew autoremove

## Configure zsh
ln -s "$LIB_PATH"/.zshrc ~/.zshrc
zsh
