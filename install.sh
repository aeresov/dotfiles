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

# Detect WSL
if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "WSL detected, cleaning up Windows symlinks..."
    for dir in */; do
        pkg="${dir%/}"
        # Find dotfiles/directories this package would stow
        find "$pkg" -maxdepth 2 -name '.*' | while read -r file; do
            target="$HOME/$(basename "$file")"
            # If target is an absolute symlink to /mnt/c, remove it
            if [[ -L "$target" ]] && readlink "$target" | grep -q '^/mnt/c'; then
                echo "Removing Windows symlink: $target → $(readlink "$target")"
                rm "$target"
            fi
        done
    done
fi

# Stow everything
cd "$DOTFILES_DIR"
for dir in */; do
    pkg="${dir%/}"
    echo "Stowing ${pkg}..."
    stow -t "$HOME" --restow "$pkg"
done

echo "Done!"

