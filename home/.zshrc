# Auto start Hyprland
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]] && [[ -z $NO_HYPR ]]; then
    exec Hyprland
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Removing completion case sensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=auto $realpath' 
zstyle ':fzf-tab*' use-fzf-default-opts yes

if [[ -n "$TMUX" ]]; then
    # Inside Tmux
    zstyle ':fzf-tab*' fzf-flags --info=hidden --prompt=' ' --border=none \
        --preview-border=none --input-border=none
else
    zstyle ':fzf-tab*' fzf-flags --border=rounded --info=hidden --prompt=' ' \
        --preview-border=none --input-border=none --margin=0,25%
fi

# Tmux pop up window
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' popup-min-size 50 12
zstyle ':fzf-tab:complete:__zoxide_z:*' popup-min-size 50 12

# Remove zshell completion menu
zstyle ':completion:*' menu no

# Include hidden files
_comp_options+=(globdots)

# Aliases
alias reload="source ~/.zshrc && source ~/.zshenv"
alias ..="cd .."
alias vim="nvim"
alias v="nvim"
# alias ls="ls --color"
alias c="clear"
alias cls="clear; fastfetch"
alias z="cd"
alias pac="sudo pacman -S --noconfirm"
alias in="yay -Slq | fzf | xargs -ro yay -S"
alias un="yay -Qq | fzf | xargs -ro yay -Rns"
alias mkdir="mkdir -p"
alias cat="bat"
alias cdfzf='cd $(find . -type d | fzf)'
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias start-ssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519'
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias zi="__zoxide_zi" # Fix zinit and zoxide conflict
alias gs="git status"
alias gl="git log --graph --abbrev-commit --decorate --all --format=format:'%C(bold magenta)%h  %C(bold green)%ar %C(dim white)%an %C(auto)%d %C(reset)%s'"
alias grep="grep --color=always"

# Vim mode
bindkey -v
KEYTIMEOUT=1

# Yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
    zle -I
}
zle -N y
bindkey '^E' y

tmux_sessionizer() {
    (
        exec </dev/tty
        exec <&1
        tmux-sessionizer.sh
    )
    zle -I
}
zle -N tmux_sessionizer
bindkey '^F' tmux_sessionizer

bindkey '^Y' autosuggest-accept
bindkey '^G' clear-screen

# Navigation
bindkey '^[[1;5D' backward-word  # ctrl+left
bindkey '^[[1;5C' forward-word   # ctrl+right
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Edit command in vim
autoload edit-command-line; zle -N edit-command-line
bindkey '\ee' edit-command-line

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# fastfetch
