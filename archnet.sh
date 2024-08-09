#!/bin/bash

sudo pacman -S git
#install desktop environments
options=("hyprland" "kde" "dwm")
selected=()
display_menu() {
  echo "Select desktop environments:"
  for i in "${!options[@]}"; do
    printf "%d) %s\n" $((i + 1)) "${options[i]}"
  done
  echo "Enter your choices: (default=None)"
}
install_selected() {
  for choice in "${selected[@]}"; do
    case $choice in
    "hyprland")
      echo "Installing Hyprland..."
      git clone git@github.com:NethanWin/hyprnet.git
      cd hyprnet
      chmod +x install.sh
      ./install.sh
      cd ..
      ;;
    "kde")
      echo "Installing KDE..."
      sudo pacman -S --needed --noconfirm plasma-wayland-session plasma-desktop
      ;;
    "dwm")
      echo "Installing dwm..."
      git clone git@github.com:NethanWin/dwm.git
      cd dwm
      chmod +x install.sh
      ./install.sh
      cd ..
      ;;
    esac
  done
}
display_menu
read -a choices

# Process choices
for choice in "${choices[@]}"; do
  if [[ "$choice" =~ ^[1-3]$ ]]; then
    index=$((choice - 1))
    selected+=("${options[index]}")
  fi
done

install_selected

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
