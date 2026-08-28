# BSPWM Desktop Environment Dotfiles

Welcome! This repository contains a curated and customized set of configuration files (dotfiles) for setting up a modern, mouse-less, and visually rich tiling window manager environment using **BSPWM** (Binary Space Partitioning Window Manager) as the core.

All configurations are located inside the `.config` directory, structured to be modular and easy to install.

---

## 🛠️ Components & Config Directories

The repository tracks only the configurations necessary for the BSPWM window manager stack:

| Component | Directory / File | Description |
| :--- | :--- | :--- |
| **BSPWM** | [`bspwm/`](bspwm/) | The window manager itself, containing workspace rules, startup services, and utility scripts. |
| **SXHKD** | [`sxhkd/`](sxhkd/) | Simple X Hotkey Daemon configs handling all window operations and keyboard shortcuts. |
| **Polybar** | [`polybar/`](polybar/) | Status bar configuration, with options for modular widgets (volume, workspaces, date, etc.). |
| **Rofi** | [`rofi/`](rofi/) | App launcher, clipboard history searcher, power menu, and screenshot interfaces. |
| **Dunst** | [`dunst/`](dunst/) | Lightweight and customizable notification daemon config. |
| **Kitty** | [`kitty/`](kitty/) | Fast, GPU-accelerated terminal emulator configured for standard use. |
| **Pywal** | [`wal/`](wal/) | Color templates used to generate theme palettes dynamically based on your wallpapers. |
| **Picom** | [`picom.conf.arch`](picom.conf.arch) | Compositor configuration file for window fading, shadows, animations, and transparency. |
| **Greenclip** | [`greenclip.toml`](greenclip.toml) | Configuration for the Haskell-based clipboard manager daemon. |
| **Systemd** | [`systemd/`](systemd/) | Contains the user systemd service to autostart the `greenclip` daemon. |

---

## 📦 Required Dependencies

To run this desktop environment successfully, make sure to install the following packages for your specific Linux distribution:

### 1. Installation Commands by Distribution

#### **Arch Linux**
Using `pacman` and `yay` (or your preferred AUR helper):
```bash
# Install core packages from official repos
sudo pacman -S bspwm sxhkd polybar rofi dunst kitty feh imagemagick pamixer brightnessctl maim xclip xdotool jq libnotify ttf-jetbrains-mono-nerd

# Install AUR packages (pywal, greenclip, betterlockscreen, picom with animations)
yay -S python-pywal greenclip betterlockscreen picom-git
```

#### **Debian / Ubuntu**
```bash
# Install core packages from APT
sudo apt update
sudo apt install bspwm sxhkd polybar rofi dunst kitty feh imagemagick pamixer brightnessctl maim xclip xdotool jq libnotify-bin fonts-jetbrains-mono python3-pip picom

# Install Pywal via pip
pip3 install --user pywal

# Download Greenclip binary from GitHub
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
chmod +x greenclip
sudo mv greenclip /usr/local/bin/
```

#### **Fedora**
```bash
# Install core packages from DNF
sudo dnf install bspwm sxhkd polybar rofi dunst kitty feh ImageMagick pamixer brightnessctl maim xclip xdotool jq libnotify jetbrains-mono-fonts picom

# Install Pywal via pip
pip install --user pywal

# Download Greenclip binary from GitHub
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
chmod +x greenclip
sudo mv greenclip /usr/local/bin/
```

#### **OpenSUSE**
```bash
# Install core packages from Zypper
sudo zypper install bspwm sxhkd polybar rofi dunst kitty feh ImageMagick pamixer brightnessctl maim xclip xdotool jq libnotify-tools jetbrains-mono-fonts picom

# Install Pywal via pip
pip install --user pywal

# Download Greenclip binary from GitHub
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
chmod +x greenclip
sudo mv greenclip /usr/local/bin/
```

---

## 📥 Deployment Guide

