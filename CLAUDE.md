# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a "stow package" that mirrors the structure of `$HOME`. Running `stow -t "$HOME" <package>` symlinks its contents into the home directory.

## Setup

```bash
./install.sh
```

This script installs `stow` (and `tree`, `jq`) via the detected package manager, handles WSL-specific symlink cleanup, then runs `stow --restow` on every package.

## Architecture

Each top-level directory is a stow package:

- **aws/** — `~/.aws/config`
- **bash/** — `~/.bash_profile`, `~/.bash_aliases`
- **inputrc/** — `~/.inputrc`

### Adding a new dotfile

1. Create a directory named after the package (e.g., `git/`).
2. Place files inside mirroring their path relative to `$HOME` (e.g., `git/.gitconfig`).
3. Run `./install.sh` or `stow -t "$HOME" --restow <package>`.

## Stow workflow

To restow a single package after editing: `stow -t "$HOME" --restow <package>`

The `.gitignore` excludes credentials, keys, and history files — only configuration belongs in this repo.
