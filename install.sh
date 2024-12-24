echo "Running install script..."

echo "Installing packages..."
yay -S --needed - < pkglist.lst

echo "Symlinking the directories..."
stow .
stow -v -t ~ zsh/
stow -v -t ~/.config spotify/

echo "Rebuilding bat's cache..."
bat cache --build

echo "Done!"
