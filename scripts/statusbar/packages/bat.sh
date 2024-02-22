#! /bin/bash
# 电池电量
DWM=$HOME/scripts
# source ~/.profile

this=_bat
icon_color="^c#3B001B^^b#4865660x88^"
text_color="^c#3B001B^^b#4865660x99^"
# color="^c#2D1B46^^b#31748f^"
# color="^c#eb6f92^^b#1f1d2e^"
signal=$(echo "^s$this^" | sed 's/_//')

update() {
    bat_text=$(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+")
    [ ! "$bat_text" ] && bat_text=$(acpi -b | sed 2d | awk '{print $5}' | grep -Eo "[0-9]+")
    [ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] && charge_icon=""
    if   [ "$bat_text" -ge 95 ]; then bat_icon=""; charge_icon="";
    elif [ "$bat_text" -ge 90 ]; then bat_icon="";
    elif [ "$bat_text" -ge 80 ]; then bat_icon="";
    elif [ "$bat_text" -ge 70 ]; then bat_icon="";
    elif [ "$bat_text" -ge 60 ]; then bat_icon="";
    elif [ "$bat_text" -ge 50 ]; then bat_icon="" icon_color="^c#eb6f92^^b#4865660x88^";
    elif [ "$bat_text" -ge 40 ]; then bat_icon="" icon_color="^c#eb6f92^^b#4865660x88^";
    elif [ "$bat_text" -ge 30 ]; then bat_icon="" icon_color="^c#eb6f92^^b#4865660x88^";
    elif [ "$bat_text" -ge 20 ]; then bat_icon="" icon_color="^c#eb6f92^^b#4865660x88^";
    elif [ "$bat_text" -ge 10 ]; then bat_icon="" icon_color="^c#eb6f92^^b#4865660x88^";
    else bat_icon="" icon_color="^c#eb6f92^^b#4865660x88^" ; fi

    # bat_text=" $bat_text% "
    bat_text=""
    bat_icon=" $charge_icon$bat_icon  "

    sed -i '/^export '$this'=.*$/d' $DWM/statusbar/temp
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$icon_color" "$bat_icon" "$text_color" "$bat_text" >> $DWM/statusbar/temp
}

notify() {
    update
    _status="状态: $(acpi | sed 's/^Battery 0: //g' | awk -F ',' '{print $1}')"
    _remaining="剩余: $(acpi | sed 's/^Battery 0: //g' | awk -F ',' '{print $2}' | sed 's/^[ ]//g')"
    _time="可用时间: $(acpi | sed 's/^Battery 0: //g' | awk -F ',' '{print $3}' | sed 's/^[ ]//g' | awk '{print $1}')"
    [ "$_time" == "可用时间: " ] && _time=""
    notify-send "$bat_icon Battery" "\n$_status\n$_remaining\n$_time" -r 9527
}

click() {
    case "$1" in
        L) notify ;;
        # R) killall xfce4-power-manager-settings || xfce4-power-manager-settings & ;;
        M) powerprofilesctl set balanced && dunstify -h string\:x-dunst-stack-tag\:power-mode Balanced mode ;;
        U) powerprofilesctl set performance && dunstify -h string\:x-dunst-stack-tag\:power-mode Performance mode ;; 
        D) powerprofilesctl set power-saver && dunstify -h string\:x-dunst-stack-tag\:power-mode Power-saver mode
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac
