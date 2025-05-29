#!/usr/bin/env bash

SHELLNAME=$(echo $SHELL | awk -F '/' '{print $NF}')
case "$SHELLNAME" in
  sh) echo "Shell not supported"; exit 1
  ;;
  bash | zsh) curl https://raw.githubusercontent.com/charwrangler404/steamtricks/refs/heads/main/multiple_install_manager.sh >> "${HOME}/.${SHELLNAME}rc"; echo "Installed to ${HOME}/.${SHELLNAME}rc"
  ;;
  *) echo "You will need to install this by manually adding it to either your /etc/profile for system-wide installation or to your shell's profile"
  ;;
esac
