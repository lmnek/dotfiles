# Automatically update zellij tab names
# thx: https://haseebmajid.dev/posts/2024-07-26-how-i-configured-zellij-status-bar/

if status is-interactive
    if type -q zellij
        # Update the zellij tab name with the current process name or pwd.
        function zellij_tab_name_update_pre --on-event fish_preexec
            if set -q ZELLIJ
                set -l cmd_line (string split " " -- $argv)
                set -l process_name $cmd_line[1]
                command nohup zellij action rename-tab $process_name >/dev/null 2>&1
            end
        end

        function zellij_tab_name_update_post --on-event fish_postexec --on-variable PWD # --on-event fish_prompt
            if set -q ZELLIJ
                command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
            end
        end
    end
end
