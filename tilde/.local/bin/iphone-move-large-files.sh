# !/bin/sh

# my version
du -a ~/iPhone/DCIM | sort -n -r | head -n 30 | grep .MOV | awk '{ print $2 }' | parallel mv {} ~/vids/iphone/

# generated version
# find ~/iPhone -type f \( -iname '*.mov' -o -iname '*.mp4' \) -printf '%s %p\n' | sort -n -r | head -n 30 | awk '{print $2}' | xargs -I{} mv {} ~/vids/iphone/

