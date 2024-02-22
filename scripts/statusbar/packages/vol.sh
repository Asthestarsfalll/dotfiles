#! /bin/bash
# VOL 音量脚本
# 本脚本需要你自行修改音量获取命令
# 例如我使用的是 pipewire
#
# $ pactl lisk sinks | grep RUNNING -A 8
#         State: RUNNING
#         Name: bluez_output.88_C9_E8_14_2A_72.1
#         Description: WH-1000XM4
#         Driver: PipeWire
#         Sample Specification: float32le 2ch 48000Hz
#         Channel Map: front-left,front-right
#         Owner Module: 4294967295
# 静音 -> Mute: no                                                                                 
# 音量 -> Volume: front-left: 13183 /  20% / -41.79 dB,   front-right: 13183 /  20% / -41.79 dB

# source ~/.profile
DWM=$HOME/scripts

this=_vol
text_color="^c#000080^^b#7879560x99^"
muted_color="^c#442266^^b#7879560x99^"
empty_color="^c#442266^^b#7879560x99^"
signal=$(echo "^s$this^" | sed 's/_//')

update() {
    bar_icon=''
    # sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
    # volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep 'Mute: no')
    # vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
    # vol_text=$(amixer get Master | grep 'Right:' | grep  -Po  '\[\K[^]%]*' | head -n 1)
    vol_text=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | cut -d % -f 1)
    muted=$(amixer sget Master | grep off)

    if [ "$vol_text" -eq 0 ];  then vol_text="00"; vol_icon=" 婢";
    elif [ "$vol_text" -lt 10 ]; then vol_icon=" 奔"; vol_text=0$vol_text;
    elif [ "$vol_text" -le 50 ]; then vol_icon=" 奔";
    else vol_icon=" 墳"; fi


    if [[ "$muted" ]]; then
        vol_icon=" 婢"
        # text="${bar_icon}$(printf "%9s")"
        # text=${text// /$bar_icon}
        # text=" $text "
        text=' '
        sed -i '/^export '$this'=.*$/d' $DWM/statusbar/temp
        printf "export %s='%s%s%s%s'\n" $this "$signal" "$muted_color" "$vol_icon" "$text" >> $DWM/statusbar/temp
    else
        vol=$((vol_text))
        vol=$((vol/10-1))
        # echo $vol
        # icon=" $vol_icon "
        # text=" $vol_text% "
        text="${bar_icon}$(printf "%${vol}s")"
        text=${text// /$bar_icon}
        echo "$vol_text%"
        
        em_len=$((8-vol))
        em="${bar_icon}$(printf "%${em_len}s")"
        em=${em// /$bar_icon}
        sed -i '/^export '$this'=.*$/d' $DWM/statusbar/temp
        # printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$icon_color" "$icon" "$text_color" "$text" >> $DWM/statusbar/temp
        printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$text_color" "$vol_icon $text" "$empty_color" "$em " >> $DWM/statusbar/temp
    fi

}

notify() {
    notify-send -r 9527 Volume "$(update)" -i audio-volume-medium
}

call_vol() {
    # pid1=`ps aux | grep 'st -t statusutil' | grep -v grep | awk '{print $2}'`
    # pid2=`ps aux | grep 'st -t statusutil_cpu' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    # kill $pid1 && kill $pid2 ||st -t statusutil_cpu -g 82x25+$((mx - 328))+$((my + 20)) -c noborder -e btop
    st -t statusutil_vol -g 45x20+$((mx - 328))+$((my + 20)) -c FNG -e alsamixer
} 

click() {
    case "$1" in
        M) notify                                           ;; # 仅通知
        # M) pactl set-sink-mute @DEFAULT_SINK@ toggle        ;; # 切换静音
        L) amixer set Master toggle -q; notify ;; 
        R) call_vol            ;; # 打开pavucontrol
        # U) pactl set-sink-volume @DEFAULT_SINK@ +5%; notify ;; # 音量加
        # D) pactl set-sink-volume @DEFAULT_SINK@ -5%; notify ;; # 音量减

        U) amixer set Master 5%+ -q; notify ;; # 音量加
        D) amixer set Master 5%- -q; notify ;; # 音量加
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac
