#!/bin/sh

shader=$(hyprshade current)
hyprshade off
hyprpicker --autocopy
hyprshade on "$shader"
