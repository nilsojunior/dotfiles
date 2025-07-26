#!/bin/sh

shader=$(hyprshade current)
hyprshade off
hyprpicker --autocopy --format hsl
hyprshade on "$shader"
