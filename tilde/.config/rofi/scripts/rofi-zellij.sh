#!/usr/bin/env bash
set -euo pipefail

REPOS_PATH="$HOME/repos"
NEW_SESSION_PROMPT="-- new zellij session --"
CLONE_REPO_PROMPT="-- clone github repo --"

launch_terminal() {
    ghostty -e "$@"
}

launch_session() {
    local repo_name=$1
    launch_terminal fish -c "cd \"$REPOS_PATH/$repo_name\"; zellij --session \"$repo_name\""
}

rofi_menu() {
    local prompt=$1
    rofi -dmenu -location 0 -markup-rows -p "$prompt"
}

list_sessions() {
    echo "$NEW_SESSION_PROMPT"
    echo "$CLONE_REPO_PROMPT"
    zellij ls 2>/dev/null | tac | perl -pe '
        s/\e\[?.*?[\@-~]//g; # Strip ANSI color codes
        chomp;
        if (/^(\S+)\s+(.*)$/) {
            my ($first, $rest) = ($1, $2);
            $rest =~ s/\s*\(EXITED.*?\)// and $rest .= " (exited) ⭕";
            $_ = "<b>$first</b> <span size=\"xx-small\">$rest</span>\n";
        }
    '
}

strip_markup() {
    sed -E 's/<[^>]+>//g' <<<"$1"
}

repo_name_from_url() {
    basename "$1" .git
}

action_new_session() {
    local repo_name
    repo_name="$(ls -1 "$REPOS_PATH" | rofi_menu 'New session in repo')"
    [[ -z "$repo_name" ]] && exit 0
    launch_session "$repo_name"
}

action_clone_repo() {
    local url repo_name
    url="$(echo | rofi_menu 'Repo URL (or user/repo)')"
    [[ -z "$url" ]] && exit 0

    repo_name="$(repo_name_from_url "$url")"
    local target="$REPOS_PATH/$repo_name"

    if [[ -d "$target" ]]; then
        notify-send "rofi-zellij" "Repo '$repo_name' already exists, attaching."
    else
        notify-send "rofi-zellij" "Cloning $url ..."
        if ! git clone "$url" "$target" 2>/tmp/rofi-zellij-clone.log; then
            notify-send -u critical "rofi-zellij" "Clone failed: $(cat /tmp/rofi-zellij-clone.log)"
            exit 1
        fi
        notify-send "rofi-zellij" "Cloned into $target"
    fi

    launch_session "$repo_name"
}

action_attach() {
    local line=$1
    local session_name
    session_name="$(strip_markup "$line")"
    session_name="${session_name%% *}"
    launch_terminal zellij attach "$session_name"
}

main() {
    local selection
    selection="$(list_sessions | rofi_menu 'Attach')"
    [[ -z "$selection" ]] && exit 0

    case "$selection" in
        "$NEW_SESSION_PROMPT") action_new_session ;;
        "$CLONE_REPO_PROMPT")  action_clone_repo ;;
        *)                     action_attach "$selection" ;;
    esac
}

main "$@"
