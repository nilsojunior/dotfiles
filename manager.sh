#!/bin/sh

CONFIG=".config"
HOME_D="home"

sync() {
    for file in $(find "$CONFIG" -maxdepth 1 -not -path "$CONFIG" | sed "s|$CONFIG/||"); do
        source="$PWD/$CONFIG/$file"
        target="$HOME/$CONFIG/$file"

        if [ ! -e "$target" ]; then
            ln -sfn "$source" "$target"
            echo "$source -> $target"
        fi
    done

    for file in $(find "$HOME_D" -maxdepth 1 -not -path "$HOME_D" | sed "s|$HOME_D/||"); do
        source="$PWD/$HOME_D/$file"
        target="$HOME/$file"

        if [ ! -e "$target" ]; then
            ln -sfn "$source" "$target"
            echo "$source -> $target"
        fi
    done

    scripts_src="$PWD/scripts"
    scripts_target="$HOME/.local/scripts"
    if [ ! -e "$scripts_target" ]; then
        ln -sfn "$scripts_src" "$scripts_target"
        echo "$scripts_src -> $scripts_target"
    fi
}

sync
