#!/bin/bash

bspwm_dir="$HOME/.config/bspwm"
scripts_dir="$bspwm_dir/scripts"
cache_dir="$bspwm_dir/.cache"

wallpaper_dir="$HOME/Pictures"
if [[ ! -d "$wallpaper_dir" ]]; then
    wallpaper_dir="$bspwm_dir/Wallpapers"
fi

# Ensure cache folder exists
mkdir -p "$cache_dir"

pics=($(find ${wallpaper_dir} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
random_pic=${pics[ $RANDOM % ${#pics[@]} ]}

# functions to change wallpaper using feh
change() {
    if command -v feh &> /dev/null; then
        engine="feh --bg-scale $1"
    fi

    # notify-send "Changing to" -i "$random_pic"
    sleep 1
    $engine "$random_pic"
    ln -sf "$random_pic" "$cache_dir/current.png"
}

change

sleep 0.2
"$scripts_dir/Colors.sh"

magick "$random_pic" -blur 0x15 "$cache_dir/blured.png"
