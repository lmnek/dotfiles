if status is-interactive
    # Commands to run in interactive sessions can go here
end

# NOTE: Fisher plugins:
# joshmedeski/fish-lf-icons
# patrickf1/fzf.fish
# -> keybinds: 
#       Ctrl+Alt+F      search files/dirs - automcomplete + cd
#       Ctrl+R          search history
#       Ctrl+Alt+P      search processes - return PID
#       Ctrl+V          search variables

set -gx EDITOR nvim
set -gx BROWSER "brave" # --password-store=basic"
fish_add_path /home/lmnk/bin

fish_vi_key_bindings

# git
abbr lg 'lazygit' # only important thing lol
abbr g 'git'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -m'
abbr gca 'git commit --amend -m'
abbr gco 'git checkout'
abbr gcp 'git cherry-pick'
abbr gd 'git diff'
abbr gf 'git fetch'
abbr gl 'git log --all --decorate --oneline --graph'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gpl 'git pull'
abbr gr 'git remote'
abbr grb 'git rebase'
abbr gs 'git status'
abbr gst 'git stash'

abbr ps 'sudo pacman -S'
abbr pr 'sudo pacman -Rs'
abbr pq 'sudo pacman -Q | fzf'
abbr ys 'yay -S'
abbr yr 'yay -Rs'

abbr ls 'eza'  
abbr la 'eza -a'
abbr ll 'eza --long --header --git'
abbr lla 'eza --long --header -a --git'
abbr dnd 'dragon-drop'

abbr c 'codium .'
abbr n 'nvim'
abbr zl 'zellij' 
abbr zla 'zellij attach'

abbr te  'trans en:cs'
abbr tc  'trans cs:en'
abbr td  'trans -d'
abbr tse 'trans -shell en:cs'
abbr tsc 'trans -shell cs:en'

alias lf=lfcd

# newline after cmd
function postexec_test --on-event fish_postexec
   echo
end

thefuck --alias | source

starship init fish | source
