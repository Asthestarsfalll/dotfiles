#! /bin/bash

# source ~/.profile
DWM=$HOME/scripts
this=_wifi
# color="^c#442266^^b#385056^"
icon_color="^c#000080^^b#3870560x88^"
text_color="^c#000080^^b#3870560x99^"
signal=$(echo "^s$this^" | sed 's/_//')
# check
[ ! "$(command -v nmcli)" ] && echo command not found: nmcli && exit

# 中英文适配
wifi_grep_keyword="已连接 到"
wifi_disconnected="未连接"
# wifi_disconnected_notify="未连接到网络"
# if [ "$LANG" != "zh_CN.UTF-8" ]; then
#     wifi_grep_keyword="connected to"
#     wifi_disconnected="disconnected"
#     wifi_disconnected_notify="disconnected"
# fi

update() {
    wifi_icon="直"
    wifi_text=$(nmcli | grep "$wifi_grep_keyword" | awk -F "$wifi_grep_keyword" '{print $2}')
    [ "$wifi_text" = "" ] && wifi_text=$wifi_disconnected

    icon=" $wifi_icon "
    text="$wifi_text "

    sed -i '/^export '$this'=.*$/d' $DWM/statusbar/temp
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$icon_color" "$icon" "$text_color" "$text" >> $DWM/statusbar/temp
}

notify() {
    update
    notify-send -r 9527 "$wifi_icon Wifi" "\n$wifi_text"
}

call_nm() {
    pid1=`ps aux | grep 'st -t statusutil' | grep -v grep | awk '{print $2}'`
    pid2=`ps aux | grep 'st -t statusutil_nm' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    kill $pid1 && kill $pid2 || st -t statusutil_nm -g 60x25+$((mx - 240))+$((my + 20)) -c FGN -e 'nmtui-connect'
}

click() {
    case "$1" in
        L) notify ;;
        R) call_nm ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac

