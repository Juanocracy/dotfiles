#!/bin/bash
#
# Script de ejecución optimizado para Steam + Gamescope
# Compatible con GPUs integradas y dedicadas
# Juan, 2025
#
# Nota: úsalo en Steam en Opciones de lanzamiento:
# ~/steam-launch.sh %command%

sleep 2

# ============================
# Ajustes generales de Proton/DXVK
# ============================
export DXVK_ASYNC=1
export DXVK_HUD=0
export PROTON_NO_ESYNC=1
export PROTON_NO_FSYNC=1
export PROTON_USE_WINED3D=0
export vblank_mode=0
export MANGOHUD=1
export MANGOHUD_CONFIG="font_size=10"

# ============================
# Escalado FSR (AMD/Intel/NVIDIA)
# ============================
export PROTON_FSR=1
export WINE_FULLSCREEN_FSR=1
export WINE_FULLSCREEN_FSR_CUSTOM_MODE=1280x720 # resolución interna para escalar
export RADV_FORCE_FSR=1

# ============================
# Detección automática de GPU
# ============================
GPU_VENDOR=$(lspci | grep -E "VGA|3D" | grep -iE "amd|nvidia|intel" || true)

if echo "$GPU_VENDOR" | grep -qi "nvidia"; then
  echo "[INFO] GPU detectada: NVIDIA"
  export __GL_THREADED_OPTIMIZATIONS=1
  export __GL_GSYNC_ALLOWED=0
  export __GL_VRR_ALLOWED=0

elif echo "$GPU_VENDOR" | grep -qi "amd"; then
  echo "[INFO] GPU detectada: AMD"
  export RADV_PERFTEST=gpl
  export AMD_DEBUG=nogpufaults
  export mesa_glthread=true # <-- activado para AMD (mejora en Mesa)

elif echo "$GPU_VENDOR" | grep -qi "intel"; then
  echo "[INFO] GPU detectada: Intel"
  export MESA_GL_VERSION_OVERRIDE=4.6
  export MESA_GLSL_VERSION_OVERRIDE=460
  export mesa_glthread=true # <-- activado para Intel (mejora en Mesa)

else
  echo "[WARN] No se detectó GPU (o lspci no devolvió nada). Usando configuración por defecto."
fi

# ============================
# Detección del juego (por nombre del comando)
# ============================
GAME_NAME=$(echo "$@" | tr '[:upper:]' '[:lower:]')

if echo "$GAME_NAME" | grep -qE "mortal|tekken"; then
  echo "[INFO] Juego detectado: $GAME_NAME (modo rendimiento 1280x720 → 1920x1080)"
  INTERNAL_W=1280
  INTERNAL_H=720
  OUTPUT_W=1920
  OUTPUT_H=1080
else
  echo "[INFO] Juego detectado: $GAME_NAME (modo nativo 1920x1080)"
  INTERNAL_W=1920
  INTERNAL_H=1080
  OUTPUT_W=1920
  OUTPUT_H=1080
fi

# ============================
# Lanzamiento con Gamescope + MangoHud + GameMode
# ============================
exec gamescope --backend auto \
  -W "$OUTPUT_W" -H "$OUTPUT_H" \
  -w "$INTERNAL_W" -h "$INTERNAL_H" \
  --fullscreen \
  --force-grab-cursor \
  -- mangohud gamemoderun "$@"
