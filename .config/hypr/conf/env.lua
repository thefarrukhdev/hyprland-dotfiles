---@module 'hl'

-- ==============================================================================
-- PRO ARCHITECTURE: Environment Variables
-- Stripped down to the bare essentials for Wayland + NVIDIA.
-- Redundant XDG vars and legacy OpenGL/Vulkan fallbacks have been eliminated.
-- ==============================================================================

-- Core NVIDIA Hardware Acceleration (DISABLED for Battery/Cooling)
-- WARNING: Enabling these forces all apps to use the dedicated GPU, causing 
-- 20W+ idle power draw and loud fans (4700 RPM).
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Wayland Toolkit Enforcers
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- Electron / Chromium Native Wayland Support
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
