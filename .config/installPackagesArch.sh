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
	fastfetch
	swaylock
	btop
	jdk-openjdk
	python
	noto-fonts
	zsh # Command terminal is fundamental to configure the shell and the framework with the promp.
	zellij
	thunar #dolphin
	thunderbird
	discord
	obsidian
	#steam
	blueman
	git
	neovim
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
	dotnet-sdk

	#Media Software
	obs-studio
	gimp
	audacity
	darktable
)

# Iterar sobre la lista de paquetes e intentar instalar cada uno
for pkg in "${official_packages[@]}"; do
	echo "Instalando $pkg..."
	sudo pacman -S --noconfirm "$pkg"
	if [ $? -ne 0 ]; then
		echo "Error al instalar $pkg. Abortando."
		exit 1
	fi
done

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
	#nerd-fonts-git
	ttf-ms-fonts
	lavat-git
	cava-git
	ttf-font-awesome
	awesome-terminal-fonts
	noto-fonts-emoji
	emote
	noto-fonts-cjk
	noto-fonts-extra
	vmware-workstation
	swww
	wlogout
	visual-studio-code-bin
	intellij-idea-ultimate-edition
	spotify-adblock-git

	# .Net
	rider

	#Media Software
	davinci-resolve
)

for pkg in "${aur_packages[@]}"; do
	yay -Syyu --noconfirm "$pkg"
done

# Habilitar servicios
sudo systemctl enable sddm.service bluetooth.service docker.service

echo "Instalación y configuración completada."
