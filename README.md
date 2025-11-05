# .dotfiles

Personal development environment configuration for Linux with automated installation.

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

### Prerequisites
- git
- curl
- sudo access

### Quick Install
```bash
# Clone repository
git clone https://github.com/LuckJMG/.dotfiles.git ~/.dotfiles

# Run installer
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

### Post-Installation

**1. Restart terminal**
```bash
exec zsh
```

**2. Install Tmux plugins**
```bash
# Open tmux and press: Ctrl+Space + I
tmux
# Then: Ctrl+Space followed by Shift+I
```

**3. Configure Git** (if not using my credentials)
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## SSH Setup for GitHub

<details>
<summary>Click to expand SSH guide</summary>

### Generate SSH key
```bash
# Check for existing keys
ls -al ~/.ssh

# Generate new key (replace with your email)
ssh-keygen -t ed25519 -C "your@email.com"

# Start ssh-agent
eval "$(ssh-agent -s)"

# Add key
ssh-add ~/.ssh/id_ed25519

# Copy public key
cat ~/.ssh/id_ed25519.pub
```

### Add to GitHub

1. Go to GitHub → Settings → SSH and GPG keys
2. Click "New SSH key"
3. Paste the contents of `id_ed25519.pub`
4. Save

### Verify connection
```bash
ssh -T git@github.com
# Type "yes" when prompted
```

[Complete GitHub SSH documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

</details>

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
