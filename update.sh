echo "Update config of LunarVIM" | lolcat

ls -1 ~/.config/lvim
cp -r ~/.config/lvim/* ./LunarVim/Linux/lvim/

echo "Update config of fish" | lolcat

ls -1 ~/.config/fish
cp -r ~/.config/fish/* ./Fish/


echo "Update config of oh-my-fish" | lolcat

ls -1 $OMF_PATH/themes/agnoster/functions
cp -r $OMF_PATH/themes/agnoster/functions/* ./oh-my-fish/theme/

echo "Update config of picom" | lolcat

ls -1 ~/.config/picom/
cp ~/.config/picom/picom.conf ./picom/


echo "Update config of rofi" | lolcat

ls -1 ~/.config/rofi/
cp ~/.config/rofi/config.rasi ./rofi/config.rasi
cp /usr/share/rofi/themes/arthur.rasi ./rofi/arthur.rasi

echo "Update scripts" | lolcat

ls -1 ~/scripts/
cp -r ~/scripts/* ./scripts/


echo "Update wezterm" | lolcat

ls -1 ~/.config/wezterm/
cp -r ~/.config/wezterm/* ./wezterm/

