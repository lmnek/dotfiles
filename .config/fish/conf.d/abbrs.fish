## Abbreviations

# --- Git ---
abbr lg 'lazygit' # only important thing lol
abbr g 'git'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -m'
abbr gca 'git commit --amend -m'
abbr gd 'git diff'
abbr gf 'git fetch'
abbr gl 'git log --all --decorate --oneline --graph'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpl 'git pull'
abbr gr 'git remote'
abbr gs 'git status'
abbr gst 'git stash'

# --- Pacman ---
abbr pS 'sudo pacman -S'
abbr py 'sudo pacman -Syyu'
abbr pr 'sudo pacman -Rs'
# Select package to install with fzf
abbr psq 'pacman -Slq | fzf --multi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
# Select installed package to remove with fzf
abbr pq 'pacman -Qq | fzf --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'
abbr ys 'yay -S'
abbr yr 'yay -Rs'

# --- Abbrs to use (and NOT FORGET!) improved coreutils ---
abbr find fd
abbr grep rg
abbr ps procs
abbr dig dog
abbr curl xh
abbr du dust
abbr df duf

abbr ls 'eza'  
abbr la 'eza -a'
abbr ll 'eza --long --header --git'
abbr lla 'eza --long --header -a --git'

# --- Other random goodies ---
abbr dnd dragon-drop
abbr c 'codium .'
abbr n nvim
abbr zl 'zellij' 
abbr zls 'zellij --session' 
abbr zla 'zellij attach'
abbr p 'python'
abbr sc 'systemctl'
abbr scu 'systemctl --user'
abbr ff fastfetch

# --- Translate shell ---
abbr tc  'trans en:cs'
abbr te  'trans cs:en'
abbr td  'trans -d'
abbr tsc 'trans -shell en:cs'
abbr tse 'trans -shell cs:en'

