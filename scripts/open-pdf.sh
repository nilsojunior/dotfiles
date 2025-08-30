#!/bin/sh

selected=$(
    fd -e pdf . "$HOME/Downloads" "$HOME/Documents/PDFs" |
        sed "s|^$HOME/||" |
        fzf
)

if [ "$selected" ]; then
    setsid zathura "$HOME/$selected" &
    tmux kill-window
fi
