#!/bin/sh

selected=$(
    fd -e pdf . "$HOME/Downloads" "$HOME/Documents/PDFs" |
        sed "s|^$HOME/||" |
        fzf \
            --margin=10% \
            --input-label="PDFs"
)

if [ "$selected" ]; then
    setsid zathura "$HOME/$selected" &
    tmux kill-window
fi
