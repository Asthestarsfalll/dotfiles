echo "set back-up" | lolcat
echo "Update config of LunarVIM" | lolcat

ls -1 ~/.config/lvim
cp -r ~/.config/lvim/* ./backup/LunarVim/Linux/lvim/

echo "Update config of fish" | lolcat

ls -1 ~/.config/fish
cp -r ~/.config/fish/* ./backup/Fish/


echo "Update config of oh-my-fish" | lolcat

ls -1 $OMF_PATH/themes/agnoster/functions
cp -r $OMF_PATH/themes/agnoster/functions/* ./backup/oh-my-fish/theme/


echo "set config" | lolcat
echo "set config of LunarVIM" | lolcat

ls -1 ./LunarVim/Linux/lvim/
cp -r ./LunarVim/Linux/lvim/ ~/.config/ 

echo "set config of fish" | lolcat

ls -1 ./Fish/
cp -r ./Fish/* ~/.config/fish/

echo "set config of oh-my-fish" | lolcat

ls -1 ./oh-my-fish/theme/
cp -r ./oh-my-fish/theme/* $OMF_PATH/themes/agnoster/functions/
