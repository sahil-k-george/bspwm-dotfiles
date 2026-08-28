#!/usr/bin/env bash

# Add this script to your wm startup file.

THEME=rounded
DIR="$HOME/.config/polybar/bspwm/$THEME"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
