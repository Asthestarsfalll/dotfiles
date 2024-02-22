#! /bin/bash

DWM=$HOME/scripts

this=_music
icon_color="^c#7B102B^^b#6873790x88^"
text_color="^c#3B102B^^b#6873790x99^"
process_color="^c#3B102B^^b#7E51680x99^"
signal=$(echo "^s$this^" | sed 's/_//')

[ ! "$(command -v playerctl)" ] && echo command not found: mpc && return

update() {
    status=$(playerctl -s status)
    length=$(playerctl metadata mpris:length | cut -d '.' -f 1)
    icon="  "
    content=""
    if [[ -z "$status" || $length -eq 0 ]]; then
        # content=" Get some music! "
        sed -i '/^export '$this'=.*$/d' $DWM/statusbar/temp
        printf "export %s=\"%s%s%s%s%s\"\n" $this "$signal" "$icon_color" "$icon " "$text_color" "$content" >> $DWM/statusbar/temp
    else
        position=$(playerctl position | cut -d '.' -f 1)

        for ((i=1; i<=6; i++)); do
            length=${length%?}
        done

        percent=$((position * 100 / length))
        content=$(playerctl metadata --format '{{ title }}')
        if [[ "$status" == "Playing" ]]; then
            icon=" "
        else
        icon=" "
        fi
        length=$((length))
        content=" $icon $content "
        content=$(echo $content | cut -c1-50)
        content_length=$((${#content}))

        tocolor=$((percent * content_length / 100))
        if [ $tocolor == 2 ]; then
            tocolor=3
        fi
        first=${content:0:$tocolor}
        second=${content:$tocolor}
        sed -i '/^export '$this'=.*$/d' $DWM/statusbar/temp
        printf "export %s=\"%s%s%s%s%s\"\n" $this "$signal" "$process_color"  "$first" "$text_color" "$second">> $DWM/statusbar/temp
    fi
}

call_musicfox() {
    mpdris2-rs --port 8700&
    st -t spad -c float -e musicfox
}

toggle_play_or_pause() {
    status=$(playerctl -s status)
    if [[ "$status" ]]; then
            playerctl play-pause
    fi
}

click() {
    case "$1" in
        L) toggle_play_or_pause ;;
        M) st -c float cava& ;;
        R) call_musicfox ;;
        U) playerctl next ;;
        D) playerctl previous ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac
