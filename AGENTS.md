# AGENTS.md

Personal GNU stow dotfiles. No build, test, or lint. Verify with a stow dry-run:

```sh
stow --no -n -v .
```

## Architecture

- `agents/AGENTS.md` is the global instruction file of every agent on this machine.
  `lib/link-agents.sh` links it to `~/.claude/CLAUDE.md` and `~/.gemini/`. An edit
  there changes the behavior of all projects, not only this repo.
- `agents/` is not stowed. After you add a skill or a command, run `link-agents`.
  Commands link only into Claude. Skills link into Claude and Antigravity.
- Neovim config is a separate repo (`github.com/LuckJMG/Neovim-Config`) cloned to
  `~/.config/nvim`. It is not in this repo.

## Traps

- `agents/skills/project-docs/templates` is a submodule (Good Docs Project). Do not
  edit. On a fresh clone, run `git submodule update --init --recursive`.
- `lib/` is not stowed. Its scripts run through aliases in `.zshrc`.
- `lib/nvidia-kmod-check` targets Fedora and hardcodes `xorg-x11-drv-nvidia-580xx`.
- Before a commit, make sure that no secret lands in a tracked file. A service
  password was committed once (`03e6a4f`).
