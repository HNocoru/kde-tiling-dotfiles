# 🎨 RECOMMENDED PLUGINS & WIDGETS
## Enhance Your KDE Tiling WM Experience

This document covers optional plugins, widgets, and enhancements that can take your KDE Plasma tiling setup to the next level.

---

## 📋 TABLE OF CONTENTS
1. [Visual Enhancements](#visual-enhancements)
2. [Panel Widgets](#panel-widgets)
3. [KWin Scripts](#kwin-scripts)
4. [Desktop Widgets](#desktop-widgets)
5. [System Utilities](#system-utilities)
6. [Installation Commands](#installation-commands)

---

## 🎨 VISUAL ENHANCEMENTS

### **1. Panel Colorizer** ⭐ HIGHLY RECOMMENDED
**What it does:** Makes your KDE panel adaptive/dynamic by:
- Matching panel color to active window
- Smooth color transitions
- Per-app color presets
- Opacity/blur control
- Floating panel mode

**Why you want it:**
- Looks absolutely stunning with tiling WMs
- Subtle visual indicator of active window
- Makes panel feel integrated, not just "stuck there"
- Pairs perfectly with our opacity rules

**Installation:**
```bash
# Method 1: Via KDE Store (Recommended)
System Settings > Appearance > Get New Window Decorations
Search: "Panel Colorizer" > Install

# Method 2: Manual
git clone https://github.com/luisbocanegra/plasma-panel-colorizer.git
cd plasma-panel-colorizer
./install.sh

# Method 3: Package manager (Arch)
yay -S plasma6-applets-panel-colorizer-git
```

**Configuration:**
```bash
# Right-click panel > Panel Colorizer Settings

Recommended settings:
- Mode: Dynamic (matches active window)
- Enable smooth transitions: Yes
- Blur strength: 20-30
- Opacity: 80-90%
- Transition duration: 200ms

# Optional: Presets per app
Brave: #7C3AED (purple)
VSCode: #007ACC (blue)
Terminal: #2E3440 (dark gray)
```

**Pro Tips:**
- Works best with floating panel (not touching screen edge)
- Combine with latte-dock for maximum effect
- Create presets for your most-used apps
- Disable when gaming (slight performance cost)

---

### **2. Rounded Corners (KWin Effect)** ⭐ HIGHLY RECOMMENDED
**What it does:**
- Adds rounded corners to ALL windows
- Configurable radius per window
- Shadow integration
- Antialiasing

**Why you want it:**
- Modern, polished look (like macOS)
- Softens the sharp corners of tiled windows
- Makes gaps between windows more aesthetic
- Essential for the "premium" desktop look

**Installation:**
```bash
# Arch/Manjaro
yay -S kwin-effects-forceblur
yay -S kwin-effect-rounded-window

# Ubuntu/Debian
sudo add-apt-repository ppa:krisives/kde-rounded-corners
sudo apt update
sudo apt install kwin-effect-rounded-window

# Manual (any distro)
git clone https://github.com/alex47/KDE-Rounded-Corners
cd KDE-Rounded-Corners
mkdir build && cd build
cmake ..
make
sudo make install
```

**Configuration:**
```bash
# System Settings > Desktop Effects > Rounded Corners

Recommended settings:
- Corner radius: 8-12px (small) or 16-20px (large)
- Shadow padding: 10-15px
- Outline: Enabled (subtle)
- Outline width: 1-2px
- Outline color: Accent color or subtle gray

# Per-window config (optional)
Terminals: 6-8px (smaller radius)
Browsers: 10-12px (medium radius)
Media players: 14-16px (larger radius)
```

**Integration with our config:**
Rounded corners + blur + opacity rules = 🔥
```bash
# Add to kwinrc for best results:
[Effect-RoundedCorners]
Radius=10
ShadowSize=15
OutlineWidth=1
# This integrates perfectly with our blur configuration
```

---

### **3. Latte Dock** ⭐ OPTIONAL
**What it does:**
- macOS-style dock
- App launcher + taskbar
- Beautiful animations
- Multiple layouts
- Excellent with tiling WMs

**Why you might want it:**
- Better workspace switching visualization
- App indicators and badges
- Parabolic zoom effect
- Can replace default panel

**Installation:**
```bash
# Arch/Manjaro
sudo pacman -S latte-dock

# Ubuntu/Debian
sudo apt install latte-dock

# Other distros
# Check: https://github.com/KDE/latte-dock
```

**Configuration:**
```bash
# Latte Settings (right-click dock)

Recommended settings:
- Location: Bottom
- Size: 48-64px
- Zoom: 15-20% (subtle)
- Behavior: Dodge Active (hides when window overlaps)
- Appearance: Transparent (or match Panel Colorizer)
- Background: Blur enabled, Opacity 75-85%

# Integration with Krohnkite:
- Set screen gaps to accommodate dock height
- Enable "Reserve space" in Latte settings
```

---

### **4. Blur Plus (KWin Effect)** ⭐ ALREADY CONFIGURED
**What it does:**
- Enhanced blur beyond native KDE blur
- Better performance
- More customization options

**You already have this configured!** Check kwinrc [Effect-blurplus]

If you want to install:
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

## 📊 PANEL WIDGETS

### **1. Better Inline Clock** ⭐ RECOMMENDED
**What it does:**
- Customizable clock widget
- Multiple timezones
- Better date formatting
- Calendar integration

**Installation:**
```bash
System Settings > Widgets > Get New Widgets
Search: "Better Inline Clock" > Install
```

---

### **2. Netspeed Widget**
**What it does:**
- Shows network speed in panel
- Upload/download rates
- Minimal design
- Useful for monitoring

**Installation:**
```bash
System Settings > Widgets > Get New Widgets
Search: "Netspeed Widget" > Install
```

---

### **3. Window Title Applet**
**What it does:**
- Shows active window title in panel
- Useful for tiling setups
- Customizable format

**Installation:**
```bash
System Settings > Widgets > Get New Widgets
Search: "Window Title Applet" > Install
```

**Integration:**
Perfect for tiling WM users who remove title bars!

---

### **4. Workspace Indicator**
**What it does:**
- Visual indicator of current workspace
- Click to switch
- Minimal design

**Installation:**
```bash
System Settings > Widgets > Get New Widgets
Search: "Pager" (built-in) or
Search: "Minimal Pager" for cleaner look
```

---

## 🪟 KWIN SCRIPTS

### **1. Sticky Window Snapping**
**What it does:**
- Windows "snap" to edges when close
- Magnetic effect between windows
- Adjustable snap distance

**Installation:**
```bash
System Settings > Window Management > KWin Scripts
Get New Scripts > Search: "Sticky Window Snapping" > Install
```

**Note:** With our 4px gaps + Krohnkite, you might not need this!

---

### **2. Window Gaps**
**What it does:**
- Adds gaps between windows
- Customizable per screen edge

**Installation:**
Built into KDE Plasma 6! Already configured in our kwinrc.

---

### **3. MinimizeAll**
**What it does:**
- Minimize all windows with one shortcut
- Show desktop quickly
- Restore all minimized windows

**Installation:**
```bash
System Settings > Window Management > KWin Scripts
Get New Scripts > Search: "MinimizeAll" > Install
```

**Configure:**
Add shortcut: Meta+D or Meta+Shift+D

---

### **4. Desktop Change OSD**
**What it does:**
- Shows overlay when switching desktops
- Visual feedback for workspace changes
- Customizable appearance

**Installation:**
```bash
System Settings > Window Management > KWin Scripts
Get New Scripts > Search: "Desktop Change OSD" > Install
```

---

## 🖥️ DESKTOP WIDGETS

### **1. Resource Monitor (System Monitor Sensor)**
**What it does:**
- CPU/RAM/Network graphs
- Customizable appearance
- Minimal overhead

**Installation:**
Built-in! Right-click desktop > Add Widgets > System Monitor Sensor

**Configuration:**
```bash
# Recommended sensors:
- CPU Usage (line chart)
- RAM Usage (histogram)
- Network Speed (line chart)

# Appearance:
- Transparent background
- Accent color lines
- Small size (100-150px)
```

---

### **2. Event Calendar**
**What it does:**
- Shows calendar on desktop
- Google Calendar integration
- Weather widget (optional)

**Installation:**
```bash
System Settings > Widgets > Get New Widgets
Search: "Event Calendar" > Install
```

---

## 🛠️ SYSTEM UTILITIES

### **1. KDE Connect**
**What it does:**
- Connect phone to desktop
- Share files, clipboard, notifications
- Remote control
- Phone as touchpad

**Installation:**
```bash
# Arch/Manjaro
sudo pacman -S kdeconnect

# Ubuntu/Debian
sudo apt install kdeconnect

# Install phone app from:
# Android: Play Store
# iOS: App Store (limited functionality)
```

---

### **2. Kvantum Theme Engine**
**What it does:**
- Advanced theming engine
- More theme options than native KDE
- Blur and transparency effects

**Installation:**
```bash
# Arch/Manjaro
sudo pacman -S kvantum

# Ubuntu/Debian
sudo apt install qt5-style-kvantum

# Configure:
kvantummanager
```

**Recommended themes:**
- Catppuccin-Mocha-Lavender
- Dracula
- Nord
- Gruvbox

---

### **3. Konsave (Config Manager)**
**What it does:**
- Save/restore KDE configurations
- Multiple profiles
- Easy backup
- Share configs with others

**Installation:**
```bash
# Python package
pip install konsave

# Or Arch
yay -S konsave

# Usage:
konsave -s myprofile    # Save
konsave -a myprofile    # Apply
konsave -l              # List profiles
```

---

## 📦 COMPLETE INSTALLATION COMMANDS

### **Essential (Highly Recommended):**
```bash
# Panel Colorizer
yay -S plasma6-applets-panel-colorizer-git

# Rounded Corners
git clone https://github.com/alex47/KDE-Rounded-Corners
cd KDE-Rounded-Corners && mkdir build && cd build
cmake .. && make && sudo make install

# KDE Connect
sudo pacman -S kdeconnect

# Enable rounded corners effect
System Settings > Desktop Effects > Rounded Corners > Enable
```

### **Optional (Nice to Have):**
```bash
# Latte Dock
sudo pacman -S latte-dock

# Kvantum
sudo pacman -S kvantum

# Konsave
pip install konsave

# Install widgets via GUI:
System Settings > Widgets > Get New Widgets:
- Better Inline Clock
- Netspeed Widget
- Window Title Applet
- Resource Monitor (built-in)
```

### **KWin Scripts:**
```bash
# Via GUI:
System Settings > Window Management > KWin Scripts > Get New Scripts:
- Desktop Change OSD
- MinimizeAll
- (Sticky Window Snapping - optional with our config)
```

---

## 🎨 THEMING RECOMMENDATIONS

### **Color Schemes:**
```bash
# Catppuccin (Modern, pastel)
git clone https://github.com/catppuccin/kde catppuccin-kde
./catppuccin-kde/install.sh

# Dracula (Dark, purple accents)
git clone https://github.com/dracula/kde
cd kde && ./install.sh

# Nord (Cool, blue tones)
wget https://github.com/EliverLara/Nordic/releases/download/latest/Nordic.tar.xz
tar -xf Nordic.tar.xz -C ~/.local/share/plasma/desktoptheme/
```

### **Icon Themes:**
```bash
# Papirus (colorful, modern)
sudo pacman -S papirus-icon-theme

# Tela (flat, colorful)
git clone https://github.com/vinceliuice/Tela-icon-theme
cd Tela-icon-theme && ./install.sh

# WhiteSur (macOS-like)
git clone https://github.com/vinceliuice/WhiteSur-icon-theme
cd WhiteSur-icon-theme && ./install.sh
```

---

## 🔧 CONFIGURATION INTEGRATION

### **How to integrate plugins with our config:**

**1. Rounded Corners + Blur:**
```bash
# Edit ~/.config/kwinrc
[Effect-RoundedCorners]
Radius=10
ShadowSize=15

[Effect-blurplus]
# Already configured!
# Rounded corners will respect blur regions
```

**2. Panel Colorizer + Krohnkite:**
```bash
# Panel Colorizer settings:
- Enable "Match active window"
- Smooth transitions: 200ms
- This gives visual feedback on which window is active
- Perfect for tiling where focus can be unclear
```

**3. Latte Dock + Gaps:**
```bash
# Adjust screen gaps to accommodate dock:
[Script-krohnkite]
screenGapBottom=60  # Increase if using bottom dock (was 4)
# Or enable "Reserve space" in Latte settings
```

---

## 🎯 RECOMMENDED COMBINATIONS

### **Minimal Setup:**
- Rounded Corners (aesthetic)
- Panel Colorizer (visual feedback)
- Our kwinrc config (already have)
**Result:** Clean, modern, functional

### **Balanced Setup:**
- Above + Latte Dock
- Better Inline Clock
- Netspeed Widget
**Result:** Polished, informative, still fast

### **Power User Setup:**
- Above + All KWin Scripts
- Resource Monitor widgets
- Kvantum theming
- KDE Connect
**Result:** Feature-rich, customized, powerful

---

## 📊 PERFORMANCE IMPACT

| Plugin | RAM | CPU | Startup | Worth It? |
|--------|-----|-----|---------|-----------|
| Panel Colorizer | +15MB | +1-2% | +100ms | ⭐⭐⭐⭐⭐ YES |
| Rounded Corners | +5MB | <1% | +50ms | ⭐⭐⭐⭐⭐ YES |
| Latte Dock | +80MB | +2-3% | +300ms | ⭐⭐⭐⭐ YES |
| Blur Plus | +10MB | +1% | +80ms | ⭐⭐⭐⭐⭐ YES |
| KDE Connect | +30MB | <1% | +150ms | ⭐⭐⭐⭐ YES |
| Kvantum | +5MB | <1% | +60ms | ⭐⭐⭐ MAYBE |

**Note:** With modern hardware (8GB+ RAM, decent CPU), none of these have noticeable performance impact.

---

## 🚀 QUICK START

**Want the "ultimate aesthetic setup" in 5 minutes?**

```bash
# 1. Install essentials
yay -S plasma6-applets-panel-colorizer-git kdeconnect

# 2. Install rounded corners
git clone https://github.com/alex47/KDE-Rounded-Corners
cd KDE-Rounded-Corners && mkdir build && cd build
cmake .. && make && sudo make install

# 3. Enable effects
System Settings > Desktop Effects:
- ✓ Rounded Corners
- ✓ Blur Plus (already configured in kwinrc)

# 4. Configure Panel Colorizer
Right-click panel > Panel Colorizer Settings:
- Mode: Dynamic
- Smooth transitions: Yes
- Opacity: 85%

# 5. Done! Logout/login to see the magic ✨
```

---

## 📝 NOTES

- All plugins listed are compatible with KDE Plasma 6
- Most are available in Arch repos or AUR
- Ubuntu/Debian users may need PPAs (linked in sections)
- None of these plugins are required - our base config is already great!
- These are enhancements to make it even better

---

## 🔗 USEFUL LINKS

- [KDE Store](https://store.kde.org/) - Themes, widgets, plugins
- [r/kde](https://reddit.com/r/kde) - Community showcase and help
- [KDE Look](https://www.pling.com/browse?cat=301) - More themes
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Popular theme
- [Kvantum Themes](https://github.com/tsujan/Kvantum/tree/master/Kvantum/themes)

---

**Remember:** Start with the essentials (Panel Colorizer + Rounded Corners), then add more as you explore. Our base config is already a complete, functional tiling WM!
