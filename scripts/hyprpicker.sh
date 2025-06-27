#!/bin/sh

shader=$(hyprshade current)
hyprshade off
hyprpicker -a
hyprshade on "$shader"
