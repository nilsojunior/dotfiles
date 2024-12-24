#!/usr/bin/env bash

echo "Running install script..."

if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    cd ~
    if [ $? -ne 0 ]; then
        echo "Failed to change directory to home"
        exit 1
    fi
    sudo pacman -S --needed git base-devel
    if [ $? -ne 0 ]; then
        echo "Failed to install yay dependencies"
        exit 1
    fi
    git clone https://aur.archlinux.org/yay-bin.git
    if [ $? -ne 0 ]; then
        echo "Failed to clone yay repository"
        exit 1
    fi
    cd yay-bin
    if [ $? -ne 0 ]; then
        echo "Failed to enter yay directory"
        exit 1
    fi
    makepkg -si
    if [ $? -ne 0 ]; then
        echo "Failed to build yay"
        exit 1
    fi
fi

echo "Installing packages..."
cd ~/dotfiles/
if [ $? -ne 0 ]; then
    echo "Failed to enter dotfiles directory"
    exit 1
fi
yay -S --needed - < pkglist.lst
if [ $? -ne 0 ]; then
    echo "Failed to install packages"
    exit 1
fi

echo "Symlinking the directories..."
stow .
if [ $? -ne 0 ]; then
    echo "Failed to stow directories"
    exit 1
fi
stow -v -t ~ zsh/
if [ $? -ne 0 ]; then
    echo "Failed to stow zsh directory"
    exit 1
fi
stow -v -t ~/.config spotify/
if [ $? -ne 0 ]; then
    echo "Failed to stow spotify directory"
    exit 1
fi

echo "Rebuilding bat's cache..."
bat cache --build
if [ $? -ne 0 ]; then
    echo "Failed to rebuild bat's cache"
    exit 1
fi

echo "Done!"
