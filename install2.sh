#!/usr/bin/env bash

LIB_PATH="$(dirname "$0")/lib"

# Execute at home
cd ~ || exit

# Set Dracula Theme
mv ~/packages/zsh-dracula/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
mv ~/packages/zsh-dracula/lib ~/.oh-my-zsh/themes/lib
ln -s ~/.oh-my-zsh/themes/dracula.zsh-theme ~/packages/zsh-dracula/dracula.zsh-theme

# Restart zsh
rm -rf ~/.zshrc
ln -s "$LIB_PATH"/.zshrc ~/.zshrc
zsh
