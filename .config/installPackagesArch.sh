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
  ntfs-3g  # For mounting windows
  gwenview # Visualize images
  network-manager-applet
  networkmanager-openvpn # This is for use PIA confs in openvpn.
  geoclue                # This is for geolocation in hyprland for zen browser.
  #ly # Display Manager
  kitty
  rsync # rsync -av --remove-source-files /ruta/origen/ /ruta/destino/
  #swaylock
  pacman-contrib # For checkupdates module to hyprpanel
  tlp
  tlp-rdw  # tlp para el manejo de compenentes en thinkpad para mejor batería. sudo systemctl enable --now tlp.
  powertop # Para revisar estado de la batería y consumos actuales.
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

# Instalar paquetes desde AUR con yay
aur_packages=(
  # Essential apps for the system
  ags-hyprpanel-git
  hyprshot
  dms-shell-bin
  dsearch-bin
  grimblast
  cliphist

  # Niri WM
  niri                     # This a window manager.
  fuzzel                   # This ir for niri launcher.
  xdg-desktop-portal-gnome # This is for screenshot in niri.
  xwayland-satellite       # This is for xwayland apps in niri.

  tealdeer # This is for documentation on the terminal.
  piavpn-bin
  #epy-ereader-gt # For reading epub files.
  onlyoffice-bin
  zen-browser-bin # microsoft-edge-stable-bin
  #nerd-fonts-git
  ttf-ms-fonts
  otf-apple-fonts
  cmatrix-git # Transparency allow.
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
  #davinci-resolve --asdeps opencl-clover-mesa
  tracktion-waveform

  candy-icons-git # Change the icons in /etc/environment
  arc-gtk-theme   # change in /etc/environment
  bibata-cursor-theme
  apple_cursor
  otf-san-francisco
)

# For /etc/environment
#GTK_THEME=Arc-Dark
#ICON_THEME=candy-icons
# XCURSOR_THEME=Bibata-Modern-Classic
# XCURSOR_SIZE=16
# Para cursores y íconos con este archivo.
# /usr/share/icons/default/index.theme here I change the cursor this the global form to change inherits.
# /usr/share/icons/default/index.theme
# ~/.icons/default/index.theme

for pkg in "${aur_packages[@]}"; do
  yay -Syyu --noconfirm "$pkg"
done

yay -S davinci-resolve opencl-clover-mesa --asdeps

# Esto es para que latex funcione en nvim con LazyVim.
# 1. Instalar dependencias en Arch Linux (ImageMagick + LaTeX)
sudo pacman -S imagemagick texlive texlive-core lazygit fzf
# 2. Instalar Tree-sitter CLI para latex y mermaid-js para graficos mermaid globalmente (con npm)
sudo npm install -g tree-sitter-cli @mermaid-js/mermaid-cli
# 3. Ejecutar en Neovim para instalar el parser de LaTeX
nvim -c "TSInstall latex" -c "q"

# Change shell
sudo chsh -s $(which zsh) juan

# Habilitar servicios
# sudo systemctl enable sddm.service
#sudo systemctl enable ly.service
sudo systemctl docker.service
# Servicio de piavpn-bin linea 110
sudo systemctl enable --now piavpn.service

# Revisar el estado del bluetooth y activar el servicio si no está activo
if ! systemctl is-active --quiet bluetooth.service; then
  echo "Activando el servicio Bluetooth..."
  sudo systemctl start bluetooth.service
  sudo systemctl enable bluetooth.service
fi

# Instalar LazyVim
git clone https://github.com/LazyVim/Starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Change the os-prober
# Habilita os-prober: Asegúrate de que os-prober esté habilitado en la configuración de GRUB.
# Abre el archivo /etc/default/grub con un editor de texto (por ejemplo, sudo vi /etc/default/grub) y busca la línea:
# GRUB_DISABLE_OS_PROBER=true
# Si está configurado como true, cámbialo a false. Si no existe, agrégalo:
# GRUB_DISABLE_OS_PROBER=false
# Guarda el archivo y actualiza la configuración de GRUB:
# sudo grub-mkconfig -o /boot/grub/grub.cfg

# echo "GRUB_DISABLE_OS_PROBER=true" | sudo tee -a /etc/default/grub
# sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Instalación y configuración completada."
