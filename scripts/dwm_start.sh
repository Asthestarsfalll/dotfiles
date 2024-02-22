#!/usr/bin/sh
fcitx5 &
screen_count=$(xrandr | grep 'connected' -w | wc -l)
if [ ${screen_count} -gt 1 ];then
  xrandr --output eDP-1 --off
  xrandr --output DP-2 --mode 2560x1440 
fi
rm ~/scripts/statusbar/temp
# feh --randomize --bg-fill /data/data/wallpaper/1a3b07858a099b22841e647f6daf4237.jpeg
feh --randomize --bg-fill /data/data/wallpaper/1.png
picom --config ~/.config/picom/picom.conf &
sh $HOME/scripts/statusbar/statusbar.sh cron &
dunst -conf ~/.config/dunst/dunstrc &
# sh ~/scripts/lemonbar/launch.sh &

