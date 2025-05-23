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

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

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

# Remove zshell completion menu
zstyle ':completion:*' menu no

# Aliases
alias reload="source ~/.zshrc"
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

find_dirs() {
    . find-dirs
    zle -I
}
zle -N find_dirs
bindkey '^F' find_dirs

bindkey -s '^O' '. find-files\n'
bindkey -s '^P' 'y\n'
bindkey '^Y' autosuggest-accept

# Navigation
bindkey '^[[1;5D' backward-word  # ctrl+left
bindkey '^[[1;5C' forward-word   # ctrl+right
bindkey '^H' backward-kill-word  # ctrol+backspace

# Edit command in vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# fastfetch
