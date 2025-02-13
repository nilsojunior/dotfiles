#!/usr/bin/env sh

git pull --recurse-submodules
curl -L -o $HOME/dotfiles/stylus/import.json https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json
