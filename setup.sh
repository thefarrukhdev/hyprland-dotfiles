#!/usr/bin/env bash
echo "🚀 Farrukhning Hyprland Tizimi O'rnatilmoqda..."

# 1. Asosiy dasturlarni o'rnatish
chmod +x ./install_packages.sh
./install_packages.sh

# 2. Yay (AUR Helper) ni o'rnatish
if ! command -v yay &> /dev/null; then
    echo "📦 Yay (AUR) o'rnatilmoqda..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin && makepkg -si --noconfirm
    cd -
fi

# 3. Dasturchi asboblari va AUR dasturlari (Chrome, VSCode, Waypaper)
echo "💻 Dasturchi asboblari o'rnatilmoqda..."
yay -S --needed --noconfirm google-chrome visual-studio-code-bin waypaper sddm

# 4. Konfiguratsiyalarni (Dotfiles) tizimga ko'chirish
echo "📂 Sozlamalar nusxalanmoqda..."
mkdir -p ~/.config
cp -r .config/* ~/.config/
cp .zshrc ~/.zshrc

# 5. Xizmatlarni (Services) avtomatik yoqish
echo "⚙️ Xizmatlar ishga tushirilmoqda..."
sudo systemctl enable --now bluetooth
sudo systemctl enable --now NetworkManager
sudo systemctl enable sddm

# 6. Zsh ni standart qobiq qilish
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo "🐚 Zsh standart qobiqqa o'zgartirilmoqda..."
    chsh -s /usr/bin/zsh
fi

echo "✅ Barcha ishlar muvaffaqiyatli yakunlandi! Kompyuterni o'chirib yoqishingiz (Reboot) mumkin!"
