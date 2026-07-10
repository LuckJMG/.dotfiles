# AGENTS.md

Personal GNU stow dotfiles repo. Not a buildable project — no test, lint,
typecheck, or build commands exist. Verification = read-through + stow dry-run.

## Layout

- Stow targets (symlink to `$HOME`): `.zshrc`, `.gitconfig`, `.config/nvim/`, `.config/wezterm/`
- Submodule: `.config/nvim` → `github.com:LuckJMG/Neovim-Config`. Edit upstream, not here.
- Manual install (NOT stowed — see `.stow-local-ignore` line `lib`):
  - `lib/power-mode-manager/` — Ubuntu systemd service, needs sudo
  - `lib/gsync/` — systemd user services, needs `rclone` remote `gdrive:`

## Setup on a fresh clone

```sh
git clone <repo> $HOME/.dotfiles
git submodule update --init --recursive   # nvim config
cd $HOME/.dotfiles
stow .                                    # symlinks into $HOME
```

Backup `.zshrc` and `.config/nvim` first if they exist — `stow` will clobber.

## Gotchas

- `lib/power-mode-manager/README.md` and `lib/gsync/README.md` reference path
  `lib/scripts/<name>/…` but the real path is `lib/<name>/…`. The README
  install commands are stale — use the actual path under `lib/`.
- `lib/` is excluded from stow (`.stow-local-ignore`). Don't `stow lib/...` —
  follow each lib's own README to copy/symlink manually.
- `.zshrc` hardcodes `/home/luck/.opencode/bin` and `$HOME/.bun`. User-specific;
  forks must edit before sourcing.
- `lib/power-mode-manager/power-mode-manager.sh` hardcodes battery `BAT1`. Verify
  with `ls /sys/class/power_supply/` on non-default hardware.
- Wezterm config sets `default_domain = "WSL:FedoraLinux-43"` (wezterm.lua:15) —
  WSL-specific; harmless on Linux but will silently no-op in panes.

## Verify

```sh
stow --no -n -v .   # dry-run, list what would be linked
```

No automated checks. Before commit, run `git diff --stat` and confirm no
secrets (private keys, tokens) land in tracked files.
