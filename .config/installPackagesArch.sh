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

# Paquetes necesarios para hyprland desde una instalación barebone
# hyprland kitty sddm pipewire

# Instalar paquetes desde repositorios oficiales
official_packages=(
	swaylock
	btop
	jdk-openjdk
	python
	noto-fonts
	dolphin
	discord
	obsidian
	steam
	blueman
	git
	nvim
	bluez
	bluez-tools
	bluez-utils
	pavucontrol
	swaync
	wofi
	waybar
	unzip
	cliphist
	starship
	ripgrep
	fd
	ttf-cascadia-code
)

sudo pacman -Syyu --noconfirm "${official_packages[@]}"

# Revisar el estado del bluetooth y activar el servicio si no está activo
if ! systemctl is-active --quiet bluetooth.service; then
	echo "Activando el servicio Bluetooth..."
	sudo systemctl start bluetooth.service
fi

# Instalar LazyVim
git clone https://github.com/LazyVim/Starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Instalar paquetes desde AUR con yay
aur_packages=(
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
	visual-studio-code-bin
	intellij-idea-ultimate-edition
	spotify-adblock-git
)

for pkg in "${aur_packages[@]}"; do
	yay -Syyu --noconfirm "$pkg"
done

# Habilitar servicios
sudo systemctl enable sddm.service bluetooth.service docker.service

echo "Instalación y configuración completada."
