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
