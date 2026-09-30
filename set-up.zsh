#!/usr/bin/env sh
# Symlink this repo's zsh config into $HOME. Run from anywhere:
#   sh set-up.zsh   bash set-up.zsh   zsh set-up.zsh   ./set-up.zsh

set -e

err() {
	printf '\033[31m%s\033[0m\n' "$1" >&2
}

DOTFILES=$(cd -- "$(dirname "$0")" && pwd)

if [ ! -f "$DOTFILES/zsh/.zshrc" ] || [ ! -f "$DOTFILES/zsh/.zprofile" ] || [ ! -d "$DOTFILES/zsh/.zsh" ]; then
	err "set-up.zsh: expected zsh/.zshrc, zsh/.zprofile, and zsh/.zsh under $DOTFILES"
	exit 1
fi

if [ -e "$HOME/.zsh" ] && [ ! -L "$HOME/.zsh" ]; then
	err "set-up.zsh: $HOME/.zsh exists and is not a symlink — move or back it up, then re-run."
	exit 1
fi

ln -sfn "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"
ln -sfn "$DOTFILES/zsh/.zsh" "$HOME/.zsh"

echo "Linked zsh config from $DOTFILES"
echo "  ~/.zshrc    -> zsh/.zshrc"
echo "  ~/.zprofile -> zsh/.zprofile"
echo "  ~/.zsh      -> zsh/.zsh"
printf '\033[32mOpen a new terminal or run: exec zsh -l\033[0m\n'
