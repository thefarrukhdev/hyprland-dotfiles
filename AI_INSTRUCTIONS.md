# AI Setup Guide for Farrukh's System

Hello AI Assistant (e.g., Agy CLI)! If the user asks you to "set up my system" or "install my dotfiles", please read and carefully execute the following system provisioning steps autonomously.

## 1. Package Installation
You must install the following essential packages using the `pacman` package manager:
`hyprland waybar kitty rofi swaync cliphist grim slurp wl-clipboard hyprlock hypridle brightnessctl playerctl starship polkit-gnome xdg-desktop-portal-hyprland zsh zsh-autosuggestions zsh-syntax-highlighting ttf-firacode-nerd ttf-jetbrains-mono-nerd git`

## 2. AUR Helper & Developer Tools
If the `yay` command is not available, clone it from `https://aur.archlinux.org/yay-bin.git` and install it.
Once `yay` is available, use it to install the following developer tools:
`google-chrome visual-studio-code-bin waypaper sddm`

## 3. Configuration Deployment (Dotfiles)
The current directory contains the user's custom configuration.
- Recursively copy all contents of the `.config` folder in this repository to the user's `~/.config/` directory.
- Copy the `.zshrc` file to the user's `~/` directory.

## 4. System Services
Enable the following `systemd` services so they start automatically:
- `bluetooth`
- `NetworkManager`
- `sddm`

## 5. Shell Configuration
Ensure that the user's default shell is changed to `zsh`.

**Execution Rules:** 
Do not ask the user for manual intervention. Use your tool execution capabilities to perform these steps automatically. You may ask the user for their `sudo` password if required.
