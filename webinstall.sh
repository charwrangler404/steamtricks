#!/usr/bin/env bash

export DOWNLOADURL=""

install_steamtricks () {
  export SHELLNAME="$1"
  export SHELLPROFILE="$HOME/.${SHELLNAME}rc"
  mkdir -p ~/.steamtricks && curl "$DOWNLOADURL" | tar -xvC ~/.steamtricks/ || echo "Could not install steamtricks"
  echo "export STEAMTRICKS_PREFIX=\"$HOME/.steamtricks\"">>$SHELLPROFILE
  echo 'export PATH="$PATH:$HOME/.winetricks/bin"'>>$SHELLPROFILE
}

SHELLNAME=$(echo $SHELL | awk -F '/' '{print $NF}')
case "$SHELLNAME" in
  sh) echo "Shell not supported"; exit 1
  ;;
  bash | zsh | yash) install_steamtricks "$SHELLNAME"
  ;;
  *) echo "You will need to install this by manually adding it to either your /etc/profile for system-wide installation or to your shell's profile"
  ;;
esac
