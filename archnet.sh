# dwm
# https://forums.bunsenlabs.org/viewtopic.php?id=7571
# https://www.reddit.com/r/suckless/comments/jj61py/how_do_i_make_dwm_appear_on_my_display_manager/
sudo pacman -Syyu 
sudo pacman -S base-devel git libx11 libxft xorg-server xorg-xinit terminus-font -y
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

sudo sh -c 'echo "[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession" > /usr/share/xsessions/dwm.desktop'
