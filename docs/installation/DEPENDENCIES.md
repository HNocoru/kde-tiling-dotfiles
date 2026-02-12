# 📦 Dependencies

This document lists all required and optional dependencies for the KDE Tiling WM dotfiles.

---

## ✅ Required Dependencies

### **Core System**
```bash
# Arch/Manjaro
sudo pacman -S plasma-desktop kwin

# Ubuntu/Debian
sudo apt install kde-plasma-desktop kwin-x11
```

### **KDE Plasma 6.0+**
- KDE Plasma must be version 6.0 or higher
- Check version: `plasmashell --version`

### **Krohnkite (Auto-Tiling Script)**
```bash
# Method 1: KDE Store (Recommended)
System Settings > Window Management > KWin Scripts
Get New Scripts > Search "Krohnkite" > Install

# Method 2: Manual
git clone https://github.com/anametologin/krohnkite.git
cd krohnkite
./install.sh

# Method 3: Package manager (Arch)
yay -S kwin-scripts-krohnkite
```

### **Qt6 Tools**
```bash
# Arch/Manjaro
sudo pacman -S qt6-tools

# Ubuntu/Debian  
sudo apt install qt6-tools-dev-tools

# Provides: qdbus6, kwriteconfig6
```

---

## 🎨 Optional Dependencies (Recommended)

### **Better Blur DX (Blur Effect)**
```bash
# Arch/Manjaro
yay -S kwin-effects-better-blur-dx

# Manual installation
git clone https://github.com/taj-ny/kwin-effects-forceblur
cd kwin-effects-forceblur
mkdir build && cd build
cmake ..
make
sudo make install
```

**Note:** Any blur plugin works. Alternatives:
- Native KDE blur (built-in)
- Blur Plus (see below)

---

### **Blur Plus (Enhanced Blur)**
More advanced blur with corner radius, saturation control, etc.

```bash
# Arch/Manjaro
yay -S kwin-effects-blurplus

# Manual
git clone https://github.com/taj-ny/kwin-effects-blurplus
cd kwin-effects-blurplus
mkdir build && cd build
cmake ..
make
sudo make install
```

---

### **Klassy Decorations** (Window Borders)
Current config uses Klassy. Alternatives: Breeze, Sierra Breeze.

```bash
# Arch/Manjaro
yay -S klassy

# Manual
git clone https://github.com/paulmcauley/klassy
cd klassy
mkdir build && cd build
cmake ..
make
sudo make install

# Apply
System Settings > Appearance > Window Decorations > Klassy
```

---

## 🔧 Optional Enhancements

### **Panel Colorizer** ⭐ Highly Recommended
Dynamic panel that changes color based on active window.

```bash
# Arch/Manjaro
yay -S plasma6-applets-panel-colorizer-git

# Manual
git clone https://github.com/luisbocanegra/plasma-panel-colorizer.git
cd plasma-panel-colorizer
./install.sh
```

**Setup:**
```bash
Right-click Panel > Add Widgets > Panel Colorizer
Right-click Panel > Panel Colorizer Settings
- Mode: Dynamic
- Smooth transitions: Yes
```

---

### **Rounded Corners** ⭐ Highly Recommended
Adds rounded corners to all windows.

```bash
# Arch/Manjaro
yay -S kwin-effect-rounded-window

# Ubuntu/Debian (manual)
git clone https://github.com/alex47/KDE-Rounded-Corners
cd KDE-Rounded-Corners
mkdir build && cd build
cmake ..
make
sudo make install
```

**Enable:**
```bash
System Settings > Desktop Effects > Rounded Corners > Enable
Configure: Radius 8-12px recommended
```

---

### **Latte Dock** (Optional)
macOS-style dock with beautiful animations.

```bash
# Arch/Manjaro
sudo pacman -S latte-dock

# Ubuntu/Debian
sudo apt install latte-dock

# Launch
latte-dock
```

---

### **Kvantum Theme Engine** (Optional)
Advanced theming engine for more theme options.

```bash
# Arch/Manjaro
sudo pacman -S kvantum

# Ubuntu/Debian
sudo apt install qt5-style-kvantum

# Configure
kvantummanager
```

**Recommended themes:**
- Catppuccin-Mocha
- Dracula
- Nord

---

### **KDE Connect** (Optional but useful)
Connect phone to desktop for file sharing, notifications, etc.

```bash
# Arch/Manjaro
sudo pacman -S kdeconnect

# Ubuntu/Debian
sudo apt install kdeconnect

# Mobile apps
Android: Google Play Store
iOS: App Store (limited functionality)
```

---

## 📋 KWin Scripts (Optional)

### **Desktop Change OSD**
Shows desktop number when switching workspaces.

```bash
System Settings > Window Management > KWin Scripts
Get New Scripts > "Desktop Change OSD" > Install
```

### **MinimizeAll**
Minimize all windows with one shortcut.

