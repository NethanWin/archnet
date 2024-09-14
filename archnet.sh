#!/bin/bash

#add pacman stuff
sudo cp -rf ./copy-dirs/etc/* /etc/
sudo pacman -Syyu

echo "1 de chooser------------------------------"
bash ./scripts/desktop-enviorment-chooser.sh

echo "2 install pkgs------------------------------"
sudo pacman -S --noconfirm --needed ly
sudo systemctl enable ly

######### pkgs #########
# utilities
sudo pacman -S --noconfirm --needed $(<./pkgs/utils)
sudo pacman -S --noconfirm --needed $(<./pkgs/gui)
sudo pacman -S --noconfirm --needed $(<./pkgs/tui)

echo "3 moving configs------------------------------"
cp -r ./configs/* ~/.config/

echo "4 setting yay aur-----------------------------"
# yay (AUR)
sudo pacman -S --noconfirm --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "5 lazyvim-----------------------------"
# lazyvim
# required
mv ~/.config/nvim{,.bak}
# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "6 syncthing-----------------------------"
# syncthing service
mkdir -p ~/.config/systemd/user/
cp ./services/syncthing.service ~/.config/systemd/user/syncthing.service
systemctl --user enable syncthing
systemctl --user start syncthing

echo "7 yay install pkgs-----------------------------"
yay -S bicon-git
yay -S vimv

echo "8 final things-------------------------------------"
tldr --update

echo "9 fish setup---------------------------------"
rm -rf ~/.config/fish
git clone -b dev https://github.com/NethanWin/shellnet ~/.config/fish
bash ~/.config/fish/install.sh
chsh -s /usr/bin/fish
