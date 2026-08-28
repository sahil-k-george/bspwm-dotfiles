#!/bin/bash

# Check if YAD is installed
if ! command -v yad &> /dev/null; then
    if command -v notify-send &> /dev/null; then
        notify-send "Dependency Missing" "Please install 'yad' to view the help menu:\nsudo apt install yad  (or pacman -S yad)"
    fi
    if command -v gxmessage &> /dev/null; then
        gxmessage -title "Help Menu Error" "YAD is not installed. Please install it using:\nsudo apt install yad" &
    elif command -v xmessage &> /dev/null; then
        xmessage "YAD is not installed. Please install it using: sudo apt install yad" &
    fi
    exit 1
fi

# Detect X11 monitor resolution
res=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
x_mon=$(echo "$res" | cut -d'x' -f1)
y_mon=$(echo "$res" | cut -d'x' -f2)

# Fallbacks if xrandr query fails
x_mon=${x_mon:-1366}
y_mon=${y_mon:-768}

# Set maximum width and height
max_width=1000
max_height=800

# Set percentage of screen size for dynamic adjustment
percentage_width=60
percentage_height=65

# Calculate dynamic width and height
dynamic_width=$((x_mon * percentage_width / 100))
dynamic_height=$((y_mon * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Launch yad with calculated width and height
yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="BSPWM Keybindings Help" \
    --no-buttons \
    --list \
    --column="Key Combination" \
    --column="Description" \
    --column="Action / Target" \
    --timeout-indicator=bottom \
" = " "SUPER KEY (Windows Key)" "(Mod key modifier)" \
"" "" "" \
" + T" "Launch Terminal" "(Kitty)" \
" + E" "Open File Manager" "(Thunar)" \
" + B" "Open Web Browser" "(Falkon)" \
" + Space" "App Launcher Menu" "(Rofi)" \
" + Delete" "Power / Session Menu" "(Lock, Logout, Reboot, Shutdown)" \
" + Escape" "Reload Hotkeys configuration" "(sxhkd daemon)" \
" + Ctrl + R" "Restart Window Manager" "(Reloads bspwmrc)" \
" + Ctrl + Q" "Quit BSPWM Session" "(Logs out to display manager)" \
"" "" "" \
" + Q" "Close Focused Window" "Graceful close" \
" + Shift + Q" "Kill Window Process" "Force termination" \
" + F" "Toggle Fullscreen State" "Fullscreen toggle" \
" + S" "Toggle Floating State" "Floating layout toggle" \
" + M" "Toggle Monocle State" "Maximized layout toggle" \
"" "" "" \
" + {H, J, K, L}" "Focus Window (Left, Down, Up, Right)" "bspwm focus navigation" \
" + Shift + {H, J, K, L}" "Swap Window (Left, Down, Up, Right)" "bspwm node swap" \
" + Ctrl + {H, J, K, L}" "Preselect Split (Left, Down, Up, Right)" "Pre-tile split target" \
" + Alt + {H, J, K, L}" "Resize Window Outward (Left, Down, Up, Right)" "Resize pane margins" \
" + Alt + Shift + {H, J, K, L}" "Resize Window Inward (Left, Down, Up, Right)" "Resize pane margins" \
" + {Left, Down, Up, Right}" "Move Floating Window" "Direct floating move" \
"" "" "" \
" + {1 - 9, 0}" "Switch to Desktop Workspace (1 to 10)" "bspwm desktop focus" \
" + Shift + {1 - 9, 0}" "Move Window to Desktop Workspace" "bspwm node send" \
" + [ or ]" "Focus Next / Previous Workspace" "Cycle desktops" \
" + Tab" "Toggle Last Active Desktop" "History focus swap" \
"" "" "" \
"Brightness Keys" "Adjust Screen Brightness" "(brightnessctl)" \
"Audio Volume Keys" "Adjust System Volume" "(pamixer / alsa)"