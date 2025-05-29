#!/usr/bin/env bash

case "$(echo $SHELL | awk -F '/' '{print $NF}')" in
  sh) echo "Shell not supported"; exit 1
  ;;
  bash | zsh) curl https://raw.githubusercontent.com/charwrangler404/steamtricks/refs/heads/main/multiple_install_manager.sh >> "${HOME}/.${1}rc"; echo "Installed to ${HOME}/.${1}rc"
  ;;
  *) echo "You will need to install this by manually adding it to either your /etc/profile for system-wide installation or to your shell's profile"
  ;;
esac
