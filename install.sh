#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

INSTALL_OMZ=false
INSTALL_ALACRITTY=false

# ==========================================
# USAGE
# ==========================================
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --omz          Install Oh My Zsh"
    echo "  --alacritty    Install Alacritty terminal"
    echo "  --all          Install all of the above"
    echo "  -h, --help     Show this help message"
}

# ==========================================
# ARGUMENT PARSING
# ==========================================
for arg in "$@"; do
    case $arg in
        --omz)       INSTALL_OMZ=true ;;
        --alacritty) INSTALL_ALACRITTY=true ;;
        --all)       INSTALL_OMZ=true; INSTALL_ALACRITTY=true ;;
        -h|--help)   usage; exit 0 ;;
        *)           echo "Unknown option: $arg"; usage; exit 1 ;;
    esac
done

# ==========================================
# OH MY ZSH
# ==========================================
install_omz() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "Oh My Zsh is already installed, skipping."
        return
    fi
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# ==========================================
# ALACRITTY
# ==========================================
install_alacritty() {
    if command -v alacritty &>/dev/null; then
        echo "Alacritty is already installed, skipping."
        return
    fi

    # Detect OS
    if [[ -f /etc/os-release ]]; then
        # shellcheck disable=SC1091
        source /etc/os-release
    else
        echo "Cannot detect OS: /etc/os-release not found."
        exit 1
    fi

    case "$ID" in
        arch)
            # Alacritty is in the Arch official repos — no need to build from source
            echo "Installing Alacritty (Arch Linux)..."
            sudo pacman -S --noconfirm --needed alacritty
            echo "Alacritty installed successfully."
            return
            ;;
        ubuntu|debian)
            echo "Installing Alacritty build dependencies (Ubuntu/Debian)..."
            sudo apt install -y cmake g++ pkg-config libfontconfig1-dev \
                libxcb-xfixes0-dev libxkbcommon-dev python3
            ;;
        *)
            echo "Unsupported OS: '${ID}'. Only Ubuntu/Debian and Arch Linux are supported."
            echo "See: https://github.com/alacritty/alacritty/blob/master/INSTALL.md"
            exit 1
            ;;
    esac

    # Ubuntu/Debian: build from source

    # Install Rust toolchain if missing
    if ! command -v rustup &>/dev/null; then
        echo "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
        # shellcheck disable=SC1091
        source "$HOME/.cargo/env"
    fi
    rustup override set stable
    rustup update stable

    # Clone, build, install
    local build_dir
    build_dir=$(mktemp -d)
    echo "Cloning Alacritty source..."
    git clone https://github.com/alacritty/alacritty.git "$build_dir/alacritty"
    pushd "$build_dir/alacritty" >/dev/null

    cargo build --release

    # Binary
    sudo cp target/release/alacritty /usr/local/bin/alacritty

    # Terminfo
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

    # Desktop entry
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database

    # Zsh completions (fpath+=~/.zsh_functions is already set in .zshrc)
    mkdir -p "${ZDOTDIR:-$HOME}/.zsh_functions"
    cp extra/completions/_alacritty "${ZDOTDIR:-$HOME}/.zsh_functions/_alacritty"

    popd >/dev/null
    rm -rf "$build_dir"
    echo "Alacritty installed successfully."
}

# ==========================================
# SYMLINKS
# ==========================================
create_symlinks() {
    echo "Creating symlinks..."
    ln -sf "${SCRIPT_DIR}/.zshrc"              ~/.zshrc
    ln -sf "${SCRIPT_DIR}/.p10k.zsh"           ~/.p10k.zsh
    ln -sf "${SCRIPT_DIR}/.tmux.conf"          ~/.tmux.conf
    ln -sf "${SCRIPT_DIR}/.config/nvim"        ~/.config/nvim
    ln -sf "${SCRIPT_DIR}/.config/alacritty"   ~/.config/alacritty
}

# ==========================================
# MAIN
# ==========================================
$INSTALL_OMZ       && install_omz
$INSTALL_ALACRITTY && install_alacritty
create_symlinks

echo "Done!"
