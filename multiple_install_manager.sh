# STEAMPREFIX is simply the path to where your steam games are installed. My library is in /var/games, but you may change it to your liking
export STEAMPREFIX="/var/games/SteamLibrary/steamapps/common"

# This function will change symbolic links from your steamapps/common folder to the install location of whichever game you wish. I use this
# for managing stable and beta versions of Project Zomboid, but you can use them for any game
  
change_install () {
  if [ "$#" -lt 2 ]; then
    echo "Usage: change_install <GameFolder> <InstallLocation>"
    echo "Where GameFolder is the location of your game files"
    echo "and InstallLocation is where you'd like to link them."
    echo "GameFolder should be a renamed game folder in your steamapps/common folder"
    exit 1
  fi

  export GAMEFOLDER=${1}
  export INSTALLLOCATION=${2}
  echo "Please exit Steam now to prevent updating over a different version"
  echo "It's also recommended to add ${INSTALLLOCATION} to your exceptions"
  echo "in Steam to only update the game when you launch it"
  echo "(Enter to continue, CTRL+C to exit)"
  read

  unlink "${STEAMPREFIX}/${INSTALLLOCATION}"

  if [ "$?" -ne 0 ]; then
    echo "Unlink failed, have you followed the setup process?"
    exit 1
  fi
  
  ln -s "${STEAMPREFIX}/${GAMEFOLDER}" "${STEAMPREFIX}/${INSTALLLOCATION}"

  echo "You may start Steam now. Please remember to change your beta settings for ${GAMEFOLDER}"
  echo "to prevent from updating to a version you do not want in this location"

}

setup_install () {
  if [ "$#" -lt 2 ]; then
    export SHELLNAME=$(echo $SHELL | awk -F "/" '{print $NF}')
    echo "Usage: setup_install <GameFolder> <NewLocation>"
    echo "Where GameFolder is the install location in your steam prefix"
    echo "Please make sure to update your Steam Prefix to your library location"
    echo "if you are not using ${STEAMPREFIX} as your library location"
    echo "This variable can be found in your profile, also known as .${SHELLNAME}rc"
    exit 1
  fi
  export GAMEFOLDER=${1}
  export NEWLOCATION=${2}

  echo "Please quit Steam at this time"
  echo "(Enter to continue, CTRL+C to exit)"
  read
  
  echo "Moving ${STEAMPREFIX}/${GAMEFOLDER} to ${STEAMPREFIX}/${NEWLOCATION}"
  echo -n "Continue? [y/N]: "

  read ANS

  case "${ANS}" in
    y* | Y*) mv "${STEAMPREFIX}/${GAMEFOLDER}" "${STEAMPREFIX}/${NEWLOCATION}"
    ;;
    *) echo "Cancelling with no change"; exit 1
    ;;
  esac

  if [ "$?" -eq 0 ]; then
    echo "Game moved successfully!"
    echo "You may now start Steam and install a different version of the game."
    echo "To make the game playable, please run:"
    echo "change_install ${NEWLOCATION} ${GAMEFOLDER}"
  else
    echo "Game could not be moved. Please check your command and try again."
    echo "Remember that file paths are case-sensitive on Linux"
    exit 1
  fi

}
