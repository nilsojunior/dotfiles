#!/bin/sh

MOVE_WINDOW="hyprctl dispatch movewindow"

if ! $MOVE_WINDOW l | grep -q "ok"; then
    $MOVE_WINDOW r
fi
