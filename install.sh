#!/usr/bin/env sh

echo "Running install script..."

if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    cd ~
    if [ $? -ne 0 ]; then
        echo "Failed to change directory to home"
        exit 1
    fi
    sudo pacman -S --needed git base-devel --noconfirm
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
    makepkg -si --noconfirm
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
yay -S --needed --noconfirm - < pkglist.lst
if [ $? -ne 0 ]; then
    echo "Failed to install packages"
    exit 1
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    if [ $? -ne 0 ]; then
        echo "Failed to clone Tmux Plugin Manager repository"
        exit 1
    fi
fi

echo "Symlinking the directories..."
stow .
if [ $? -ne 0 ]; then
    echo "Failed to stow directories"
    exit 1
fi

stow -t ~/.config/ .config/
if [ $? -ne 0 ]; then
    echo "Failed to stow .config directories"
    exit 1
fi

stow -t ~ zsh/
if [ $? -ne 0 ]; then
    echo "Failed to stow zsh directory"
    exit 1
fi

# NOT WORKING FOR SOME REASON
# stow -t ~ git/
# if [ $? -ne 0 ]; then
#     echo "Failed to stow git directory"
#     exit 1
# fi

echo "Symlinking git config"
ln -s git/.* $HOME
if [ $? -ne 0 ]; then
    echo "Failed to symlink git config"
    exit 1
fi

echo "Rebuilding bat's cache..."
bat cache --build
if [ $? -ne 0 ]; then
    echo "Failed to rebuild bat's cache"
    exit 1
fi

echo "Enabling keyd..."
sudo systemctl enable keyd
if [ $? -ne 0 ]; then
    echo "Failed to enable keyd"
    exit 1
fi

echo "Creating keyd directory..."
sudo cp -r keyd/ /etc/
if [ $? -ne 0 ]; then
    echo "Failed to create keyd directory"
    exit 1
fi

echo "Adding pacman config..."
sudo cp -r pacman/ /etc/
if [ $? -ne 0 ]; then
    echo "Failed to add pacman config"
    exit 1
fi

echo "Adding cursor config..."
sudo cp -r default/ /usr/share/icons/
if [ $? -ne 0 ]; then
    echo "Failed to add pacman config"
    exit 1
fi

echo "Spicetify setup"
sudo chmod a+wr /opt/spotify
if [ $? -ne 0 ]; then
    echo "Failed to give permissions"
    exit 1
fi
sudo chmod a+wr /opt/spotify/Apps -R
if [ $? -ne 0 ]; then
    echo "Failed to give permissions"
    exit 1
fi

echo "Installing catppuccin gtk theme..."
./install.py mocha pink
if [ $? -ne 0 ]; then
    echo "Failed to install catppuccin gtk theme"
    exit 1
fi

chsh -s $(which zsh)
if [ $? -ne 0 ]; then
    echo "Failed to set zsh as login shell"
    exit 1
fi

echo "Done!"
