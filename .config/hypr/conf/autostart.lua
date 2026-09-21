---@module 'hl'

hl.on("hyprland.start", function()
    -- 1. Setup environment
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland xdg-desktop-portal")
    
    -- 2. Core daemons & Instant UI Restore
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    
    -- VERY FAST WALLPAPER (using awww-daemon's built-in cache)
    hl.exec_cmd("~/.local/bin/awww-daemon &")
    
    -- LAUNCH WAYBAR
    hl.exec_cmd("systemctl --user restart waybar")
    
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    
    -- Notification daemons (battery + media track changes)
    hl.exec_cmd("systemctl --user restart battery-notify.service")
    hl.exec_cmd("systemctl --user restart media-notify.service")
    
    -- 3. RGB restore (backgrounded to prevent blocking)
    hl.exec_cmd("bash -c 'sleep 2 && ~/.local/bin/rgb-panel --restore &'")
    
    -- 4. Cliphist
    hl.exec_cmd("env CLIPHIST_MAX_ITEMS=50 wl-paste --type text --watch cliphist store")
    hl.exec_cmd("env CLIPHIST_MAX_ITEMS=50 wl-paste --type image --watch cliphist store")
    
    -- 5. Startup Apps
    hl.exec_cmd("kitty")
end)
