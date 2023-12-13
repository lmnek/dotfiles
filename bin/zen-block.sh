#!/bin/bash

# doesnt work for youtube and twitter
append="127.0.0.1 www.facebook.com www.youtube.com www.twitter.com twitter.com www.twitter.hk www.x.com x.com www.instagram.com www.linkedin.com www.twitch.tv" 

original=$(</etc/hosts)

function finish {
    echo "$original" > /etc/hosts # restore original file
    tput cnorm # show cursor
    tput cud1 # one line down 
    echo -ne "/etc/hosts restored" 
}
trap finish EXIT

echo $append >> /etc/hosts

time=$1

tput civis # hide cursor

# wait for $time minutes with animation
for i in $(seq 0 $(($time - 1))); do
    echo -ne "Websites blocked for next" $((time - i)) "mins" "\r"
    sleep 1m
done

