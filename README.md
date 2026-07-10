# .dotfiles

Personal development environment configuration for Linux.

## Requirements
- [curl](https://curl.se/)
- [git](https://git-scm.com/)
- [zsh](https://www.zsh.org/)

## Tools
- **[Ghostty](https://ghostty.org/):** Fast, native, feature-rich terminal emulator. Main terminal on Linux.
- **[WezTerm](https://wezterm.org/):** GPU-accelerated terminal. WSL fallback.
- **[Neovim](https://neovim.io/):** Modern modal editor with [my config](https://github.com/LuckJMG/Neovim-Config).
- **[znap](https://github.com/marlonrichert/zsh-snap):** A fast plugin manager for zsh.
- **[zsh](https://www.zsh.org/):** Modern interactive shell.

### Zsh Plugins
- [Pure](https://github.com/sindresorhus/pure): Minimal, fast zsh prompt.
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting): Syntax highlighting.
- [fzf-tab](https://github.com/Aloxaf/fzf-tab): Completion with fzf integrated.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): History-based suggestions.

### CLI
- [eza](https://github.com/eza-community/eza): Modern, maintained replacement for ls.
- [fzf](https://github.com/junegunn/fzf): General purpose CLI fuzzy finder.
- [lazygit](https://github.com/jesseduffield/lazygit): Simple terminal UI for git commands.
- [opencode](https://opencode.ai/): AI coding agent for the terminal. Drives all agent interactions.
- [ripgrep](https://github.com/BurntSushi/ripgrep): Search tool like grep and The Silver Searcher.
- [stow](https://www.gnu.org/software/stow/): Organize software neatly under a single directory tree.
- [tealdeer](https://github.com/tealdeer-rs/tealdeer): Very fast implementation of tldr in Rust.
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command.

## Installation

Clone this repo on `$HOME/.dotfiles`.

```
git clone https://github.com/LuckJMG/.dotfiles.git $HOME/.dotfiles
```

Backup any configuration file that already exists (`.zshrc` and `.config/nvim`), then `cd` to the repository and `stow` the dotfiles to access the configuration.

```sh
cd $HOME/.dotfiles
stow .
```

Don't forget to set `zsh` as your default shell and replace the current instance with it.

```sh
chsh -s "$(which zsh)"
exec zsh
```

## Project Structure
- `.config/ghostty/`, Ghostty terminal config (Nord theme, FiraCode Nerd Font).
- `.config/nvim/`, [my config](https://github.com/LuckJMG/Neovim-Config) of nvim.
- `.config/opencode/`, opencode config: agents, skills, commands, plugins.
- `.config/wezterm/`, WezTerm config (WSL fallback).
- `.gitconfig`, git configuration.
- `.zshrc`, zsh configuration.
- `lib/power-mode-manager/`, systemd service that auto-switches Ubuntu power profiles by charging state and battery level.
- `lib/gsync/`, systemd user services that run `rclone bisync` against Google Drive on login and shutdown.

**Note:** This is my personal setup. Feel free to fork and adapt it to your needs.
