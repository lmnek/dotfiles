#!/bin/bash

set -e  # Exit on error

REPOS_PATH="$HOME/repos"
DOTFILES_PATH="$REPOS_PATH/dotfiles"
OBSIDIAN_VAULT_PATH="$REPOS_PATH/obsidian/Lemonek"

STOW_OPTS=""
LINK_OBSIDIAN=false

usage() {
  echo "Usage: $0 [--adopt] [--obsidian]"
  echo ""
  echo "  --adopt       Use \"stow --adopt\" to pull existing files into stowed structure"
  echo "  --obsidian    Enable linking for Obsidian configuration"
  exit 1
}

# Parse CLI arguments
for arg in "$@"; do
  case $arg in
    --adopt)
      STOW_OPTS="--adopt"
      shift
      ;;
    --obsidian)
      LINK_OBSIDIAN=true
      shift
      ;;
    *)
      echo "Unknown argument: $arg"
      usage
      ;;
  esac
done

echo "Running stow${STOW_OPTS:+ with options: $STOW_OPTS}"

# Apply dotfiles to ~
cd "$DOTFILES_PATH/tilde"
stow $STOW_OPTS -t "$HOME" .

if [ "$LINK_OBSIDIAN" = true ]; then
  echo "Linking Obsidian settings..."
  cd "$DOTFILES_PATH"
  stow $STOW_OPTS -t "$OBSIDIAN_VAULT_PATH/.obsidian" .obsidian
else
  echo "Skipping Obsidian linking"
fi

echo "Done."
