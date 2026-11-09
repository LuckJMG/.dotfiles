# .dotfiles

Personal development environment configuration for Linux.

## Requirements
- [curl](https://curl.se/)
- [git](https://git-scm.com/)
- [zsh](https://www.zsh.org/)

## Tools
- **[Ghostty](https://ghostty.org/):** Fast, native, feature-rich terminal emulator. Main terminal on Linux.
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
- [ripgrep](https://github.com/BurntSushi/ripgrep): Search tool like grep and The Silver Searcher.
- [stow](https://www.gnu.org/software/stow/): Organize software neatly under a single directory tree.
- [tealdeer](https://github.com/tealdeer-rs/tealdeer): Very fast implementation of tldr in Rust.
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command.

## Agent Skills

Skills live in `agents/skills/`. Run `link-agents` to link them into Claude and Antigravity.

- `audit`: Scan code for one kind of problem, report, then apply the approved findings.
- `data-storytelling`: Rules to communicate with data, based on "Storytelling with Data".
- `document-writing`: Writing rules for finished documents such as reports, essays, and theses.
- `git-commit`: Commit with conventional commit messages and intelligent staging.
- `just`: Reference for the `just` command runner.
- `orthodox-cpp`: Write and review code in Orthodox C++, a minimal subset of C++.
- `ponytail`: Force the laziest solution that works: simplest, shortest, most minimal.
- `project-docs`: Write project docs from [The Good Docs Project](https://gitlab.com/tgdp/templates) templates (git submodule).
- `simple-english`: Write technical text with the ASD-STE100 Simplified Technical English rules.

## Installation

Clone this repo on `$HOME/.dotfiles` and [nvim config](https://github.com/LuckJMG/Neovim-Config).

```
git clone https://github.com/LuckJMG/.dotfiles.git $HOME/.dotfiles
git clone https://github.com/LuckJMG/Neovim-Config.git $HOME/.config/nvim
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
- `agents/`, shared agent config (`AGENTS.md`, `skills/`, `commands/`) for Claude and Antigravity. Not stowed. Run `link-agents` (alias for `lib/link-agents.sh`) to link it.
- `.gitconfig`, git configuration.
- `.zshrc`, zsh configuration.
- `lib/power-mode-manager/`, systemd service that auto-switches Ubuntu power profiles by charging state and battery level.

**Note:** This is my personal setup. Feel free to fork and adapt it to your needs.
