#!/usr/bin/env bash

echo "Running install script..."

USER_HOME="/home/$SUDO_USER"
SUDO_CMD="sudo -u $SUDO_USER"

if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    cd "$USER_HOME"
    if [ $? -ne 0 ]; then
        echo "Failed to change directory to home"
        exit 1
    fi
    pacman -S --needed git base-devel --noconfirm
    if [ $? -ne 0 ]; then
        echo "Failed to install yay dependencies"
        exit 1
    fi
    $SUDO_CMD git clone https://aur.archlinux.org/yay-bin.git "$USER_HOME"
    if [ $? -ne 0 ]; then
        echo "Failed to clone yay repository"
        exit 1
    fi
    cd "$USER_HOME/yay-bin"
    if [ $? -ne 0 ]; then
        echo "Failed to enter yay directory"
        exit 1
    fi
    $SUDO_CMD makepkg -si --noconfirm
    if [ $? -ne 0 ]; then
        echo "Failed to build yay"
        exit 1
    fi
fi

echo "Installing packages..."
cd "$USER_HOME/dotfiles"
if [ $? -ne 0 ]; then
    echo "Failed to enter dotfiles directory"
    exit 1
fi
$SUDO_CMD yay -S --needed --noconfirm - < pkglist.lst
if [ $? -ne 0 ]; then
    echo "Failed to install packages"
    exit 1
fi

if [ ! -d "$USER_HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    $SUDO_CMD git clone https://github.com/tmux-plugins/tpm "$USER_HOME/.tmux/plugins/tpm"
    if [ $? -ne 0 ]; then
        echo "Failed to clone Tmux Plugin Manager repository"
        exit 1
    fi
fi

echo "Symlinking the directories..."
$SUDO_CMD stow .
if [ $? -ne 0 ]; then
    echo "Failed to stow directories"
    exit 1
fi
$SUDO_CMD stow -v -t "$USER_HOME" zsh/
if [ $? -ne 0 ]; then
    echo "Failed to stow zsh directory"
    exit 1
fi
$SUDO_CMD stow -v -t "$USER_HOME/.config" spotify/
if [ $? -ne 0 ]; then
    echo "Failed to stow spotify directory"
    exit 1
fi

$SUDO_CMD stow -v -t "$USER_HOME" git/
if [ $? -ne 0 ]; then
    echo "Failed to stow git directory"
    exit 1
fi

$SUDO_CMD ln -s "$USER_HOME/dotfiles/bin" "$USER_HOME"
if [ $? -ne 0 ]; then
    echo "Failed to symlink bin directory"
    exit 1
fi

$SUDO_CMD ln -s "$USER_HOME/dotfiles/pics" "$USER_HOME"
if [ $? -ne 0 ]; then
    echo "Failed to symlink pics directory"
    exit 1
fi

echo "Rebuilding bat's cache..."
$SUDO_CMD bat cache --build
if [ $? -ne 0 ]; then
    echo "Failed to rebuild bat's cache"
    exit 1
fi

echo "Enabling keyd..."
systemctl enable keyd
if [ $? -ne 0 ]; then
    echo "Failed to enable keyd"
    exit 1
fi

echo "Creating keyd directory..."
cp -r keyd/ /etc/
if [ $? -ne 0 ]; then
    echo "Failed to create keyd directory"
    exit 1
fi

echo "Adding pacman config..."
cp pacman/pacman.conf /etc/pacman.conf
if [ $? -ne 0 ]; then
    echo "Failed to add pacman config"
    exit 1
fi

chsh -s $(which zsh)
if [ $? -ne 0 ]; then
    echo "Failed to set zsh as login shell"
    exit 1
fi

echo "Done!"
