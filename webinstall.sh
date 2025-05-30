#!/usr/bin/env bash

export DOWNLOADURL=""

install_steamtricks () {
  export SHELLNAME="$1"
  export SHELLPROFILE="$HOME/.${SHELLNAME}rc"
  mkdir -p ~/.steamtricks && curl "$DOWNLOADURL" | tar -xvC ~/.steamtricks/ || echo "Could not install steamtricks"
  echo "export STEAMTRICKS_PREFIX=\"$HOME/.steamtricks\"">>$SHELLPROFILE
  echo 'export PATH="$PATH:$HOME/.winetricks/bin"'>>$SHELLPROFILE
  echo "Installation complete! Please source your profile to apply changes"
}

install_steamtricks_sh () {
  export $SHELLPROFILE="$HOME/.profile"
  mkdir -p $HOME/.steamtricks && curl "$DOWNLOADURL" | tar -xvC $HOME/.steamtricks/ || echo "Could not install steamtricks"
  echo "export STEAMTRICKS_PREFIX=\"$HOME/.steamtricks\"">>$SHELLPROFILE
  echo 'export PATH="$PATH:$HOME/.winetricks/bin"'>>$SHELLPROFILE
  echo "Installation complete! Please source your profile to apply changes"
}

if [ "$EUID" -eq 0 ]; then
  echo "Please do not run this script as root"
  exit 1
fi

SHELLNAME=$(echo $SHELL | awk -F '/' '{print $NF}')
case "$SHELLNAME" in
  sh) install_steamtricks_sh
  ;;
  bash | zsh | yash) install_steamtricks "$SHELLNAME"
  ;;
  *) echo "You will need to install this by manually adding it to either your /etc/profile for system-wide installation or to your shell's profile"
  ;;
esac
