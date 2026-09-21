---@module 'hl'

local mainMod = "SUPER"

-- ==============================================
-- AI-NATIVE PRO SHORTCUTS
-- All bindings are DRY and direct (no wrapper scripts)
-- ==============================================

-- 1. Essential Apps (Toggles included)
hl.bind(mainMod .. " + " .. "W", hl.dsp.exec_cmd("pkill -x waypaper || waypaper"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "W", hl.dsp.exec_cmd("waypaper --random"))
hl.bind(mainMod .. " + " .. "RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd("nautilus"))

-- Launcher Toggle (Press once to open, press again to close)
hl.bind(mainMod .. " + " .. "SPACE", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))

-- Clipboard Manager Toggle (Uses wofi to display history)
hl.bind(mainMod .. " + " .. "V", hl.dsp.exec_cmd("pkill rofi || cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Color Picker (Copies hex code to clipboard instantly)
hl.bind(mainMod .. " + " .. "C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Notification Center Toggle
hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- 2. Window Management (Focus, Move, Resize)
hl.bind(mainMod .. " + " .. "Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + " .. "T", hl.dsp.window.float())
hl.bind(mainMod .. " + " .. "J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + " .. "K", hl.dsp.layout("swapsplit"))

-- VIM-style and Arrow Keys for Focus
hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }))

-- Window Moving (SHIFT + Arrows)
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "left", hl.dsp.exec_cmd("hyprctl dispatch movewindow l"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "right", hl.dsp.exec_cmd("hyprctl dispatch movewindow r"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "up", hl.dsp.exec_cmd("hyprctl dispatch movewindow u"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "down", hl.dsp.exec_cmd("hyprctl dispatch movewindow d"))

-- Window Resizing (CTRL + Arrows)
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))

-- 3. System & UI Controls
hl.bind(mainMod .. " + " .. "D", hl.dsp.exec_cmd("~/.config/hypr/scripts/show_desktop.sh"))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + " .. "L", hl.dsp.exec_cmd("~/.config/hypr/scripts/lock.sh"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "B", hl.dsp.exec_cmd("systemctl --user restart waybar"))
hl.bind(mainMod .. " + " .. "ALT" .. " + " .. "B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + " .. "ESCAPE", hl.dsp.exec_cmd("pkill -x wlogout || wlogout"))

-- Screenshots (Direct pipeline to clipboard, no temp files)
hl.bind(mainMod .. " + " .. "PRINT", hl.dsp.exec_cmd("bash -c 'grim - | wl-copy && notify-send \"📸 Screenshot\" \"Butun ekran xotiraga olindi!\" -t 3000'"))
hl.bind(mainMod .. " + " .. "ALT" .. " + " .. "S", hl.dsp.exec_cmd("bash -c 'grim -g \"$(slurp)\" - | wl-copy && notify-send \"✂️ Screenshot\" \"Qirqib olingan joy xotiraga olindi!\" -t 3000'"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "S", hl.dsp.exec_cmd('~/.config/hypr/scripts/screenshot.sh'))

-- 4. Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. tostring(i), hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. tostring(i), hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Special Workspace (Scratchpad for quick notes/terminals)
hl.bind(mainMod .. " + " .. "S", hl.dsp.workspace.toggle_special("scratchpad"))
-- hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special:scratchpad" }))

-- 5. Mouse Interaction
hl.bind(mainMod .. " + " .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + " .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- 6. Hardware / Multimedia Keys (Works even when screen is locked!)
--    Note: volume.sh and brightness.sh handle BOTH the action and the OSD
--    notification in a single atomic script — no duplicate logic here.
local NOTIFY = os.getenv("HOME") .. "/.config/hypr/scripts/notify"

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(NOTIFY .. "/volume.sh up"),     { locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(NOTIFY .. "/volume.sh down"),   { locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(NOTIFY .. "/volume.sh mute"),   { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(NOTIFY .. "/brightness.sh up"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(NOTIFY .. "/brightness.sh down"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Alt-Tab (Cycle Windows)
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top())
