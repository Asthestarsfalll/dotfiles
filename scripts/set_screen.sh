screen_count=$(xrandr | grep 'connected' -w | wc -l)
if [ ${screen_count} -gt 1 ];then
  xrandr --output eDP-1 --off
  xrandr --output DP-2 --mode 2560x1440 
fi
feh --randomize --bg-fill ~/download/1a3b07858a099b22841e647f6daf4237.jpeg
