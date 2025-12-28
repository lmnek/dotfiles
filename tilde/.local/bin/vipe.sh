#!/bin/bash
set -eu

# Defaults
MODE="inline"
TERMAPP="xterm" # or "ghostty"
TERM_CLASS=""
NVIM_OPTS=(
    -c startinsert
    -c 'lua vim.keymap.set("i","<S-CR>","<Esc>:wq!<CR>",{silent=true})'
)

# Argument Parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        -l|--launch) MODE="term" ;;
        -p|--picker) MODE="term"; TERM_CLASS="vipe_picker"; NVIM_OPTS+=("-u" "NORC") ;;
        --class)     TERM_CLASS="$2"; shift ;;
        --nvim-opts) NVIM_OPTS+=("$2"); shift ;;
        *)           break ;;
    esac
    shift
done


# Create tmp file and fill with input pipe (if present)
tmp="$(mktemp)"
trap 'rm -rf "$tmp"' EXIT INT HUP TERM
fill() { [ -t 0 ] && : >"$1" || cat >"$1"; }
fill "$tmp"

# Edit with nvim (same terminal or launch new terminal)
if [ "$MODE" = "inline" ]; then
    nvim "${NVIM_OPTS[@]}" "$tmp" </dev/tty >/dev/tty
elif [ "$MODE" = "term" ]; then
    TERM_FLAGS=()
    [[ -n "$TERM_CLASS" ]] && TERM_FLAGS+=(-name "$TERM_CLASS") # or --class for ghostty

    "$TERMAPP" "${TERM_FLAGS[@]}" -e bash -lc 'nvim "$@"' -- \
        "${NVIM_OPTS[@]}" "$tmp" </dev/null >/dev/null 2>&1
fi

# For output pipe 
cat "$tmp"
