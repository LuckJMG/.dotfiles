# .dotfiles

Personal workspace backup for linux (fedora) and quick setup.

## Contents

- [Neovim](https://neovim.io/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [exa](https://github.com/ogham/exa)
- [bat](https://github.com/sharkdp/bat)
- [zsh](https://www.zsh.org/) (with [oh-my-zsh](https://ohmyz.sh/), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting))
- [My Neovim Config](https://github.com/LuckJMG/Neovim-Config)
- [Dracula Theme](https://draculatheme.com/)

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