Follow these instructions to clone this repository and deploy it to your home directory:

### Step 1: Clone the repository
Clone the repository to a local directory:
```bash
git clone <your-repo-url> ~/dotfiles
```

### Step 2: Backup existing configurations (Safe Step)
If you already have configuration folders inside `~/.config/`, backup them up to prevent losing any local settings:
```bash
mkdir -p ~/.config/backup_dotfiles
for dir in bspwm sxhkd polybar rofi dunst kitty wal; do
    [ -d ~/.config/$dir ] && mv ~/.config/$dir ~/.config/backup_dotfiles/
done
[ -f ~/.config/greenclip.toml ] && mv ~/.config/greenclip.toml ~/.config/backup_dotfiles/
```

### Step 3: Link or Copy files
You can either symbolically link (highly recommended for keeping changes in sync with git) or copy the files directly.

#### **Option A: Deploy using Symbolic Links (Recommended)**
```bash
mkdir -p ~/.config

# Link directories
ln -sf ~/dotfiles/.config/bspwm ~/.config/bspwm
ln -sf ~/dotfiles/.config/sxhkd ~/.config/sxhkd
ln -sf ~/dotfiles/.config/polybar ~/.config/polybar
ln -sf ~/dotfiles/.config/rofi ~/.config/rofi
ln -sf ~/dotfiles/.config/dunst ~/.config/dunst
ln -sf ~/dotfiles/.config/kitty ~/.config/kitty
ln -sf ~/dotfiles/.config/wal ~/.config/wal

# Link individual configuration files
ln -sf ~/dotfiles/.config/greenclip.toml ~/.config/greenclip.toml
ln -sf ~/dotfiles/.config/picom.conf.arch ~/.config/picom.conf
```

#### **Option B: Deploy by Copying Files**
```bash
mkdir -p ~/.config

# Copy directories
cp -r ~/dotfiles/.config/bspwm ~/.config/
cp -r ~/dotfiles/.config/sxhkd ~/.config/
cp -r ~/dotfiles/.config/polybar ~/.config/
cp -r ~/dotfiles/.config/rofi ~/.config/
cp -r ~/dotfiles/.config/dunst ~/.config/
cp -r ~/dotfiles/.config/kitty ~/.config/
cp -r ~/dotfiles/.config/wal ~/.config/

# Copy individual files
cp ~/dotfiles/.config/greenclip.toml ~/.config/greenclip.toml
cp ~/dotfiles/.config/picom.conf.arch ~/.config/picom.conf
```

---

### Step 4: Configure and Enable Systemd Services

The Haskell clipboard manager `greenclip` requires its daemon to be running. We configure it as a user systemd service:

```bash
# Create directory for systemd user unit files
mkdir -p ~/.config/systemd/user/

# Link the user service file
ln -sf ~/dotfiles/.config/systemd/user/greenclip.service ~/.config/systemd/user/greenclip.service

# Reload systemd configuration and enable/start greenclip service
systemctl --user daemon-reload
systemctl --user enable --now greenclip.service
```

---

## ⌨️ Common Keybindings

Here are some default keyboard shortcuts defined in [`sxhkdrc`](sxhkd/sxhkdrc):

* **`Super + T`**: Launch Terminal (`kitty`)
* **`Super + E`**: Launch File Manager (`thunar`)
* **`Super + B`**: Launch Web Browser (`falkon`)
* **`Super + Space`**: Open App Launcher (`rofi`)
* **`Super + Q` / `Shift + Q`**: Close / Kill active window
* **`Super + Delete`**: Open Power Menu (Lock, Logout, Reboot, Shutdown)
* **`Super + Escape`**: Reload hotkeys configuration (`sxhkd`)
* **`Super + Ctrl + R`**: Reload window manager (`bspwm`)
* **`Super + Arrow Keys`**: Move floating windows
* **`Super + Alt + H/J/K/L`**: Resize windows
