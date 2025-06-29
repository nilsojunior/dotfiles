#!/usr/bin/env bash

open_in_nvim="/tmp/open_in_nvim"

dirs=(
    "$HOME/dotfiles"
    "$HOME/notes"
    "$HOME/personal"
    "$HOME/faculdade"
)

extra_dirs=(
    "$HOME/Documents"
    "$HOME/Downloads"
)

dirs+=($(fd --type d --exclude '.git*' -H . "${dirs[@]}"))

all_dirs=("${dirs[@]}" "${extra_dirs[@]}")

all_dirs=$(echo "${all_dirs[@]}" | tr ' ' '\n')

selected=$(
    echo "${all_dirs}" | sed "s|^$HOME/||" | fzf \
        --preview "eza -1 --color=always --icons=auto $HOME/{}" \
        --preview-window right:35% \
        --bind "ctrl-e:execute(touch $open_in_nvim)+accept"
)

if [ -n "$selected" ]; then
    cd "$HOME/$selected" || exit

    if [ -f "$open_in_nvim" ]; then
        rm "$open_in_nvim"
        nvim "$HOME/$selected"
    fi
fi
