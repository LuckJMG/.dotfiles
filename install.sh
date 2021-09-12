#! /bin/bash

LIB_PATH="$(dirname "$0")/lib"

# Start at home
cd ~ || exit

# Install brew and apps
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
"$LIB_PATH"/Brewfile
nvm install --lts
chsh -s /bin/zsh  # Set zsh as default shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Delete original files
rm -rf .zshrc .npmrc .gitconfig .gitignore_global

# Create symbolic links
ln -s "$LIB_PATH"/.zshrc ~/.zshrc
ln -s "$LIB_PATH"/.npmrc ~/.npmrc
ln -s "$LIB_PATH"/.gitconfig ~/.gitconfig
ln -s "$LIB_PATH"/.gitignore_global ~/.gitignore_global

# Create folders
mkdir apps projects tests

# Clone other apps from git
cd apps || exit
git clone https://github.com/dracula/zsh.git
mv ./zsh ./zsh-dracula
git clone https://github.com/dracula/zsh-syntax-highlighting.git
mv ./zsh-syntax-highlighting ./zsh-highlighting-dracula
git clone https://github.com/LuckJMG/newrepo.git

## Config apps
mv ./zsh-dracula/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
ln -s ~/.oh-my-zsh/themes/dracula.zsh-theme ./zsh-dracula/dracula.zsh-theme
