#! /bin/sh

backup_and_set_config() {
	config_dir="$1"
	source_dir=""
	dest_dir=""

	echo "Backup and Set $config_dir" | lolcat

	# Backup config
	source_dir="$HOME/.config/$config_dir"
	dest_dir="./backup/$config_dir/"
	move_dir="$HOME/.config/$config_dir/"

	mkdir -p "$dest_dir"

	if [ "$config_dir" = "scripts" ]; then
		source_dir="$HOME/scripts"
		move_dir="$source_dir"
	fi

	if [ -d "$source_dir" ]; then
		echo "Backing up $config_dir..."
		cp -r "$source_dir"/* "$dest_dir"
	else
		echo "Source directory $source_dir not found."
	fi

	# Set config
	source_dir="./$config_dir"

	if [ -d "$source_dir" ]; then
		echo "Setting $config_dir..."
		cp -r "$source_dir"/* "$move_dir"
	else
		echo "Source directory $source_dir not found."
	fi
}

if [ -z "$1" ]; then
	backup_and_set_config "fish"
	backup_and_set_config "oh-my-fish/theme"
	backup_and_set_config "scripts"
	backup_and_set_config "wezterm"
	backup_and_set_config "hypr"
	backup_and_set_config "waybar"
else
	backup_and_set_config "$1"
fi
