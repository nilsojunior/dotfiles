#!/bin/sh

selected=$(
    fd -e pdf . "$HOME/Downloads" "$HOME/Documents/PDFs" |
        sed "s|^$HOME/||" |
        fzf
)

selected_name=$(basename "$selected" | tr . _)

if [ "$selected" ]; then
    tmux new-window -n "$selected_name" -d xdg-open "$HOME/$selected"
fi
