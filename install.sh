#!/bin/sh

echo "Running install script..."

echo "Installing paru..."
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/paru.git "$HOME/paru"
cd "$HOME/paru" || exit
makepkg -si --noconfirm

echo "Installing packages..."
cd "$HOME/dotfiles" || exit
paru -S --needed --noconfirm - <pkglist.lst

if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "Symlinking the directories..."
stow .
stow -t "$HOME/.config" .config
stow -t "$HOME" zsh

# NOT WORKING FOR SOME REASON
# stow -t ~ git/
# if [ $? -ne 0 ]; then
#     echo "Failed to stow git directory"
#     exit 1
# fi

# echo "Symlinking git config"
# ln -s git/.* "$HOME"

echo "Rebuilding bat's cache..."
bat cache --build

echo "Enabling keyd..."
sudo systemctl enable keyd

echo "Creating keyd directory..."
sudo cp -r keyd /etc

echo "Adding pacman config..."
sudo cp -r pacman/pacman.conf /etc

echo "Adding cursor config..."
sudo cp -r default /usr/share/icons

echo "Spicetify setup"
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

echo "Installing catppuccin gtk theme..."
./install.py mocha pink

echo "Installing flatpak packages..."
flatpak install -y dev.vencord.Vesktop
flatpak install -y com.stremio.Stremio

echo "Adding vesktop themes..."
cp -r vesktop/themes/mocha.css "$HOME/.var/app/dev.vencord.Vesktop/config/vesktop/themes/mocha.css"

echo "Changing default shell..."
chsh -s "$(which zsh)"

echo "Adding dash as system shell..."
sudo ln -sfT dash /usr/bin/sh

echo "Adding pacman hooks..."
sudo cp -r hooks/ /usr/share/libalpm/

echo "Done!"
