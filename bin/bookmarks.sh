#!/usr/bin/env bash

BOOKMARKS="$HOME/.config/rofi/bookmarks"

selected=$(awk -F'|' '{print $1}' "$BOOKMARKS" | rofi -dmenu)

if [ -n "$selected" ]; then
    url=$(grep "^$selected|" "$BOOKMARKS" | awk -F'|' '{print $2}')
    if [ -n "$url" ]; then
        xdg-open "$url"
    fi
fi
