#! /bin/bash

DWM=$HOME/scripts

this=_light
icon_color="^c#7B102B^^b#5555660x66^"
text_color="^c#3B102B^^b#6873790x99^"
signal=$(echo "^s$this^" | sed 's/_//')

update() {
    icon=" "
    # light_text=$(xrandr --verbose | grep Brightness | awk '{ printf "%.0f%%", $2 * 100 }')
    light_text=''
    sed -i '/^export '$this'=.*$/d' $DWM/statusbar/temp
    printf "export %s=\"%s%s%s%s%s\"\n" $this "$signal" "$icon_color" "$icon" "$text_color" "$light_text" >> $DWM/statusbar/temp
}

function set_brightness_all_screens() {
  declare -a screens=($(xrandr | grep " connected" | awk '{print $1}'))

  for screen in "${screens[@]}"; do
    xrandr --output "$screen" --brightness $1
  done
}

function light_add() {
light_val=$(xrandr --verbose | grep Brightness | awk '{ print $2 }')
light_val=$(echo "$light_val + 0.05" | bc)
    if (( $(echo "$light_val <= 1.0" | bc -l) )); then
        set_brightness_all_screens "$light_val"
    fi
}

function light_sub() {
light_val=$(xrandr --verbose | grep Brightness | awk '{ print $2 }')
light_val=$(echo "$light_val - 0.05" | bc)
    if (( $(echo "$light_val >= 0.15" | bc -l) )); then
        set_brightness_all_screens "$light_val"
    fi
}

notify() {
if [ $# -gt 0 ]; then
    notify-send -r 9527 "$icon Light" "\n亮度：$1"
else
    light_text=$(xrandr --verbose | grep Brightness | awk '{ printf "%.0f%%", $2 * 100 }')
    notify-send -r 9527 "$icon Light" "\n亮度：$light_text"
fi
}

click() {
    case "$1" in
        L) set_brightness_all_screens 0.5; notify '50%';;
        M) set_brightness_all_screens 0.8; notify '80%';;
        R) set_brightness_all_screens 1; notify '100%';;
        U) light_add; notify;;
        D) light_sub; notify;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac
