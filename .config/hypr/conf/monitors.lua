---@module 'hl'

-- ==============================================================================
-- PRO ARCHITECTURE: Monitor Geometry & Hardware Mapping
-- Explicit definitions for primary hardware, dynamic rules for external displays.
-- ==============================================================================

-- 1. Primary Laptop Display (eDP-1)
-- Locked strictly to native resolution, maximum refresh rate (144Hz), and origin (0,0).
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144.00000",
    position = "0x0",
    scale    = 1,
})

-- 2. Smart Dynamic Fallback (Any external monitor: HDMI, DP, USB-C)
-- 'highrr' dynamically prioritizes the highest refresh rate available.
-- 'auto' dynamically calculates geometry based on EDID instead of blindly shoving to the right.
hl.monitor({
    output   = "",
    mode     = "highrr",
    position = "auto",
    scale    = 1,
})
