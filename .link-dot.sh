#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

REPOS_PATH="$HOME/repos"
DOTFILES_PATH="$REPOS_PATH/dotfiles"
OBSIDIAN_VAULT_PATH="$REPOS_PATH/obsidian/Lemonek/"

cd $DOTFILES_PATH

stow -t "$HOME" .

# link obsidian settings (to keep this repos structure clean)
stow -t "$OBSIDIAN_VAULT_PATH/.obsidian" .obsidian
