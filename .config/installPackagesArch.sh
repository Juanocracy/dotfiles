#!/bin/bash

# Actualizar la lista de paquetes
sudo pacman -Syyu --noconfirm

echo "Instalar base-devel."
sudo pacman -S --needed base-devel

# Instalar yay (AUR Helper) si no está instalado
if ! command -v yay &> /dev/null; then
    echo "Instalando yay..."
    cd
    git clone https://aur.archlinux.org/yay
    cd yay/
    makepkg -si
    cd
else
    echo "Yay ya esta instalado"
fi

# Instalar paquetes desde los repositorios oficiales
sudo pacman -Syyu --noconfirm hyprland kitty sddm wofi waybar dunst swaylock git vim btop bluez bluez-tools bluez-utils pipewire pavucontrol jdk-openjdk python noto-fonts dolphin libreoffice-fresh discord obsidian steam blueman docker

# Instalar paquetes desde AUR con yay
#yay -Syyu --noconfirm onlyoffice-bin
yay -Syyu --noconfirm vmware-workstation
yay -Syyu --noconfirm swww
yay -Syyu --noconfirm wlogout
yay -Syyu --noconfirm ttf-ms-fonts
yay -Syyu --noconfirm ttf-font-awesome
yay -Syyu --noconfirm awesome-terminal-fonts
yay -Syyu --noconfirm ttf-cascadia-code
yay -Syyu --noconfirm noto-fonts-emoji
yay -Syyu --noconfirm noto-fonts-cjk
yay -Syyu --noconfirm noto-fonts-extra
yay -Syyu --noconfirm nerd-fonts-git
yay -Syyu --noconfirm microsoft-edge-stable-bin
yay -Syyu --noconfirm visual-studio-code-bin
yay -Syyu --noconfirm intellij-idea-ultimate-edition
yay -Syyu --noconfirm spotify-adblock-git
yay -Syyu --noconfirm lavat-git
yay -Syyu --noconfirm cava-git

# Habilitar servicios
sudo systemctl enable sddm.service
sudo systemctl enable bluetooth.service
sudo systemctl enable docker.service

echo "Instalación y configuracion completada."
