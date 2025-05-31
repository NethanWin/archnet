#!/bin/bash

UTILS="./utils"
SCRIPTS="./scripts"
CONFIG="$HOME/.config"
COLOR="\e[33m"
RESET="\e[0m"

print_headline() 
{
    echo -e "${COLOR}$1${RESET}"
}

#add pacman stuff
print_headline "0 config pacman"
sudo cp -rf $UTILS/pacman-config/* /etc/
sudo pacman -Syyu


print_headline "1 de chooser"
bash $SCRIPTS/desktop-enviorment-chooser.sh


print_headline "2 install pkgs"
sudo pacman -S --noconfirm --needed ly
sudo systemctl enable ly


######### pkgs #########
# utilities
sudo pacman -S --noconfirm --needed $(<$UTILS/pkgs/utils)
sudo pacman -S --noconfirm --needed $(<$UTILS/pkgs/gui)
sudo pacman -S --noconfirm --needed $(<$UTILS/pkgs/tui)

print_headline "3 moving configs"
cp -r $UTILS/yay $CONFIG


print_headline "4 setting yay aur"
# yay (AUR)
sudo pacman -S --noconfirm --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


print_headline "5 kickstart.nvim"
git clone https://github.com/nvim-lua/kickstart.nvim.git $CONFIG/nvim


print_headline "6 syncthing"
# syncthing service
mkdir -p $CONFIG/systemd/user/
cp $UTILS/syncthing.service $CONFIG/systemd/user/syncthing.service
systemctl --user enable syncthing
systemctl --user start syncthing


print_headline "7 yay install pkgs"
yay bicon-git vimv --noconfirm


print_headline "8 final things"
tldr --update


print_headline "9 zsh setup"
sh -c "$(wget -O- https://install.ohmyz.sh/)"
cp $UTILS/.zshrc $HOME/.zshrc
# chsh -s /usr/bin/zsh
