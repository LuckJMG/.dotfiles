#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Post oh-my-zsh
## Start at home directory
cd ~ || exit

## Set Dracula Theme
ln -s ~/packages/dracula-zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme

## Cleanup
rm -rf ~/.zshrc
sudo apt autoclean
sudo apt autoremove
brew cleanup
brew autoremove

## Configure zsh
ln -s "$LIB_PATH"/.zshrc ~/.zshrc
zsh
