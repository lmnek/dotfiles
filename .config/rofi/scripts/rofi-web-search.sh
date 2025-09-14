#!/usr/bin/env bash
# Primary inspo: https://codeberg.org/anhsirk0/rofi-config/src/branch/main/browser/browser_menu.pl
# + Miroslav Vidovic snippet

# docs: https://davatorium.github.io/rofi/1.7.3/rofi.1/

# nice-to-have:
# - icons like in ulauncher (https://github.com/davatorium/rofi/discussions/2001)
# - list of bookmarks

set -euo pipefail

BROWSER_CLASS="zen"
BROWSER_I3_WORKSPACE=2

# One single array: each element is "prefix|label|base-URL"
MENU=(
    "*|Google|https://www.google.com/search?q="
    "r|Reddit|https://www.google.com/search?q=site%3Areddit.com+"
    "p|Perplexity|https://www.perplexity.ai/?q="
    "d|DuckDuckGo|https://duckduckgo.com/?q="
    "bs|Brave|https://search.brave.com/search?q="
    "i|Images|https://www.google.com/search?tbm=isch&q="
    "m|Maps|https://google.com/maps?q="
    "sm|Seznam Mapy|https://en.mapy.cz/turisticka?q="
    "w|Wikipedia|https://en.wikipedia.org/wiki/"
    "y|YouTube|https://www.youtube.com/results?search_query="
    "o|ChatGPT|https://chat.openai.com/?temporary-chat=true&q="
    "gh|GitHub|https://github.com/search?q="
    "lh|localhost|http://localhost:"
    "u|URL from clipboard|" # special mode
)

gen_list() {
    for entry in "${MENU[@]}"; do
        IFS='|' read -r prefix label url <<< "$entry"
        echo "${prefix} → <b>${label}</b>"
    done
}

# input: base_url, query
url_encode() {
    local base="$1"
    enc_query=$(echo "$2" | jq -Rr @uri)
    printf '%s' "${base}${enc_query}"
}

# input: prefix, rest, all
compose_url() {
    # Look up the matching URL for selected prefix
    for entry in "${MENU[@]}"; do
        IFS='|' read -r prefix label base <<< "$entry"
        if [[ "$prefix" == "$1" ]]; then
            printf '%s' "$(url_encode "$base" "$2")"
            return 0
        fi
    done

    # fallback to Google if prefix not found
    base="${MENU[0]#*|*|}"
    printf '%s' "$(url_encode "$base" "$3")"
}

# run rofi
input="$(gen_list | rofi -dmenu -matching prefix -location 0 -markup-rows -p 'Search')"

[[ -z "$input" ]] && exit 0

# split on first space
prefix="${input%% *}"
rest="${input#* }"

if [[ "$prefix" == "u" ]]; then
    # URL from clipboard
    target="$(xsel --output --clipboard)"
else
    # Normal querying
    target=$(compose_url "$prefix" "$rest" "$input")
fi

echo "Opening: $target"
if ! xdg-open "$target" >/dev/null 2>&1; then
    notify-send "Failed to open: $target"
    exit -1
fi

# switch to browser workspace if not on it
CURRENT_WORKSPACE=$(i3-msg -t get_workspaces \
            | jq -r '.[] | select(.focused==true).name' \
            | cut -d ":" -f 1)
if [[ "$CURRENT_WORKSPACE" != "$BROWSER_I3_WORKSPACE" ]]; then
    # i3-msg [class="$BROWSER_CLASS"] focus
    i3-msg workspace number "$BROWSER_I3_WORKSPACE"
fi

exit 0
