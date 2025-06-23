#!/usr/bin/env bash

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

selected=$(echo "${all_dirs}" | sed "s|^$HOME/||" | fzf \
    --preview "eza -1 --color=always --icons=auto $HOME/{1}" \
    --preview-window=right:35%)

if [ -n "$selected" ]; then
    cd "$HOME/$selected"
fi
