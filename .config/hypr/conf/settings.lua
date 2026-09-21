---@module 'hl'

-- ==============================================================================
-- PRO ARCHITECTURE: General & Aesthetics
-- Highly optimized settings and animation curves.
-- ==============================================================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 3,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = { colors = { primary, on_primary }, angle = 90 },
            inactive_border = on_primary,
        },
    },
})

hl.config({
    decoration = {
        rounding = 8,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 32,
            render_power = 2,
            color = "rgba(00000050)",
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            new_optimizations = true,
            ignore_opacity = true,
            xray = true,
            vibrancy = 0.1696,
        },
    },
})

-- ==============================================================================
-- ANIMATIONS (Pruned and Optimized)
-- ==============================================================================

hl.config({
    animations = {
        enabled = true,
    },
})

-- Strictly used bezier curves only
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidevert" })

-- ==============================================================================
-- MISC & BEHAVIOR
-- ==============================================================================

hl.config({
    dwindle = {
        preserve_split = true,
    },
    binds = {
        workspace_back_and_forth = false,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
        disable_splash_rendering = true,
        initial_workspace_tracking = 1,
        on_focus_under_fullscreen = 1,
        allow_session_lock_restore = true,
    },
    cursor = {
        no_hardware_cursors = true,
    },
})
