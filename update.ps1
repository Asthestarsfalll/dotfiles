echo "Update config of powershell"
cp -force $PROFILE ./powershell/

echo "Update config of oh-my-posh"
cp -force $env:POSH_THEMES_PATH\M365* ./oh-my-posh/
