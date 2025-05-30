#!/bin/sh

unsupported_shell () {
	echo "Your shell $SHELL is not supported by this install script"
	echo "You will need to manually install by extracting a tarball from"
	echo "https://github.com/charwrangler404/steamtricks/releases to your home folder"
	echo "and setting the STEAMTRICKS_PREFIX to your shell's environment, as well as"
	echo "$HOME/.steamtricks/bin to your PATH"
}

install () {
	export $SHELLPROFILE="$1"
	mkdir $HOME/.steamtricks
	cp -r steamtricks/* $HOME/.steamtricks
	echo "export STEAMTRICKS_PREFIX=\"~/.steamtricks\"">>"${SHELLPROFILE}"
	echo "export PATH=\"\$PATH:$HOME/.steamtricks/bin\"">>"${SHELLPROFILE}"

	echo "Install completed! Please source your profile $SHELLPROFILE to load the changes!"
}

install_manager () {
	case "$1" in
		bash | zsh | yash) install "$HOME/.${1}rc"
			;;
		sh ) install "$HOME/.profile"
			;;
		*) unsupported_shell
			;;
	esac
}

if [ "$EUID" -eq 0 ]; then
	echo "Please do not run this script as root"
	exit 1
fi

read -r -p "Would you like to install the multiple-install game manager? [y/N]" ANS

case "$ANS" in
	[yY]* ) install_manager "$(echo $SHELL | awk -F "/" '{print $NF}')"
	;;
	*) echo "Aborting with no change"; exit 1
	;;
esac
