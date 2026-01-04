# .dotfiles

Personal development environment configuration for Linux.

## Features

### Core Tools
- **[Neovim](https://neovim.io/)** - Modern modal editor ([my config](https://github.com/LuckJMG/Neovim-Config))
- **[tmux](https://github.com/tmux/tmux)** - Terminal multiplexer with vim bindings
- **[zsh](https://www.zsh.org/)** + **[Oh My Zsh](https://ohmyz.sh/)** - Advanced shell
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smart directory navigation
- **[eza](https://github.com/eza-community/eza)** - Modern `ls` with icons (exa fork)
- **[bat](https://github.com/sharkdp/bat)** - `cat` with syntax highlighting
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - `grep` with steroids

### Zsh Plugins
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - History-based suggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Real-time highlighting

### Theme
- **[Dracula](https://draculatheme.com/)** - Consistent theme across all tools

## Installation
First you need to update and upgrade your system with its package manager, we'll use `Ubuntu` with `apt` as an example.

```sh
sudo apt update && sudo apt upgrade -y
```

For the base packages install `curl`, `git` and `zsh`.

```sh
sudo apt install curl git zsh
```

Clone this repo on `$HOME/.dotfiles`.

```
git clone https://github.com/LuckJMG/.dotfiles.git $HOME/.dotfiles
```

After that install [Homebrew](https://brew.sh/) to manage user packages, and `eval` it to use it.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

> Use Homebrew to manage only user packages, any low-level or system packages should be installed with the package manager of your distro.

Install the user packages from the `Brewfile`.

```sh
brew bundle --file="$HOME/.dotfiles/Brewfile"
```

Backup any configuration file that already exists (`.zshrc`, `.config/nvim` and `.config/ohmyposh`), then `cd` to the repository and `stow` the dotfiles to access the configuration.

```sh
cd $HOME/.dotfiles
stow .
```

Finally set `zsh` as your default shell and replace the current instance with it.

```sh
chsh -s "$(which zsh)"
exec zsh
```

## Project Structure

```
.dotfiles/
├── lib/
│   ├── zsh/
│   │   ├── aliases.sh
│   │   ├── settings.sh
│   │   ├── oh-my-zsh.sh
│   │   ├── filetype/       # language specific files
│   │   └── plugins/        # personal plugins
│   ├── .zshrc
│   ├── .gitconfig
│   └── .tmux.conf
├── install.sh
└── README.md
```

## Key Bindings

### Tmux
| Binding | Action |
|---------|--------|
| `Ctrl+Space` | Prefix |
| `Prefix + \|` | Vertical split |
| `Prefix + -` | Horizontal split |
| `Alt+H/L` | Previous/next window |

### Zsh
| Command | Description |
|---------|-------------|
| `cd <dir>` | Jump to directory (zoxide) |
| `ls` | Detailed listing with eza |
| `tree` | Tree view (3 levels) |
| `vim` | Open Neovim |
| `zvim <dir>` | Open Neovim in directory with zoxide |

## Uninstall
```bash
# Remove configurations
rm ~/.zshrc ~/.gitconfig ~/.tmux.conf
rm -rf ~/.oh-my-zsh ~/.tmux/plugins

# Restore from backup (adjust date)
cp -r ~/.dotfiles-backup-YYYYMMDD-HHMMSS/* ~/

# Change shell back to bash
chsh -s $(which bash)
```

---

**Note:** This is my personal setup. Feel free to fork and adapt it to your needs.
