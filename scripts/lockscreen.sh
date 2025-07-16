#!/bin/sh

# Sleep before screenshot for wlogout to disappear
sleep 0.1

shader=$(hyprshade current)
hyprshade off

HOST=$(uname -n)
if [ "$HOST" = "$DESKTOP" ]; then
    grim -o DP-2 /tmp/lockscreen.png
elif [ "$HOST" = "$LAPTOP" ]; then
    grim -o eDP-1 /tmp/lockscreen.png
else
    echo "Hostname not found."
fi

hyprshade on "$shader"
hyprlock
