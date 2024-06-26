# dwm
# https://forums.bunsenlabs.org/viewtopic.php?id=7571
# https://www.reddit.com/r/suckless/comments/jj61py/how_do_i_make_dwm_appear_on_my_display_manager/
sudo pacman -Syyu
sudo pacman -S --noconfirm base-devel git libx11 libxft xorg-server xorg-xinit terminus-font
mkdir -p ~/.local/src

# clone projects
git clone https://github.com/NethanWin/st.git ~/.local/src/st
git clone https://github.com/NethanWin/dwm.git ~/.local/src/dwm
git clone https://github.com/NethanWin/dmenu.git ~/.local/src/dmenu
git clone https://github.com/NethanWin/dwmblocks.git ~/.local/src/dwmblocks

# st
cd ~/.local/src/st
make clean
sudo make install

# dmenu
cd ~/.local/src/dmenu

sed -i 's/^XINERAMALIBS/# XINERAMALIBS  = -lXinerama/' config.mk
sed -i 's/^XINERAMAFLAGS/# XINERAMAFLAGS = -DXINERAMA/' config.mk

make clean
sudo make install

# dwm
cd ~/.local/src/dwm
sed -i 's/^XINERAMALIBS/# XINERAMALIBS  = -lXinerama/' config.mk
sed -i 's/^XINERAMAFLAGS/# XINERAMAFLAGS = -DXINERAMA/' config.mk
make clean
sudo make install

# lightdm greeter
sudo pacman -S lighdm lightdm-gtk-greeter
sudo systemctl enable lightdm
sudo systemctl start lightdm

# virt-manager
#sudo systemctl start libvirtd

sudo mkdir /usr/share/xsessions
sudo touch /use/share/xsessions/dwm.desktop

sudo sh -c 'echo "[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession" > /usr/share/xsessions/dwm.desktop'

# just some pkgs
sudo pacman -S unzip qutebrowser reflector upower gnome-disk-utility neovim qbittorrent syncthing timeshift virt-manager tldr bluez bluez-utils xclip yt-dlp vlc xterm mpv libreoffice neofetch htop gdu mc nnn zip zoxide cups system-config-printer

# yay (AUR)
pacman -S --needed git base-devel
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

#pacman mirrors
sudo reflector --country Israel --latest 5 --age 2 --sort rate --save /etc/pacman.d/mirrorlist

# pacman -S iwd
# sudo systemctl start iwd
#iwctl
# station wlan0 get-networks
# station wlan0 connect "oneplus"
