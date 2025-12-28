#!/bin/bash
set -eu

# Example usage:
# echo "input from pipe" | vipe.sh --launch -- -c 'norm o aloha' | bat

# Defaults
TERMAPP="xterm" # or ghostty
TERM_CLASS="vipe" # for i3wm window matching
NVIM_OPTS=(
    -c startinsert
    -c 'lua vim.keymap.set("i","<S-CR>","<Esc>:wq!<CR>",{silent=true})'
) 

# Modes: inline (current terminal) or term (launch external)
MODE="inline"

# Arg Parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        -l|--launch) MODE="term" ;;
        -p|--picker) MODE="term"; TERM_CLASS="vipe_picker"; NVIM_OPTS+=("-u" "NORC") ;;
        --class)     TERM_CLASS="$2"; shift ;;
        --) shift; NVIM_OPTS+=("$@"); break ;; # add everything remaining to nvim options
        *) echo "Unknown internal argument: $1." >&2; exit 1 ;;
    esac
    shift
done

# Create temp file & handle input
tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
[ -t 0 ] || cat >"$tmp" # If stdin is NOT a tty (it's a pipe) => fill tmp file with input pipe

# Execution construction
if [[ "$MODE" == "term" ]]; then
    TERM_FLAGS=(); [[ -n "$TERM_CLASS" ]] && TERM_FLAGS+=(-name "$TERM_CLASS") # or --class for ghostty 

    CMD=("$TERMAPP" "${TERM_FLAGS[@]}" -e nvim)
elif [[ "$MODE" == "inline" ]] then
    CMD=(nvim)
    exec < /dev/tty > /dev/tty # requires TTY redirection so nvim takes over terminal 
fi

# Nvim input / editing
"${CMD[@]}" "${NVIM_OPTS[@]}" "$tmp"

# For output pipe  
cat "$tmp"
