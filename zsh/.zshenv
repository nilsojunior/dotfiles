source "$HOME/personal/env"

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="zen-browser"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
export HYPRSHOT_DIR="$HOME/Pictures/screenshots"
export HYPRCAP_DIR="$HOME/Pictures/hyprcap"

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# Neovim as man page
export MANPAGER='nvim +Man!'

# Jcup
export CLASSPATH="$HOME/Downloads/Jcup/java-cup-11b.jar:$HOME/Downloads/Jcup/java-cup-11b-runtime.jar:."

# Cedilla
export GTK_IM_MODULE=cedilla
export QT_IM_MODULE=cedilla

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Catppuccin Mocha
# Border is changed from "Surface 0" to "Blue"
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#89b4fa,label:#CDD6F4 \
    --style=minimal \
    --border=rounded \
    --preview-border=rounded \
    --input-border=rounded \
    --info=inline-right \
    --prompt=' '\
    --pointer=''\
    --multi"
