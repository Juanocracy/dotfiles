#!/bin/bash

# Actualizar la lista de paquetes
sudo pacman -Syyu --noconfirm

# Instalar base-devel si no está instalado
sudo pacman -S --needed base-devel

# Verificar si yay está instalado
if ! command -v yay &>/dev/null; then
	echo "Instalando yay..."
	git clone https://aur.archlinux.org/yay
	cd yay/
	makepkg -si
	cd ..
  rm -rf yay
else
	echo "Yay ya está instalado"
fi

#Paquetes necesarios desde una instalación barebone
# hyprlan kitty sddm pipewire

# Paquetes desde repositorios oficiales
sudo pacman -Syyu --noconfirm swaylock btop jdk-openjdk python noto-fonts dolphin discord obsidian steam blueman git nvim bluez bluez-tools bluez-utils blueman pavucontrol swaync wofi waybar unzip cliphist starship ripgrep fd

#Revisar el estado del bluetooth
systemctl status bluetooth.service
#Activar el servicio
systemctl start bluetooth.service

#Instalar LazyVim
git clone https://github.com/LazyVim/Starter ~/.config/nvim rm -rf ~/.config/nvim/.git

# Paquetes desde AUR con yay
yay_packages= (
  onlyoffice-bin
  microsoft-edge-stable-bin
  nerd-fonts-git
  ttf-ms-fonts
  lavat-git
  cava-git
  ttf-font-awesome
  awesome-terminal-fonts
  noto-fonts-emoji
  noto-fonts-cjk
  noto-fonts-extra

  vmware-workstation
  swww
  wlogout
  ttf-cascadia-code
  visual-studio-code-bin
  intellij-idea-ultimate-edition
  spotify-adblock-git
  )

  for pkg in "${yay_packages[@]}"; do yay -Syyu --noconfirm "$pkg" done

  # Habilitar servicios
  sudo systemctl enable sddm.service bluetooth.service docker.service
  echo "Instalación y configuración completada."
