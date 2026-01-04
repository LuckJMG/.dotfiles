# .dotfiles

Personal development environment configuration for Linux.

## Tools
- **[Homebrew](https://brew.sh):** Cross-platform package manager for user packages.
- **[Neovim](https://neovim.io/):** Modern modal editor with [my config](https://github.com/LuckJMG/Neovim-Config).
- **[WezTerm](https://wezterm.org/):** Powerful cross-platform terminal emulator.
- **[everforest](https://everforest.vercel.app/):** Consistent cross-app theme with night light compatibility.
- **[zsh](https://www.zsh.org/):** Modern interactive shell.

### Zsh Plugins
- [Oh My Posh](https://ohmypo.sh/): For zen prompt styling, with theme inspired by [powerlevel10k](https://github.com/romkatv/powerlevel10k).
- [fzf-tab](https://github.com/Aloxaf/fzf-tab): Completion with fzf integrated.
- [fzf](https://github.com/junegunn/fzf): General purpose CLI fuzzy finder.
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): History-based suggestions.
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): Real-time highlighting.
- [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode): A better vi-mode for zsh.

### CLI
- [eza](https://github.com/eza-community/eza): Modern, maintained replacement for ls.
- [lazygit](https://github.com/jesseduffield/lazygit): Simple terminal UI for git commands.
- [ripgrep](https://github.com/BurntSushi/ripgrep): Search tool like grep and The Silver Searcher.
- [stow](https://www.gnu.org/software/stow/): Organize software neatly under a single directory tree.
- [tealdeer](https://github.com/tealdeer-rs/tealdeer): Very fast implementation of tldr in Rust.

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
- `.config/nvim/`, [my config](https://github.com/LuckJMG/Neovim-Config) of nvim.
- `.config/ohmyposh/`, prompt configuration.
- `.gitconfig`, git configuration.
- `.zshrc`, zsh configuration.
- `Brewfile`, Brewfile for managing user packages.
- `lib/`, various scripts.

**Note:** This is my personal setup. Feel free to fork and adapt it to your needs.
