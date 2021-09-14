# .dotfiles

My workspace backup for windows wsl2.

This repository is for backup my workspace that includes dotfiles (`.zshrc`, `.npmrc`, `.gitconfig`, etc.) and apps (`zsh`, `git`, `node`, etc.) of windows wsl2, apart of that is necessary other apps pre-installed in windows that I will specify later.

## Table of Contents

- [.dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Background](#background)
  - [Install](#install)
    - [Connect to GitHub](#connect-to-github)
    - [Dependencies](#dependencies)
  - [Thanks](#thanks)

## Background

I am an student from Chile of 18 years at this moment, I started programming at the age of 12 and from that moment I fell in love with the programming. The idea of this repository came to me when I saw a video of fireship called [~/.dotfiles in 100 seconds](https://www.youtube.com/watch?v=r_MpUP6aKiQ), then I started this project. First it was the dotfiles and the standard files that I normally use in a project but then I separated them in 2 projects, this and [newrepo](https://github.com/LuckJMG/newrepo).

## Install

To install and configure your new workspace first you need to clone this repo in `~`:

``` bash
git clone https://github.com/LuckJMG/.dotfiles.git
```

Then execute `install.sh` to install and configure everything else:

``` bash
./.dotfiles/install.sh
```

### Connect to GitHub

After installing and configuring the workspace, we need to connect our workspace with GitHub trough a SSH key, there is a tutorial provided by GitHub, but the basic steps are these:

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

### Dependencies

Before installing the .dotfiles repo first you need to be in windows and install these things:

- [Fira Code Font](https://github.com/tonsky/FiraCode)
- [VS Code](https://code.visualstudio.com/) (with the [settings sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension)
- [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
- [wsl2](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## Thanks

I really appreciate that you have come this far, thank you very much, for me, a 17 years old student, that someone viewed his project is a very large achievement, and I hope that my code can be useful to you.
