echo "Update config of LunarVIM" | lolcat

ls -1 ~/.config/lvim
cp -r ~/.config/lvim/* ./LunarVim/Linux/lvim/

echo "Update config of fish" | lolcat

ls -1 ~/.config/fish
cp -r ~/.config/fish/* ./Fish/


echo "Update config of oh-my-fish" | lolcat

ls -1 $OMF_PATH/themes/agnoster/functions
cp -r $OMF_PATH/themes/agnoster/functions/* ./oh-my-fish/theme/
