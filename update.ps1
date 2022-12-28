echo "Update config of LunarVIM" 
cp -r -force ~/.local/bin/*.ps1 ./LunarVim/Window11/
cp -force $env:LUNARVIM_CONFIG_DIR/* ./LunarVim/Window11/lvim/

echo "Update config of powershell"
cp -force $PROFILE ./powershell/

echo "Update config of oh-my-posh"
cp -force $env:POSH_THEMES_PATH\M365* ./oh-my-posh/
