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
# utilities
sudo pacman -S zip unzip reflector upower tldr bluez bluez-utils xclip yt-dlp zoxide fastfetch cups
# gui
sudo pacman -S qutebrowser gnome-disk-utility neovim qbittorrent syncthing timeshift virt-manager vlc libreoffice system-config-printer
# tui
sudo pacman -S mpv dua-cli btop mc

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

# to add:
# auto usb mount to /run/media/
# android-tools
# auto-cpufreq
# bluetooth setup
# breeze
# btop
# calc
# cups
# dash
# dua-cli
# duf
# fastfetch
# feh
# ffmpeg
# fish
# fzf
# git
# go
# hyprland
# hyprlock
# hyprfine
# hyprpaper
# imagemagick
# iwd
# kdenlive
# kolourpaint
# konsole
# mc
# ly
# mc
# mpv
# neovim
# newsboat
# npm
# nvidia-driver
# obsidian
# tmux
# zoxide
# zip
# zathura???
# yt-dlp
# youtube-dl
# yay
# wofi
# wl-clipboard??
# wine
# waybar
# vlc
# virt-manager setup
# usb-modeswitch
# unzip
# unrar
# rar
# ttf-jetbrains-mono-nerd
# ttf-ubuntu-mono-nerd
# tlp?
# timeshift
# tldr
# run tldr --update
# tilix?
# syncthing
# sxiv
# speedtest-cli
# slurp??
# samba??
# reglector?
# qutebrowser
# librewolf
# rustup
# qt5ct??
# qt6ct??
# qbittorrent
# p7zip
# pacutils
# pamixer
# pavucontrol?
# pipewire??
# print-manager??
# pulseaudio??
# python-adblock
# python-pip
# python-pipx
#
#
#
# mirrors with reflector like the next but with israeli and up to date servers
# sudo reflector --country Israel --latest 5 --age 2 --sort rate --save /etc/pacman.d/mirrorlist
