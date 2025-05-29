#!/usr/bin/env bash

list_tools () {
	echo "Available tools in this version:"
	echo "sim 	Steamtricks Install Manager"
}

test_enable () {


steamtricks_enable () {
	if [ "$#" -ne 1 ]; then
		echo "Usage:"
		echo "steamtricks_enable <tool>"
		list_tools
		exit 1
	fi

	source "${STEAMTRICKS_PREFIX}/steamtricks.conf"

	case "${1}" in
		sim | SIM)
}


local sed_steam_prefix () {
	export SHELLPROFILE="${1}"
	while true; do
		read -r -p "What would you like your STEAMPREFIX to be?: " ANS1
		read -r -p "is ${ANS1} correct?" ANS2
		case "${ANS2}" in
			[yY]* ) echo "s|STEAMPREFIX=.?|STEAMPREFIX=\"${ANS1}\"|g" >>"/tmp/steamprefix.sed"; sed -i -f "/tmp/steamprefix.sed" "${SHELLPROFILE}"; break
				;;
			*) 
				;;
		esac
	done
}

edit_steam_prefix () {
	export SHELLPROFILE="${1}"
		
	echo "Your prefix is currently set to: ${STEAMPREFIX}"
	echo "If this is not where you install your games,"
	echo "you will need to set it to the path where your"
	echo "steamapps/common folder exists."

	echo ""
	echo "Some common defaults: "
	echo "1: /var/games/SteamLibrary/steamapps/common - Default"
	echo "2. ~/.var/app/com.valvesoftware.Steam/data/Steam/steamapps/common - flatpak default"
	echo "3. ~/.steam/steam/steamapps/common - system package default"
	echo "4. ~/.local/share/steam/steamapps/common - old system package default"
	echo "5. I have changed it, enter a custom path"

	while true; do
		read -r -p "Choice [1-5]: " ANS
		case "$ANS" in
			1) sed -i 's|STEAMPREFIX=.?$|STEAMPREFIX="/var|games/SteamLibrary/steamapps/common"|g' "${SHELLPROFILE}"; break
				;;
			2) sed -i 's|STEAMPREFIX=.?$|STEAMPREFIX="~/.var/app/com.valvesoftware.Steam/data/Steam/steamapps/common"|g' "${SHELLPROFILE}"; break
				;;
			3) sed -i 's|STEAMPREFIX=.?$|STEAMPREFIX="~/.steam/steam/steamapps/common"|g' "${SHELLPROFILE}"; break
				;;
			4) sed -i 's|STEAMPREFIX=.?$|STEAMPREFIX="~/.local/share/steam/steamapps/common"|g' "${SHELLPROFILE}"; break
				;;
			5) sed_steam_prefix; break
				;;
			*) echo "Please select an option between 1 and 5"
				;;
		esac
	done

}

steam_prefix_config () {
	export SHELLPROFILE="~/.${1}rc"
	source "~/.${1}rc"
	echo "The current STEAMPREFIX variable is set to ${STEAMPREFIX}"
	echo -n  "Do you wish to change this? [y/N]: "
	read ANS

	case "$ANS" in
		y* | Y* ) sed_prefix "${SHELLPROFILE}"
			;;
		* ) echo "Installation complete"
			;;
	esac

}
