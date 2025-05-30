#!/usr/bin/env sh

export DOWNLOADURL=""

unsupported_shell () {
	echo "Your shell $SHELL is not supported by this install script"
	echo "You will need to manually install by extracting a tarball from"
	echo "https://github.com/charwrangler404/steamtricks/releases to your home folder"
	echo "and setting the STEAMTRICKS_PREFIX to your shell's environment, as well as"
	echo "$HOME/.steamtricks/bin to your PATH"
}

install () {
	export SHELLPROFILE="$1"
  curl "$DOWNLOADURL" | tar -xvC $HOME/ || echo "Could not install steamtricks" && exit 1
	chmod 755 $HOME/.steamtricks/bin/steamtricks

  if [ -z "$STEAMTRICKS_PREFIX" ]; then
		echo "export STEAMTRICKS_PREFIX=\"$HOME/.steamtricks\"">>"${SHELLPROFILE}"
	fi

  if [ -z "$(echo $PATH | grep 'steamtricks')" ]; then
    echo 'export PATH="$PATH:~/.steamtricks/bin"'>>${SHELLPROFILE}
  fi
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

SHELLNAME=$(echo $SHELL | awk -F '/' '{print $NF}')

install_manager $SHELLNAME