#!/bin/sh

git pull --recurse-submodules
git submodule update --remote
curl -sL -o "$HOME/dotfiles/stylus/import.json" https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json
tldr --update
killall hyprpaper
hyprpaper
