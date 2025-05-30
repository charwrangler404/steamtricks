#!/usr/bin/env bash

unsupported_shell () {
	echo "Your shell $SHELL is not supported by this install script"
	echo "You will need to manually install by extracting a tarball from"
	echo "https://github.com/charwrangler404/steamtricks/releases to your home folder"
	echo "and setting the STEAMTRICKS_PREFIX to your shell's environment, as well as"
	echo "$HOME/.steamtricks/bin to your PATH"
}

install () {
	mkdir ~/.steamtricks
	cp -r steamtricks/* ~/.steamtricks
	export SHELLPROFILE="~/.${1}rc"
	echo "export STEAMTRICKS_PREFIX=\"~/.steamtricks\"">>"${SHELLPROFILE}"
	echo "export PATH=\"\$PATH:$HOME/.steamtricks/bin\"">>${SHELLPROFILE}
	source "${SHELLPROFILE}"
}

install_manager () {
	case "$1" in
		bash | zsh | yash) install $1
			;;
		*) unsupported_shell
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
