# .dotfiles

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
![GitHub](https://img.shields.io/github/license/LuckJMG/.dotfiles)

Personal workspace backup for windows wsl2 (ubuntu 20.04).

This repository is for backup my personal workspace that includes configuration dotfiles and apps for windows wsl2, apart from that, there are other apps that are installed in windows. The programs that I use are:

- [Visual Studio Code](https://code.visualstudio.com/) with [wsl2](https://docs.microsoft.com/en-us/windows/wsl/about) ([ubuntu 20.04](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6#activetab=pivot:overviewtab)) as text editor.
- [Zsh](https://zsh.sourceforge.io/) with [oh-my-zsh](https://ohmyz.sh/) as shell ([z](https://github.com/rupa/z), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)).
- [Windows Terminal](https://www.microsoft.com/en-US/p/windows-terminal) as terminal.
- [Git](https://git-scm.com/) as version manager.
- [Docker](https://www.docker.com/) for encapsulation and testing.
- [Nvm](https://github.com/nvm-sh/nvm) for node management.
- [Node](https://nodejs.org/en/) for project dependencies ([standard-version](https://github.com/conventional-changelog/standard-version), [husky](https://github.com/typicode/husky) and [commitlint](https://commitlint.js.org/#/)).
- [Homebrew](https://brew.sh/) for package management ([curl](https://curl.se/) and [nano](https://www.nano-editor.org/)).
- [Dracula Theme](https://draculatheme.com/) as main theme of all the workspace.
- [Fira Code](https://github.com/tonsky/FiraCode) as main font of all the workspace.

## Table of Contents

- [.dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Background](#background)
  - [Install](#install)
    - [Connect to GitHub](#connect-to-github)
  - [Thanks](#thanks)

## Background

The idea of this repository came to me when I saw a video of fireship called [~/.dotfiles in 100 seconds](https://www.youtube.com/watch?v=r_MpUP6aKiQ), then I started this project. First it was the dotfiles and the standard files that I normally use in a project but then I separated them in 2 projects, this and [newrepo](https://github.com/LuckJMG/newrepo).

## Install

To install and configure your new workspace first you need to clone this repo in your home directory `~`:

``` bash
git clone https://github.com/LuckJMG/.dotfiles.git
```

Then execute `install1.sh` to install the first part of the workspace:

``` bash
~/.dotfiles/install1.sh
# When brew ask you to press enter, press enter
# When oh-my-zsh ask you to set zsh as the default shell, accept
```

After the execution of `install1.sh`, execute `install2.sh`:

``` bash
~/.dotfiles/install2.sh
```

And you are ready to use my workspace.

### Connect to GitHub

After installing and configuring the workspace, we need to connect our workspace with GitHub trough a SSH key:

``` bash
# First check if there are any existing SSH keys
ls -al ~/.ssh

# If there aren't any available keys create a new one
ssh-keygen -t ed25519 -C "25126199+LuckJMG@users.noreply.github.com" # Replace with your email
# Press enter and when it ask for a passphrase press enter again

# Start the ssh-agent
eval "$(ssh-agent -s)"

# Create the SSH key
ssh-add ~/.ssh/id_ed25519

# Finally copy the content of the SSH file
cat ~/.ssh/id_ed25519.pub
```

Then in your GitHub account go to settings, SSH and GCP keys, create a new SSH key, give the name of your workspace and paste the content of the SSH file.
Finally you need to authorize github.com to connect to your workspace:

``` bash
ssh -T git@github.com
# After that type the passphrase of the SSH key and
# Finally write "yes"
```

For more information go to the [github SSH documentation](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh).

## Thanks

I really appreciate that you have come this far, thank you very much, for me, a 18 years old student, that someone viewed his project is a very large achievement, and I hope that my code can be useful to you.
