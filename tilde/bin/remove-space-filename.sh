# !/bin/sh

path="$1"

filename="$(basename "$path")"
dirs="$(dirname "$path")"

new_filename="${filename// /-}"
new_path="${dirs}/${new_filename}"

mv "$path" $new_path
echo $new_path


