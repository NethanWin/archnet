#!/bin/bash
bash desktop-enviorment-chooser.sh
# utilities
sudo pacman -S --noconfirm --needed zip unzip rar unrar reflector upower tldr bluez bluez-utils xclip yt-dlp zoxide fastfetch cups speedtest-cli calc dash duf feh ffmpeg fish fzf go starship
# gui
sudo pacman -S --noconfirm --needed qutebrowser gnome-disk-utility neovim qbittorrent syncthing timeshift virt-manager vlc libreoffice system-config-printer
# tui
sudo pacman -S --noconfirm --needed mpv dua-cli btop mc newsboat
# background pkgs
sudo pacman -S --noconfirm --needed usb-modeswitch ttf-jetbrains-mono-nerd

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
cat <<EOF >~/.config/systemd/user/syncthing.service
[Unit]
Description=Syncthing - Open Source Continuous File Synchronization
Documentation=https://docs.syncthing.net/
After=network.target

[Service]
ExecStart=/usr/bin/syncthing -no-browser -no-restart -logflags=0
Restart=on-failure
SuccessExitStatus=3 4
RestartForceExitStatus=3 4

[Install]
WantedBy=default.target
EOF

sudo systemctl --user enable syncthing
sudo systemctl --user start syncthing

yay -S bicon-git

tldr --update

# librewolf setup
sudo rm /usr/share/applications/librewolf.desktop
