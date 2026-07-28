# Automatically update herdr tab names — same trick as zellij.fish

if status is-interactive
    if type -q herdr
        # Rename the tab to the process being run — herdr-index.py puts the position
        # number back on the front when it sees the rename.
        function herdr_tab_name_update_pre --on-event fish_preexec
            if set -q HERDR_TAB_ID
                set -l cmd_line (string split " " -- $argv)
                set -l process_name $cmd_line[1]
                command nohup herdr tab rename $HERDR_TAB_ID $process_name >/dev/null 2>&1
            end
        end

        # One indexer per session; it holds an abstract socket, so losing this race is free.
        if set -q HERDR_SESSION
            command nohup ~/.config/herdr/herdr-index.py >/dev/null 2>&1 &
            disown
        end
    end
end
