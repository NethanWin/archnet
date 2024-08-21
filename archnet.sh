#!/bin/bash
#sudo pacman -Syyu
#bash ./scripts/desktop-enviorment-chooser.sh

#sudo pacman -S noconfirm --needed ly
#sudo systemctl enable ly

######### pkgs #########
# utilities
echo "installing base pacman pkgs"
sudo pacman -S --noconfirm --needed $(<./pkgs/utils)
sudo pacman -S --noconfirm --needed $(<./pkgs/gui)
sudo pacman -S --noconfirm --needed $(<./pkgs/tui)
echo "done-----------------------"
echo "AUR:"
# yay (AUR)
pacman -S --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# lazyvim
# required
mv ~/.config/nvim{,.bak}
# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# syncthing service
mkdir -p ~/.config/systemd/user/
cp ./services/syncthing.service ~/.config/systemd/user/syncthing.service
sudo systemctl --user enable syncthing
sudo systemctl --user start syncthing

yay -S bicon-git
yay -S vimv

tldr --update
cp -r ./configs/* ~/.config/

# librewolf setup
# to check wtf
#sudo rm /usr/share/applications/librewolf.desktop
