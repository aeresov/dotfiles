#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect package manager
install_pkg() {
    if command -v apt-get &>/dev/null; then
        sudo apt-get update && sudo apt-get install -y "$@"
    elif command -v brew &>/dev/null; then
        brew install "$@"
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm "$@"
    else
        echo "No supported package manager found. Install manually: $*"
        exit 1
    fi
}

# Install stow if needed
command -v stow &>/dev/null || install_pkg stow

# Optional: install other tools you want everywhere
command -v tree &>/dev/null || install_pkg tree
command -v jq &>/dev/null || install_pkg jq

# Stow everything
cd "$DOTFILES_DIR"
for dir in */; do
    pkg="${dir%/}"
    echo "Stowing ${pkg}..."
    stow -t "$HOME" --restow "$pkg"
done

echo "Done!"

