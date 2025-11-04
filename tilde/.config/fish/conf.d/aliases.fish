alias yank='xsel --input --clipboard'
alias paste='xsel --output --clipboard'
alias Y=yank
alias P=paste

# select command from history to copy to clipboard
alias yh='history | fzf --no-sort | tr -d "\n" | yank'

# jumping around the file system (consistent with Yazi keybinds)
# (mirrors yazi keybinds)
alias sd='cd $(fd --type directory | fzf)'
alias shd='cd $(fd --type directory --hidden | fzf)'
alias sf='cd $(dirname $(fd --type file | fzf))'
alias shf='cd $(dirname $(fd --type file --hidden | fzf))'

# --- Pacman ---
# Select package to install with fzf
alias pmqs='pacman -Slq | fzf --multi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'

# Select installed package to remove with fzf
alias pmqr='pacman -Qq | fzf --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'
# -> explicitely installed:
alias pmqer='pacman -Qeq | fzf --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'


alias py='python'
