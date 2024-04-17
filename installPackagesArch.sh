#!/bin/bash

# Actualizar la lista de paquetes
sudo pacman -Syyu --noconfirm

# Instalar base-devel si no está instalado
sudo pacman -S --needed base-devel

# Verificar si yay está instalado
if ! command -v yay &> /dev/null; then
    echo "Instalando yay..."
    git clone https://aur.archlinux.org/yay
    cd yay/
    makepkg -si
    cd ..
else
    echo "Yay ya está instalado"
fi

# Paquetes desde repositorios oficiales
sudo pacman -Syyu --noconfirm hyprland kitty sddm wofi waybar dunst swaylock git vim btop bluez bluez-tools bluez-utils pipewire pavucontrol jdk-openjdk python noto-fonts dolphin libreoffice-fresh discord obsidian steam blueman docker

# Paquetes desde AUR con yay
yay_packages=(
    vmware-workstation
    swww
    wlogout
    ttf-ms-fonts
    ttf-font-awesome
    awesome-terminal-fonts
    ttf-cascadia-code
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts-extra
    nerd-fonts-git
    microsoft-edge-stable-bin
    visual-studio-code-bin
    intellij-idea-ultimate-edition
    spotify-adblock-git
    lavat-git
    cava-git
)

for pkg in "${yay_packages[@]}"; do
    yay -Syyu --noconfirm "$pkg"
done

# Habilitar servicios
sudo systemctl enable sddm.service bluetooth.service docker.service

echo "Instalación y configuración completada."
