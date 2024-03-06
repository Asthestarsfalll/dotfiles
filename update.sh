#! /bin/sh

update_config() {
	config_dir="$1"
	echo "Update config of $config_dir" | lolcat
	source_dir="$HOME/.config/$config_dir"
	dest_dir="./$config_dir/"

	if [ "$config_dir" = "scripts" ]; then
		source_dir="$HOME/scripts"
	fi

	if [ -d "$source_dir" ]; then
		echo "Copying files from $source_dir to $dest_dir"
		cp -r "$source_dir"/* "$dest_dir"
	else
		echo "Source directory $source_dir not found."
	fi
}

if [ -z "$1" ]; then
	update_config "oh-my-fish/theme"
	update_config "picom"
	update_config "scripts"
	update_config "wezterm"
	update_config "yazi"
	update_config "hypr"
	update_config "waybar"
else
	update_config "$1"
fi
