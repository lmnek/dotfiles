#!/bin/bash

# Open Brave in the background
brave --app="https://calendar.google.com/" &

# Open TickTick in the background
ticktick &

# Wait for TickTick to open. Adjust the 10 if needed.
for i in {1..10}; do
    # Try to focus TickTick. If successful, break out of the loop.
    if i3-msg '[title="TickTick"] focus'; then
        break
    fi
    # Sleep for half a second before trying again.
    sleep 0.5
done

# Resize the TickTick window
i3-msg "resize shrink width 25 px or 25 ppt"

