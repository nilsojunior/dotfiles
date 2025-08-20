#!/bin/sh

sync() {
    CONFIG=".config"
    HOME_D="home"

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

install() {
    paru="$HOME/repos/paru"
    cwd=$(pwd)
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/paru.git "$paru"
    cd "$HOME/paru" || exit
    makepkg -si --noconfirm
    cd "$cwd" || exit

    paru -S --needed --noconfirm - <pkglist.lst

    host=$(hostname)
    if [ "$host" = "archbtw" ]; then
        paru -S --needed --noconfirm nvidia nvidia-utils lib32-nvidia-utils egl-wayland
    elif [ "$host" = "arch" ]; then
        echo "Skipping Nvidia drives..."
    else
        echo "Hostname: '$host' is not expected."
    fi

    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

    sync

    bat cache --build

    # Cursor setup
    echo "[Icon Theme]" >>"/usr/share/icons/default/index.theme"
    echo "Inherits=Bibata-Modern-Ice" >>"/usr/share/icons/default/index.theme"

    # Spicetify setup
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R

    # Catppuccin gtk theme
    ./install.py mocha pink

    flatpak install -y dev.vencord.Vesktop
    flatpak install -y com.stremio.Stremio

    chsh -s "$(which zsh)"

    # Use dash as system shell
    sudo ln -sfT dash /usr/bin/sh
    sudo cp hooks/bash-update.hook /usr/share/libalpm/
}
