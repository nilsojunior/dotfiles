#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
WALLPAPER_DIR="$HOME/personal/wallpapers/backgrounds"

if [[ "$HOSTNAME" == "$DESKTOP" ]]; then
    ROFI_CONFIG="$HOME/.config/rofi/wallpaper.rasi"
elif [[ "$HOSTNAME" == "$LAPTOP" ]]; then
    ROFI_CONFIG="$HOME/.config/rofi/wallpaper-laptop.rasi"
else
    echo "Hostname not found."
fi

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | while read -r a; do
    label=${a#"$WALLPAPER_DIR"/} # strip only the base dir, keep subdirs
    echo -en "$label\0icon\x1f$a\n"
done | rofi -dmenu -i -config "$ROFI_CONFIG")

if [[ -n "$WALLPAPER" ]]; then
    WALLPAPER_PATH_DYNAMIC="~/personal/wallpapers/backgrounds/$WALLPAPER"

    echo "preload = $WALLPAPER_PATH_DYNAMIC" >"$CONFIG_FILE"
    echo "wallpaper = , $WALLPAPER_PATH_DYNAMIC" >>"$CONFIG_FILE"

    killall hyprpaper
    hyprpaper &
fi
