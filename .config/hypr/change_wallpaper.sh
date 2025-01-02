#!/bin/bash

# Obtén el nombre del usuario actual
USER=$(whoami)

# Define el directorio de wallpapers basado en el usuario actual
WALLPAPER_DIRECTORY="/home/$USER/.config/wallpapers/"

# Selecciona un wallpaper aleatorio del directorio
WALLPAPER=$(find "$WALLPAPER_DIRECTORY" -type f | shuf -n 1)

# Genera el contenido para hyprpaper.conf
cat <<EOL >/home/$USER/.config/hypr/hyprpaper.conf
preload = $WALLPAPER
wallpaper = eDP-1,$WALLPAPER
wallpaper = HDMI-A-1,$WALLPAPER
wallpaper = HDMI-A-2,$WALLPAPER
EOL

# Inicia hyprpaper si no está en ejecución
if ! pgrep -x "hyprpaper" >/dev/null; then
  hyprpaper &
else
  # Aplica el wallpaper con hyprpaper
  hyprctl hyprpaper preload "$WALLPAPER"
  hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"
  hyprctl hyprpaper wallpaper "HDMI-A-1,$WALLPAPER"
  hyprctl hyprpaper wallpaper "HDMI-A-2,$WALLPAPER"

  # Espera un momento antes de descargar wallpapers no utilizados
  sleep 1

  # Descarga wallpapers no utilizados para liberar recursos
  hyprctl hyprpaper unload unused
fi
