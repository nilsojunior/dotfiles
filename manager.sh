#!/bin/sh

setup_symlinks() {
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

setup_kanata() {
    sudo groupadd uinput

    sudo usermod -aG input "$USER"
    sudo usermod -aG uinput "$USER"

    echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee "/etc/udev/rules.d/99-input.rules"

    sudo udevadm control --reload-rules && sudo udevadm trigger
}

setup_spicetify() {
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R
}

setup_dash() {
    sudo ln -sfT dash /usr/bin/sh
    sudo cp hooks/bash-update.hook /usr/share/libalpm/
}

setup_cursor() {
    echo "[Icon Theme]" >>"/usr/share/icons/default/index.theme"
    echo "Inherits=Bibata-Modern-Ice" >>"/usr/share/icons/default/index.theme"
}

install_pkgs() {
    paru -S --needed --noconfirm - <pkglist.lst
}

install_paru() {
    paru="$HOME/repos/paru"
    cwd=$(pwd)

    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/paru.git "$paru"

    cd "$paru" || exit
    makepkg -si --noconfirm
    cd "$cwd" || exit
}

install_machine_specific_pkgs() {
    host=$(hostname)

    if [ "$host" = "archbtw" ]; then
        paru -S --needed --noconfirm nvidia nvidia-utils lib32-nvidia-utils egl-wayland
    elif [ "$host" = "arch" ]; then
        echo "Skipping Nvidia drives..."
    else
        echo "Hostname: '$host' is not expected."
    fi
}

install() {
    install_paru
    install_pkgs
    install_machine_specific_pkgs

    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

    setup_symlinks

    bat cache --build

    setup_spicetify
    setup_dash
    setup_cursor
    # setup_kanata

    # Catppuccin gtk theme
    ./install.py mocha pink

    flatpak install -y dev.vencord.Vesktop
    flatpak install -y com.stremio.Stremio

    chsh -s "$(which zsh)"
}

update() {
    git pull --recurse-submodules
    git submodule update --remote
    curl -sL -o "$HOME/dotfiles/stylus/import.json" https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json
    tldr --update
    install_pkgs
}
