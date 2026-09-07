hl.on("hyprland.start", function()
	local exec = hl.exec_cmd

	exec("systemctl --user start hyprpolkitagent")
	exec("/usr/lib/geoclue-2.0/demos/agent")
	exec("nm-applet")
	exec("dms run")
	exec("privateinternetaccess")
	exec("wl-paste --watch cliphist store &")

	exec("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	exec("[workspace special:magic silent] notion-app")
	exec("[workspace special:magic silent] pear-desktop")

	exec("[workspace 1 silent] zen-browser")
	exec("[workspace 2 silent] kitty --session ~/.config/kitty/nvim.conf")

	exec("[workspace 3 silent] discord")
	exec("[workspace 3 silent] steam")

	exec("[workspace 4 silent] kitty zellij --layout ~/.config/zellij/juan.kdl")
end)
