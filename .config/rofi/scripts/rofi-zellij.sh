#!/usr/bin/env bash

NEW_SESSION_PROMPT="-- create new zellij session (/repos) --"
REPOS_PATH="$HOME/repos"

set -euo pipefail

gen_list() {
    echo "$NEW_SESSION_PROMPT"
    # list sessions
    zellij ls | tac | perl -pe '
        s/\e\[?.*?[\@-~]//g;            # Remove ANSI color codes
        if (/\(EXITED.*?\)/) {          # If session is exited
            s/\s*\(EXITED.*?\)//;            # Remove the EXITED annotation
            chomp; $_ .= " (exited) ⭕\n";   # Append the emoji
        }
    '
}

# Select session
LINE="$(gen_list | rofi -dmenu -location 0 -p 'Attach')"

[[ -z "$LINE" ]] && exit 0

if [[ "$NEW_SESSION_PROMPT" == "$LINE" ]]; then
    # Select repo to create session in 
    REPO_NAME="$(ls -1 "$REPOS_PATH" | rofi -dmenu -location 0 -p 'Attach' -theme+listview+columns 2)"
    [[ -z "$REPO_NAME" ]] && exit 0

    # Create new session and attach
    ghostty -e "fish -c 'cd $REPOS_PATH/$REPO_NAME; zellij --session $REPO_NAME'"
else
    # Launch terminal and attach the session
    SESSION_NAME="${LINE%% *}"
    ghostty -e "zellij attach $SESSION_NAME"
fi

exit 0
