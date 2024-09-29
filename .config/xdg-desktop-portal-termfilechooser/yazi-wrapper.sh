#!/bin/sh

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.

# See `common.sh` for the description of the input arguments and the output format.

set -eu

. "${0%/*}/common.sh"  # source common functions

multiple=$1
directory=$2
save=$3
path=$4
out=$5

cmd='yazi'
termcmd=$(default_termcmd)

if [ "$save" = "1" ]; then
	create_save_file "$path" "$out"
	set -- --chooser-file="$out" "$path"
elif [ "$directory" = "1" ]; then
	set -- --chooser-file="$out" --cwd-file="$out"
	# Returns either the dir explicitly selected (with e.g. <Enter>), or the last dir yazi was in before exiting.
else
	set -- --chooser-file="$out"
fi

$termcmd $cmd "$@"

# #!/bin/bash
# set -x
# multiple="$1"
# directory="$2"
# save="$3"
# path="$4"
# out="$5"
# cmd="yazi"
# termcmd="${TERMCMD:-wezterm start --always-new-process}"
#
# if [ "$save" = "1" ]; then
#     ARGS=--chooser-file="$out"
# elif [ "$directory" = "1" ]; then
#     ARGS=--cwd-file="$out"
# elif [ "$multiple" = "1" ]; then
#     ARGS=--chooser-file="$out"
# else
#     ARGS=--chooser-file="$out"
# fi
#
# $termcmd $cmd $ARGS
#
# if [ "$save" = "1" ] && [ ! -s "$out" ]; then
#     /usr/bin/rm "$path"
# fi
