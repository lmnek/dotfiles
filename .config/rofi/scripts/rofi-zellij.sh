#!/usr/bin/env bash

NEW_SESSION_PROMPT="-- create new zellij session (/repos) --"
REPOS_PATH="$HOME/repos"

set -euo pipefail

gen_list() {
    echo "$NEW_SESSION_PROMPT"
    # list sessions
    zellij ls | perl -pe '
        s/\e\[?.*?[\@-~]//g;            # Remove ANSI color codes
        if (/\(EXITED.*?\)/) {          # If session is exited
            s/\s*\(EXITED.*?\)//;            # Remove the EXITED annotation
            chomp; $_ .= " (exited) ⭕\n";   # Append the emoji
        }
    '
}

LINE="$(gen_list | rofi -dmenu -location 0 -p 'Attach')"

[[ -z "$LINE" ]] && exit 0

if [[ "$NEW_SESSION_PROMPT" == "$LINE" ]]; then
    REPO_NAME="$(ls -1 "$REPOS_PATH" | rofi -dmenu -location 0 -p 'Attach' -theme+listview+columns 2)"
    [[ -z "$REPO_NAME" ]] && exit 0

    ghostty -e "fish -c 'cd $REPOS_PATH/$REPO_NAME; zellij --session $REPO_NAME'"
else
    SESSION_NAME="${LINE%% *}" # split on first space
    ghostty -e "zellij attach $SESSION_NAME"
fi

exit 0
