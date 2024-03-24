# dwm
# https://forums.bunsenlabs.org/viewtopic.php?id=7571
# https://www.reddit.com/r/suckless/comments/jj61py/how_do_i_make_dwm_appear_on_my_display_manager/
sudo pacman -Syyu 
sudo pacman -S --noconfirm base-devel git libx11 libxft xorg-server xorg-xinit terminus-font
mkdir -p ~/.local/src 

# clone projects
git clone git://git.suckless.org/st ~/.local/src/st
git clone git://git.suckless.org/dmenu ~/.local/src/dmenu
git clone git://git.suckless.org/dwm ~/.local/src/dwm

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
sudo pacman -S gnome-disk-utility neovim qbittorrent syncthing timeshift virt-manager tldr bluez bluez-utils xclip yt-dlp vlc xterm mpv libreoffice neofetch htop gdu mc nnn zip zoxide cups system-config-printer

# yay (AUR)
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si



# pacman -S iwd
# sudo systemctl start iwd
#iwctl
# station wlan0 get-networks
# station wlan0 connect "oneplus"
