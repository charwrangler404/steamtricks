#!/usr/bin/env bash

install_manager () {
  case "$1" in
    sh) echo "Shell not supported"; exit 1
    ;;
    bash | zsh) curl https://raw.githubusercontent.com/charwrangler404/steamtricks/refs/heads/main/multiple_install_manager.sh >> "${HOME}/.${1}rc"
    ;;
    *) echo "You will need to install this by manually adding it to either your /etc/profile for system-wide installation or to your shell's profile"
    ;;
  esac
}

echo "Would you like to install the multiple-install game manager?"
echo -n "[y/N]: "
read ANS

case "$ANS" in
  y* | Y* ) install_manager $(echo $SHELL | awk -F "/" '{print $NF}')
  ;;
  *) echo "Aborting with no change"; exit 1
  ;;
esac
