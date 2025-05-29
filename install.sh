#!/usr/bin/env bash
install () {
	mkdir ~/.steamtricks
	cp src/* ~/.steamtricks
	export SHELLPROFILE="~/.${1}rc"
	echo "export STEAMTRICKS_PREFIX=\"~/.steamtricks\"">>"${SHELLPROFILE}"
	echo "source ~/.steamtricks/steamtricks.conf">>"${SHELLPROFILE}"
	source "${SHELLPROFILE}"
	edit_prefix

}

install_manager () {
	case "$1" in
		sh | fish) echo "Shell ${SHELL} not supported"; exit 1
			;;
		bash | zsh | yash) install
			;;
		*) echo "You will need to install this by manually adding it to either your /etc/profile for system-wide installation or to your shell's profile"
			;;
	esac
}



read -r -p "Would you like to install the multiple-install game manager? [y/N]" ANS
case "$ANS" in
	[yY]* ) install_manager "$(echo $SHELL | awk -F "/" '{print $NF}')"
	;;
	*) echo "Aborting with no change"; exit 1
	;;
esac
