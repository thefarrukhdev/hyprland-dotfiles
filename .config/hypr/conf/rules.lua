---@module 'hl'

-- Fallback to standard config string mapping since hl.layer_rule API is ambiguous
hl.config({
    layerrule = {
        "blur, waybar",
        "ignorezero, waybar",
        "blur, wofi",
        "ignorealpha 0.2, wofi",
        "blur, rofi",
        "ignorealpha 0.2, rofi",
        "blur, notifications",
        "ignorealpha 0.2, notifications",
        "blur, mako",
        "ignorealpha 0.2, mako",
        "blur, swaync-control-center",
        "ignorealpha 0.2, swaync-control-center"
    }
})

-- ==============================================
-- WINDOW RULES (UI/UX Workflows)
-- ==============================================

-- 1. Modals & Popups
hl.window_rule({
    match = { title = "Open File" },
    float = true,
    center = true,
})
hl.window_rule({
    match = { title = "Open Folder" },
    float = true,
    center = true,
})
hl.window_rule({
    match = { title = "Save As" },
    float = true,
    center = true,
})

-- 2. System Utilities
local utils = { "pavucontrol", "blueman-manager", "nm-connection-editor", "nwg-look", "qalculate-gtk" }
for _, cls in ipairs(utils) do
    hl.window_rule({
        match = { class = cls },
        float = true,
        center = true,
        size = "800 600",
    })
end

-- 3. Picture-in-Picture (PiP)
hl.window_rule({
    match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float = true,
    pin = true,
})

-- 4. Waypaper & Settings
local settings_apps = { "waypaper", "com.ml4w.dotfilessettings" }
for _, cls in ipairs(settings_apps) do
    hl.window_rule({
        match = { class = cls },
        float = true,
        center = true,
    })
end
