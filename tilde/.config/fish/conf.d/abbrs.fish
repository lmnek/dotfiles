
# --- Git ---
abbr lg 'lazygit' # only important thing lol
abbr gl 'git log --all --decorate --oneline --graph'
abbr gc 'git clone'

# --- Pacman ---
abbr pms 'sudo pacman -S'
abbr pmy 'sudo pacman -Syyu'
abbr pmr 'sudo pacman -Rs'
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

abbr nv nvim

abbr ls 'eza'  
abbr la 'eza -a'
abbr ll 'eza --long --header --git'
abbr lla 'eza --long --header -a --git'

# --- Goto dirs (subset of Yazi keybinds) ---
abbr h 'cd ~/'
abbr r 'cd ~/repos'
abbr g 'cd "$(git rev-parse --show-toplevel)"'

# --- Systemd services ---
abbr scsp 'systemctl stop'
abbr scst 'systemctl start'
abbr scr 'systemctl restart'
abbr scs 'systemctl status'

# --- Translate shell ---
abbr tc  'trans en:cs'
abbr te  'trans cs:en'
abbr td  'trans -d'
abbr tsc 'trans -shell en:cs'
abbr tse 'trans -shell cs:en'

# --- Other random goodies ---
abbr dnd ripdrag
abbr c 'codium .'
abbr zl 'zellij'
abbr zls 'zellij --session'
abbr zla 'zellij attach'
abbr ff fastfetch
abbr q qalc
