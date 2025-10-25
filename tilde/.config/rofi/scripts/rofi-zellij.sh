#!/usr/bin/env bash

NEW_SESSION_PROMPT="-- new zellij session --"
REPOS_PATH="$HOME/repos"

launch_terminal() {
    ghostty -e $1
}

new_session_cmd() {
    REPO_PATH=$1
    REPO_NAME=$2
    echo "fish -c 'cd $REPOS_PATH/$REPO_NAME; zellij --session $REPO_NAME'"
}
launch_terminal() {
  ghostty -e "$@"            # forward all args as argv
}

new_session_cmd() {
  local repo_path=$1
  local repo_name=$2
  NEW_SESSION_CMD=(fish -c "cd \"$repo_path/$repo_name\"; zellij --session \"$repo_name\"")
}

set -euo pipefail

gen_list() {
    echo "$NEW_SESSION_PROMPT"
    # list sessions
    zellij ls | tac | perl -pe '
        s/\e\[?.*?[\@-~]//g; # Remove ANSI color code
        chomp;
        if (/^(\S+)\s+(.*)$/) {
            my ($first, $rest) = ($1, $2);
            $rest =~ s/\s*\(EXITED.*?\)// and $rest .= " (exited) ⭕"; # Replace exit message
            $_ = "<b>$first</b> <span size=\"xx-small\">$rest</span>\n"; # Add markup
        }
    '
}

remove_markup() {
    echo "$1" | sed -E 's/<[^>]+>//g'
}

# Select session
LINE="$(gen_list | rofi -dmenu -location 0 -markup-rows -p 'Attach')"

[[ -z "$LINE" ]] && exit 0

if [[ "$NEW_SESSION_PROMPT" == "$LINE" ]]; then
    # Select repo to create session in 
    REPO_NAME="$(ls -1 "$REPOS_PATH" | rofi -dmenu -location 0 -p 'Attach' -theme+listview+columns 2)"
    [[ -z "$REPO_NAME" ]] && exit 0

    # Create new session and attach
    new_session_cmd "$REPOS_PATH" "$REPO_NAME"
    launch_terminal "${NEW_SESSION_CMD[@]}"
else
    # Launch terminal and attach the session
    CLEAN_LINE="$(remove_markup "$LINE")"
    SESSION_NAME="${CLEAN_LINE%% *}"
    launch_terminal zellij attach $SESSION_NAME
fi

exit 0