```bash
System Settings > Window Management > KWin Scripts
Get New Scripts > "MinimizeAll" > Install
```

---

## 🧰 Development Tools (Optional)

### **Konsave** (Config Manager)
Save and restore KDE configurations easily.

```bash
# Python package
pip install konsave

# Arch
yay -S konsave

# Usage
konsave -s myprofile  # Save current config
konsave -a myprofile  # Apply saved config
```

---

## 🔍 Verification

### **Check if everything is installed:**

```bash
# Check Plasma version
plasmashell --version

# Check if Krohnkite is installed
kpackagetool6 --type=KWin/Script --list | grep -i krohnkite

# Check if blur plugins are installed
ls ~/.local/share/kwin/effects/ | grep blur
# or
kwin_x11 --list-effects | grep -i blur

# Check Qt6 tools
which qdbus6
which kwriteconfig6

# Check if Klassy is available
kwin_x11 --list-decorations | grep -i klassy
```

---

## 📦 Dependency Installation Scripts

### **Arch/Manjaro Complete Install:**
```bash
#!/bin/bash
# Install all recommended dependencies for Arch/Manjaro

# Core (required)
sudo pacman -S plasma-desktop kwin qt6-tools

# Krohnkite
yay -S kwin-scripts-krohnkite

# Blur effects
yay -S kwin-effects-better-blur-dx
yay -S kwin-effects-blurplus

# Decorations
yay -S klassy

# Optional enhancements
yay -S plasma6-applets-panel-colorizer-git
yay -S kwin-effect-rounded-window
sudo pacman -S latte-dock
sudo pacman -S kvantum
sudo pacman -S kdeconnect

# Utils
pip install konsave

echo "Installation complete! Logout/login to apply changes."
```

### **Ubuntu/Debian Install:**
```bash
#!/bin/bash
# Install dependencies for Ubuntu/Debian

# Core (required)
sudo apt install kde-plasma-desktop kwin-x11 qt6-tools-dev-tools

# Krohnkite (manual)
git clone https://github.com/anametologin/krohnkite.git
cd krohnkite && ./install.sh && cd ..

# Other packages (manual installation required)
# See individual sections above

echo "Core dependencies installed!"
echo "Some packages require manual installation - see DEPENDENCIES.md"
```

---

## ⚠️ Minimum Requirements

### **System:**
- CPU: Any modern CPU (2 cores+)
- RAM: 4GB minimum, 8GB recommended
- GPU: Any GPU with OpenGL 2.0+ support
- Display: 1920x1080 or higher recommended

### **Software:**
- KDE Plasma 6.0+
- Qt 6.4+
- Wayland or X11 (both supported)
- Linux kernel 5.15+

---

## 🐛 Troubleshooting Dependencies

### **"qdbus6: command not found"**
```bash
# Install Qt6 tools
sudo pacman -S qt6-tools  # Arch
sudo apt install qt6-tools-dev-tools  # Ubuntu
```

### **"Krohnkite not found after install"**
```bash
# Reinstall and enable
cd ~/.local/share/kwin/scripts/krohnkite
./install.sh
# Then enable in System Settings > KWin Scripts
```

### **"Blur effect not working"**
```bash
# Install a blur plugin
yay -S kwin-effects-better-blur-dx
# or
yay -S kwin-effects-blurplus

# Enable in kwinrc
kwriteconfig6 --file ~/.config/kwinrc --group Plugins --key better_blur_dxEnabled true
qdbus6 org.kde.KWin /KWin reconfigure
```

### **"Klassy decorations not available"**
```bash
# Install Klassy
yay -S klassy  # Arch
# or compile from source (see above)

# Apply
System Settings > Window Decorations > Klassy
```

---

## 📊 Recommended Setup

### **Minimal (Fastest):**
- KDE Plasma 6
- Krohnkite
- Native KDE blur
- Default decorations
**Result:** Fully functional, fast

### **Balanced (Recommended):**
- Above + Better Blur DX
- Above + Klassy decorations
- Above + Panel Colorizer
**Result:** Great visuals, still fast

### **Complete (Maximum aesthetics):**
- Above + Rounded Corners
- Above + Latte Dock
- Above + Kvantum themes
- Above + All widgets
**Result:** Stunning desktop, small performance cost

---

## 🔗 Official Links

- [KDE Plasma](https://kde.org/plasma-desktop/)
- [Krohnkite](https://github.com/anametologin/krohnkite)
- [Panel Colorizer](https://github.com/luisbocanegra/plasma-panel-colorizer)
- [Rounded Corners](https://github.com/alex47/KDE-Rounded-Corners)
- [Kvantum](https://github.com/tsujan/Kvantum)
- [Latte Dock](https://github.com/KDE/latte-dock)

---

**Need help?** Check [COMMON_ISSUES.md](../troubleshooting/COMMON_ISSUES.md) or open an issue on GitHub.
