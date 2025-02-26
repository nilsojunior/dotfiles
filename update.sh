#!/usr/bin/env bash

git pull --recurse-submodules
curl -sL -o $HOME/dotfiles/stylus/import.json https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json
tldr --update
spicetify backup apply
