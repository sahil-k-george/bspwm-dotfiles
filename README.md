# My BSPWM Dotfiles

These are my personal configuration files (dotfiles) for my BSPWM setup. This is a clean, keyboard-driven tiling window environment styled dynamically (via Pywal) using BSPWM, Polybar, Dunst, Rofi, and Kitty.

Everything is stored inside the `.config` folder to keep things easy to manage, back up, and copy to new installations.

---
## Screenshots
> Will be uploaded soon . . .


---

## 🛠️ What configs are Included

Here's the breakdown of my config directories and what each does in my setup:


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

## 📦 Dependencies I Use

Here are all the packages I have installed on my system to run this environment:

### 1. Installing on Different Linux Distros

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

## 📥 How to Set It Up

Here are the steps to clone my repository and load these configurations on your own system:

### Step 1: Clone the repository
Clone the repository to a local directory:
```bash
git clone https://github.com/sahil-k-george/bspwm-dotfiles.git ~/dotfiles
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

## ⌨️ My Main Keybindings

Here are the main keyboard shortcuts I use (defined in my [`sxhkdrc`](sxhkd/sxhkdrc)):

* **`Super + T`**: Launch Terminal (`kitty`)
* **`Super + E`**: Launch File Manager (`thunar`)
* **`Super + B`**: Launch Web Browser (`falkon`)
* **`Super + Space`**: Open App Launcher (`rofi`)
* **`Super + Q` / `Shift + Q`**: Close / Kill active window
* **`Super + Delete`**: Open Power Menu (Lock, Logout, Reboot, Shutdown)
* **`Super + Escape`**: Reload hotkeys configuration (`sxhkd`)
* **`Super + Ctrl + R`**: Reload window manager (`bspwm`)
* **`Super + 0` through `Super + 9`**: Switches workspaces from 1 - 10 


## Additional Informations
1. You have to download and supply your own wallpapers as of now, once I upload my own wallpapers, instructions on where to download it from will be updated. 
2. Change the wallpaper by changing the `bgpath="$HOME/Pictures/carrera.png"` in [bspwmrc](bspwm/bspwmrc) path to the path of your wallpaper. Accent colors and stuff are automatically updated (At least that how it works on my PC ` ¯\_(ツ)_/¯ `). 
3. Some of the scripts and other polybar stuff were used from [this repository](https://github.com/shell-ninja/i3-dotfiles) (Huge thanks to [shell-ninja](https://github.com/shell-ninja) for hosting his dotfiles, his repo was used as an inspiration and guide for setting up polybar and other stuff), and I think some configs still use them (that's why an entire scripts sub-folder is in the bspwm folder), so, as of now, they are dependent on them. This will be changing once porting some functions from the said repository is done. 
4. More details will be added here soon.