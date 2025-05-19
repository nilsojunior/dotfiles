# Get hostname
HOSTNAME=$(uname -n)

if [[ "$HOSTNAME" == "archbtw" ]]; then
    export DESKTOP="archbtw"
elif [[ "$HOSTNAME" == "arch" ]]; then
    export LAPTOP="arch"
else
    echo "Hostname not found."
fi

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="zen-browser"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
export HYPRSHOT_DIR="$HOME/Pictures/screenshots"
export HYPRCAP_DIR="$HOME/Pictures/hyprcap"

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# bat for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Jcup
export CLASSPATH="$HOME/Downloads/Jcup/java-cup-11b.jar:$HOME/Downloads/Jcup/java-cup-11b-runtime.jar:."

export PATH="$HOME/bin:$PATH"

# Catppuccin Mocha
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --multi"
