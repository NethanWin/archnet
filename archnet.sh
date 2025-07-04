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
sudo pacman -S --noconfirm --needed $(cat $UTILS/pkgs/*)

print_headline "3 moving configs"
cp -r $UTILS/yay $CONFIG


print_headline "4 setting yay aur"
# yay (AUR)
sudo pacman -S --noconfirm --needed base-devel
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si --noconfirm
popd
rm -rf yay


print_headline "5 kickstart.nvim"
git clone https://github.com/nvim-lua/kickstart.nvim.git $CONFIG/nvim


print_headline "6 syncthing"
# syncthing service
mkdir -p $CONFIG/systemd/user/
cp $UTILS/syncthing.service $CONFIG/systemd/user/syncthing.service
systemctl --user enable syncthing
systemctl --user start syncthing


print_headline "7 yay install pkgs"
yay -S bicon-git vimv --noconfirm


print_headline "8 final things"
tldr --update


print_headline "9 zsh setup"
sh -c "$(wget -O- https://install.ohmyz.sh/)" "" --unattended

cp $UTILS/.zshrc $HOME/.zshrc
cp -r $UTILS/.oh-my-zsh $HOME/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

chsh -s /usr/bin/zsh