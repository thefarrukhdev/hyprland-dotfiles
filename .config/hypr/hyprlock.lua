---@module 'hl'

-- Parse pywal colors directly from json
local function load_pywal_colors(filepath)
    local f = io.open(filepath, "r")
    if not f then return false, nil end
    local content = f:read("*a")
    f:close()
    
    local loaded = false
    for key, hex in content:gmatch('"([^"]+)":%s*"#(%x+)"') do
        if #hex == 6 then
            _G[key] = "rgba(" .. hex .. "ff)"
            loaded = true
        end
    end
    
    local wallpaper = content:match('"wallpaper":%s*"([^"]+)"')
    return loaded, wallpaper
end

local has_wal, wp_path = load_pywal_colors(os.getenv("HOME") .. "/.cache/wal/colors.json")

_G.primary = _G.color10 or "rgba(b1c5ffff)"
_G.on_primary = _G.color0 or "rgba(172e60ff)"
_G.error = _G.color1 or "rgba(ffb4abff)"
_G.shadow = "rgba(000000ff)"
local wp = wp_path or (os.getenv("HOME") .. "/Pictures/wallpapers/default.jpg")

hl.config({
    general = {
        ignore_empty_input = true,
    },
})

hl.config({
    background = {
        path = wp,
        blur_passes = 2,
        blur_size = 7,
    },
})

hl.config({
    ["input-field"] = {
        size = { 200, 50 },
        dots_size = 0.33,
        dots_spacing = 0.15,
        dots_center = true,
        dots_rounding = -1,
        inner_color = primary,
        font_color = on_primary,
        font_family = "Fira Semibold",
        outer_color = on_primary,
        outline_thickness = 3,
        fade_on_empty = true,
        fade_timeout = 1000,
        placeholder_text = "<i>Input Password...</i>",
        hide_input = false,
        rounding = 10,
        check_color = primary,
        fail_color = error,
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>",
        capslock_color = -1,
        numlock_color = -1,
        bothlock_color = -1,
        invert_numlock = false,
        swap_font_color = false,
        position = { 0, -20 },
        halign = "center",
        valign = "center",
        shadow_passes = 10,
        shadow_size = 20,
        shadow_color = shadow,
        shadow_boost = 1.6,
    },
})

hl.config({
    label = {
        text = "$TIME",
        color = primary,
        font_size = 70,
        font_family = "Fira Sans Semibold",
        position = { -50, 20 },
        halign = "right",
        valign = "bottom",
        shadow_passes = 5,
        shadow_size = 10,
    },
})

hl.config({
    label = {
        text = "$USER",
        color = primary,
        font_size = 20,
        font_family = "Fira Sans Semibold",
        position = { -50, 120 },
        halign = "right",
        valign = "bottom",
        shadow_passes = 5,
        shadow_size = 10,
    },
})
