# 🚀 Awesome Hyprland Modular Dotfiles

Welcome to my personal, highly optimized, and **Component-Driven** [Hyprland](https://hyprland.org/) configuration.

## 🏗️ Architecture
This configuration is built with a Senior Engineering "Infrastructure as Code" approach. The monolithic `hyprland.conf` has been broken down into a strict, modular dependency graph:

*   `envs.conf` — Environment Variables & Toolkit settings
*   `monitors.conf` — Multi-monitor definitions and workspace mapping
*   `autostart.conf` — System daemons and polkit agents
*   `look_feel.conf` — UI/UX, Borders, Window Gaps, and Layouts
*   `animations.conf` — Custom Bezier curves and smooth transitions
*   `keybinds.conf` — Keybindings, submaps, and media controls
*   `windowrules.conf` — V2 Window/Layer rules for blurs and opacity

## ✨ Features
- **Zero Overhead**: Fully audited for deprecations and legacy bloat.
- **Dynamic Theming**: Integrated with ML4W Dotfiles framework.
- **Ghostty / Kitty Ready**: Pre-configured for GPU-accelerated terminal workflows.

---
*Maintained by FarrukhDev-io*
