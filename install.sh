#!/usr/bin/env bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Paths
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
LIB_PATH="$BASE_DIR/lib"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Helper functions
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

backup_file() {
    if [ -f "$1" ] || [ -d "$1" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$1" "$BACKUP_DIR/"
        log_info "Backed up $1 to $BACKUP_DIR"
    fi
}

safe_symlink() {
    local src="$1"
    local dest="$2"
    
    if [ -L "$dest" ]; then
        log_warn "$dest is already a symlink, skipping"
        return
    fi
    
    backup_file "$dest"
    ln -s "$src" "$dest"
    log_info "Created symlink: $dest -> $src"
}

# Detect package manager
detect_package_manager() {
    if command_exists brew; then
        echo "brew"
    elif command_exists dnf; then
        echo "dnf"
    elif command_exists apt; then
        echo "apt"
    elif command_exists pacman; then
        echo "pacman"
    else
        log_error "No supported package manager found"
        exit 1
    fi
}

# Install packages
install_packages() {
    local pm="$1"
    local packages="neovim zoxide eza bat zsh tmux ripgrep"
    
    log_info "Installing packages with $pm..."
    
    case "$pm" in
        brew)
            brew install $packages
            ;;
        dnf)
            sudo dnf install -y $packages util-linux-user
            ;;
        apt)
            sudo apt update
            sudo apt install -y $packages
            ;;
        pacman)
            sudo pacman -S --noconfirm $packages
            ;;
    esac
}

# Main installation
main() {
    log_info "Starting dotfiles installation..."

    # Create directories
    mkdir -p ~/Projects ~/Packages

    # Detect and install packages
    PM=$(detect_package_manager)
    log_info "Detected package manager: $PM"
    install_packages "$PM"

    # Install Oh-My-Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_info "Installing Oh-My-Zsh..."
        RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        log_warn "Oh-My-Zsh already installed, skipping"
    fi

    # Install Zsh plugins
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git \
            ~/.oh-my-zsh/plugins/zsh-autosuggestions
    fi

    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    fi

    # Install Dracula themes
    if [ ! -d ~/Packages/dracula-zsh ]; then
        git clone https://github.com/dracula/zsh.git ~/Packages/dracula-zsh
        safe_symlink ~/Packages/dracula-zsh/dracula.zsh-theme \
            ~/.oh-my-zsh/themes/dracula.zsh-theme
    fi

    if [ ! -d ~/Packages/dracula-zsh-syntax-highlighting ]; then
        git clone https://github.com/dracula/zsh-syntax-highlighting.git \
            ~/Packages/dracula-zsh-syntax-highlighting
    fi

    # Install Neovim config
    if [ ! -d ~/.config/nvim ]; then
        git clone https://github.com/LuckJMG/Neovim-Config.git ~/.config/nvim
    else
        log_warn "Neovim config already exists, skipping"
    fi

    # Install TPM (Tmux Plugin Manager)
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    # Create symlinks
    safe_symlink "$LIB_PATH/.zshrc" ~/.zshrc
    safe_symlink "$LIB_PATH/.gitconfig" ~/.gitconfig
    safe_symlink "$LIB_PATH/.tmux.conf" ~/.tmux.conf

    # Change default shell
    if [ "$SHELL" != "$(which zsh)" ]; then
        log_info "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
    fi

    log_info "Installation complete!"
    log_info "Backups saved to: $BACKUP_DIR"
    log_info "Please restart your terminal or run: exec zsh"
}

# Run main
main

