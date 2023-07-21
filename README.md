# .dotfiles

![GitHub](https://img.shields.io/github/license/LuckJMG/.dotfiles)

Personal workspace backup for windows wsl2 (ubuntu 20.04).

This repository is for backup my personal workspace that includes configuration dotfiles and [apps](#linux) for windows wsl2, apart from that, there are other apps from windows that I use in my workspace, which I will include in the [Specifications](#windows) section.

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
