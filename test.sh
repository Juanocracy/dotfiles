#!/bin/bash
# ================================================
# Script de lanzamiento optimizado para Steam/Proton en AMD
# con FSR, Gamescope y mejoras de rendimiento.
# ================================================

# Esperar para dar tiempo a que levante el entorno gráfico (Steam, etc.)
sleep 2

# ==== 1. Escalado FSR a nivel de Proton/Wine ====
export PROTON_FSR=1                             # Habilitar FSR en juegos de Proton
export WINE_FULLSCREEN_FSR=1                    # Habilitar FSR en modo fullscreen
export WINE_FULLSCREEN_FSR_CUSTOM_MODE=1280x720 # Resolución interna para FSR
export RADV_FORCE_FSR=1                         # Forzar FSR a nivel de driver

# ==== 2. Mejoras en Vulkan/DXVK para AMD ====
export PROTON_USE_WINED3D=0  # Usar DXVK/Vulkan (más rápido que Wined3D)
export RADV_PERFTEST=gpl     # Usar Graphics Pipeline Library para menos stutter
export mesa_glthread=true    # Multi-hilo para OpenGL/Mesa (AMD/Intel)
export DXVK_ASYNC=1          # Compilación asíncrona de shaders (ProtonGE recomendado)
export vblank_mode=0         # Desactiva V-Sync para menos input lag (puede causar tearing)
export AMD_DEBUG=nogpufaults # Evita crasheos por errores de GPU

# ==== 3. Overlay y monitoreo ====
export MANGOHUD=1 # Habilitar MangoHud
export DXVK_HUD=0 # Evitar HUD doble con MangoHud

# ==== 4. Lanzar con Gamescope ====
# -W / -H = resolución final (pantalla)
# -w / -h = resolución interna del juego (más baja para rendimiento)
# --filter fsr = escalado de imagen con FSR

exec gamescope --backend auto \
  -W 1920 -H 1080 \
  -w 1280 -h 720 \
  --scaler auto \
  --filter fsr \
  -- mangohud gamemoderun "$@"
