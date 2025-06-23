#!/bin/sh

STATE_FILE="/tmp/hyprland_cursor"

if [ -f "$STATE_FILE" ]; then
    hyprctl keyword cursor:hide_on_key_press true
    rm "$STATE_FILE"
    notify-send "Cursor hide on key press enabled"
else
    hyprctl keyword cursor:hide_on_key_press false
    touch "$STATE_FILE"
    notify-send "Cursor hide on key press disabled"
fi
