-- Add Waybar - custom taskbar for hyprland
hl.exec_cmd("pkill -x waybar || true; waybar")
hl.exec_cmd("waybar")

-- Add swayosd-server - custom daemon to show graphically volume and brightness changes
hl.exec_cmd("pkill -x swayosd-server || true; swayosd-server")

-- Add swaync - custom notifications daemon
hl.exec_cmd("pkill -x swaync || true; swaync")

-- Add wallpaper (boot + reload)
hl.on("hyprland.start", function()
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar")
	hl.exec_cmd(
		'killall swaybg 2>/dev/null; swaybg -o "*" -i /usr/share/wallpapers/fili-wallpapers/black-waves-wallpaper.jpg -m fill'
	)
end)
