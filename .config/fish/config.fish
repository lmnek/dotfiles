if status is-interactive
    # Commands to run in interactive sessions can go here
end


# git
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

abbr ls 'exa'  
abbr la 'exa -a'
abbr ll 'exa --long --header --git'
abbr lla 'exa --long --header -a --git'

abbr c 'codium .'

thefuck --alias | source

starship init fish | source
