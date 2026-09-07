local M = "SUPER"

local terminal = "kitty"
local fileManager = "thunar"

-- =========================
-- BASIC
-- =========================

hl.bind(M .. " + RETURN", hl.dsp.exec_cmd(terminal))

hl.bind(M .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(M .. " + B", hl.dsp.layout("togglesplit"))
hl.bind(M .. " + W", hl.dsp.window.fullscreen())

hl.bind(M .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(M .. " + Q", hl.dsp.window.close())

hl.bind(M .. " + Z", hl.dsp.exec_cmd("emote"))

hl.bind(M .. " + M", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind(M .. " + U", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))

hl.bind(M .. " + ESCAPE", hl.dsp.exec_cmd("dms ipc call lock lock"))

-- =========================
-- WORKSPACE NAVIGATION
-- =========================

-- I
hl.bind(M .. " + code:31", hl.dsp.focus({ workspace = "e-1" }))

-- O
hl.bind(M .. " + code:32", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(M .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(M .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- =========================
-- WORKSPACES 1-10
-- =========================

for i = 1, 10 do
	local key = i % 10

	hl.bind(M .. " + " .. key, hl.dsp.focus({ workspace = i }))

	hl.bind(M .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- =========================
-- FOCUS MOVEMENT
-- =========================

-- J
hl.bind(M .. " + code:45", hl.dsp.focus({ direction = "left" }))

-- K
hl.bind(M .. " + code:46", hl.dsp.focus({ direction = "right" }))

-- L
hl.bind(M .. " + code:44", hl.dsp.focus({ direction = "up" }))

-- Ñ / ;
hl.bind(M .. " + code:47", hl.dsp.focus({ direction = "down" }))

-- =========================
-- MOVE WINDOWS
-- =========================

hl.bind(M .. " + ALT + code:45", hl.dsp.window.move({ direction = "left" }))

hl.bind(M .. " + ALT + code:46", hl.dsp.window.move({ direction = "right" }))

hl.bind(M .. " + ALT + code:44", hl.dsp.window.move({ direction = "up" }))

hl.bind(M .. " + ALT + code:47", hl.dsp.window.move({ direction = "down" }))

-- =========================
-- SWAP COLUMNS (Mover columnas completas)
-- =========================

-- SHIFT + K -> Intercambiar con derecha
hl.bind(M .. " + SHIFT + code:46", hl.dsp.layout("swapcol r"))

-- SHIFT + L -> Intercambiar con izquierda
hl.bind(M .. " + SHIFT + code:44", hl.dsp.layout("swapcol l"))

-- SHIFT + J -> Intercambiar con izquierda (alternativo)
hl.bind(M .. " + SHIFT + code:45", hl.dsp.layout("swapcol l"))

-- SHIFT + Ñ -> Intercambiar con derecha (alternativo)
hl.bind(M .. " + SHIFT + code:47", hl.dsp.layout("swapcol r"))

-- =========================
-- COLUMN RESIZE (Ajustar columnas)
-- =========================

-- ALT + K -> Crecer columna
hl.bind(M .. " + ALT + code:46", hl.dsp.layout("colresize +conf"))

-- ALT + L -> Encoger columna
hl.bind(M .. " + ALT + code:44", hl.dsp.layout("colresize -conf"))

-- ALT + J -> Encoger columna (alternativo)
hl.bind(M .. " + ALT + code:45", hl.dsp.layout("colresize -conf"))

-- ALT + Ñ -> Crecer columna (alternativo)
hl.bind(M .. " + ALT + code:47", hl.dsp.layout("colresize +conf"))

-- ALT + I -> Ajustar columna activa para que quepa
hl.bind(M .. " + ALT + code:31", hl.dsp.layout("fit active"))

-- ALT + O -> Ajustar TODAS las columnas
hl.bind(M .. " + ALT + code:32", hl.dsp.layout("fit all"))

-- =========================
-- SPECIAL WORKSPACE
-- =========================

hl.bind(M .. " + F", hl.dsp.workspace.toggle_special("magic"))

hl.bind(M .. " + SHIFT + F", hl.dsp.window.move({ workspace = "special:magic" }))

-- =========================
-- MOUSE
-- =========================

hl.bind(M .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(M .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =========================
-- SCREENSHOTS
-- =========================

hl.bind("CTRL + ALT + PRINT", hl.dsp.exec_cmd('HYPRSHOT_DIR="$HOME/Pictures" hyprshot -m window'))

hl.bind("PRINT", hl.dsp.exec_cmd('HYPRSHOT_DIR="$HOME/Pictures" hyprshot -m output'))

hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd('HYPRSHOT_DIR="$HOME/Pictures" hyprshot -m region'))

hl.bind("ALT + PRINT", hl.dsp.exec_cmd('HYPRSHOT_DIR="$HOME/Pictures" hyprshot -m output --clipboard-only'))
