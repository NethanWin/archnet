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
      echo "installing Hyprland..."
      git clone https://github.com/NethanWin/hyprnet.git
      cd hyprnet
      ./install.sh
      cd ..
      ;;
    "kde")
      echo "installing KDE..."
      sudo pacman -S --needed --noconfirm plasma-desktop
      ;;
    "dwm")
      echo "installing dwm..."
      git clone https://github.com/NethanWin/dwm.git
      cd dwm
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
