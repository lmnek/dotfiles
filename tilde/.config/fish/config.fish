# Other config files in "conf.d/"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# NOTE: Fisher plugins:
# patrickf1/fzf.fish
# -> keybinds: 
#       Ctrl+Alt+F      search files/dirs - automcomplete + cd
#       Ctrl+R          search history
#       Ctrl+Alt+P      search processes - return PID
#       Ctrl+V          search variables
set fzf_fd_opts --hidden --max-depth 5

fish_add_path /home/lmnk/bin

set -gx EDITOR "nvim"
set -gx BROWSER "zen-browser"

fish_vi_key_bindings

# newline after cmd
function postexec_test --on-event fish_postexec
   echo
end

starship init fish | source

# Created by `pipx` on 2025-01-15 21:16:54
set PATH $PATH /home/lmnk/.local/bin
