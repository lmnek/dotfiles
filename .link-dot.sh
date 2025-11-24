#!/bin/bash

set -e

DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOS_PATH="$(dirname "$DOTFILES_PATH")"
OBSIDIAN_VAULT_PATH="$REPOS_PATH/obsidian/Lemonek"

STOW_OPTS=()
LINK_OBSIDIAN=false

usage() {
  echo "Usage: $0 [--adopt] [--obsidian]"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --adopt) STOW_OPTS+=(--adopt); shift ;;
    --obsidian) LINK_OBSIDIAN=true; shift ;;
    *) usage ;;
  esac
done

echo "Stowing dotfiles..."
stow "${STOW_OPTS[@]}" -d "$DOTFILES_PATH/tilde" -t "$HOME" .

if $LINK_OBSIDIAN; then
  echo "Stowing Obsidian config..."
  stow "${STOW_OPTS[@]}" -d "$DOTFILES_PATH" -t "$OBSIDIAN_VAULT_PATH/.obsidian" .obsidian
fi

echo "Done."
