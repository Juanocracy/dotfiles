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
  # This is for screensharing in hyprland.
  xdg-desktop-portal-hyprland
  brightnessctl
  #wlsunset # wlsunset -s 18:00 -S 8:30 -t 2500 -T 4000 esto es para la temperatura de la pantalla.
  hyprland
  hyprpaper
  hypridle
  hyprlock
  hyprsunset
  xdg-desktop-portal-wlr
  fastfetch
  network-manager-applet
  ly # Display Manager
  kitty
  rsync # rsync -av --remove-source-files /ruta/origen/ /ruta/destino/
  #swaylock
  vlc
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
  steam         #lib32-amdvlk for amd processor.
  gamescope     # This is a micro compositor for games gamescope -W 1920 -H 1080 -r 60 -- %command% --expose-wayland
  vulkan-radeon # For amd processor api.
  blueman       # Blueman-applet para iniciar en hyprland.
  git
  neovim
  bluez
  bluez-tools
  bluez-utils
  pavucontrol
  #swaync
  wofi
  #waybar
  unzip
  ark
  #cliphist
  starship
  ripgrep
  fd
  ttf-cascadia-code
  calibre
  dotnet-sdk
  #packagekit-qt6 # For installing apps through Discover on plasma
  os-prober #For grub detection.
  npm
  cmatrix
  piper # For configure mouse
  docker
  zellij
  tmux
  #DAW'S
  lmms
  ardour

  #Media Software
  obs-studio
  gimp
  audacity
  darktable

  arc-gtk-theme # change in /etc/environment
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

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Instalar paquetes desde AUR con yay
aur_packages=(
  # Essential apps for the system
  ags-hyprpanel-git
  hyprshot

  oh-my-zsh-git
  piavpn-bin
  #epy-ereader-gt # For reading epub files.
  onlyoffice-bin
  microsoft-edge-stable-bin
  #nerd-fonts-git
  ttf-ms-fonts
  otf-apple-fonts
  lavat-git
  cava
  ttf-font-awesome
  awesome-terminal-fonts
  noto-fonts-emoji
  emote
  noto-fonts-cjk
  noto-fonts-extra
  vmware-workstation
  swww
  #wlogout
  stremio
  visual-studio-code-bin
  intellij-idea-ultimate-edition
  webstorm
  spotify-adblock
  pipes.sh
  vesktop
  teams-for-linux
  notion-app-electron

  # .Net
  rider

  #Media Software
  #davinci-resolve
  tracktion-waveform

  candy-icons-git # Change the icons in /etc/environment
)

for pkg in "${aur_packages[@]}"; do
  yay -Syyu --noconfirm "$pkg"
done

# Install davinci-resolve with opencl-clover-mesa
yay -Syyu davinci-resolve --asdeps opencl-clover-mesa

# Change shell
sudo chsh -s $(which zsh) juan

# Change the os-prober
# Habilita os-prober: Asegúrate de que os-prober esté habilitado en la configuración de GRUB.
# Abre el archivo /etc/default/grub con un editor de texto (por ejemplo, sudo vi /etc/default/grub) y busca la línea:
# GRUB_DISABLE_OS_PROBER=true
# Si está configurado como true, cámbialo a false. Si no existe, agrégalo:
# GRUB_DISABLE_OS_PROBER=false
# Guarda el archivo y actualiza la configuración de GRUB:
# sudo grub-mkconfig -o /boot/grub/grub.cfg
echo "GRUB_DISABLE_OS_PROBER=true" | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg


# Habilitar servicios
sudo systemctl enable sddm.service bluetooth.service docker.service
# Servicio de piavpn-bin linea 110
sudo systemctl enable --now piavpn.service

echo "Instalación y configuración completada."
