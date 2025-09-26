alias yank='xsel --input --clipboard'
alias paste='xsel --output --clipboard'
alias Y=yank
alias P=paste

# select command from history to copy to clipboard
alias yh='history | fzf --no-sort | tr -d "\n" | yank'

# jumping around the file system (consistent with Yazi keybinds)
alias z='cd $(fd --type directory | fzf)'
alias Z='cd $(fd --type directory --hidden | fzf)'
alias s='cd $(dirname $(fd --type file | fzf))'
alias S='cd $(dirname $(fd --type file --hidden | fzf))'


# --- Pacman ---
# Select package to install with fzf
alias pqs='pacman -Slq | fzf --multi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'

# Select installed package to remove with fzf
alias pqr='pacman -Qq | fzf --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'
# -> explicitely installed:
alias pqer='pacman -Qeq | fzf --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'


alias py='python'
