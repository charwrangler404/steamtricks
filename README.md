# steamtricks
This is a repository of my Steam hacks to allow things such as multiple installs of the same game

## Determining how you've installed Steam

The easiest way to find out if you've installed Steam as a flatpak or from your package manager is to run the following command:

  $ flatpak list | grep Steam
  Steam	com.valvesoftware.Steam	1.0.0.81	stable	system

If you get any output that does not look similar to the above, you have Steam installed through your package manager and can skip the next section.

## Installation



## Notes on setup with a flatpak Steam

NOTE: IF YOU DO NOT KNOW WHERE YOUR STEAM GAMES ARE INSTALLED, FIND THIS OUT FIRST

You will need to know where your steam games live on your system for any of this to work.

If you're using a flatpak (the recommended method) you will need to ensure your games are installed OUTSIDE of the flatpak container.
This can be done by installing the flatseal flatpak and modifying the permissions of your flatpak to allow it to access files outside of the container.

ALLOWING STEAM TO ACCESS ANY FOLDER UNDER `/home` WILL BREAK YOUR STEAM INSTALL AND THAT PERMISSION WILL NEED TO BE REMOVED TO START STEAM

The default that I use is to put my Steam library under `/var/games`. If you do not know what you are doing, this is probably the best option.
Whatever you do, make sure that your install has enough space in `/var` to install all the games you wish to play. You can use the `df -h` command to
let you know how much space you have free on your system, and where it is.  Some Linux install defaults include VERY SMALL `/var` partitions
and filling it up with files as you try to install games is a sure-fire way to CRASH YOUR SYSTEM. I mount a 4TB ssd to /var/games in my setup to prevent this.

If you do not know how to set this up, I recommend you read about `/etc/fstab` for automouting it on boot. If it's encrypted (not recommended for a games-only
drive) you will also need to read about `/etc/crypttab`. Setting up encrypted game installs is outside of the scope of this article.

If you're willing to mess around a bit until I get some proper variable management set up, you can install your games somewhere else. Other good options
include somewhere under `/opt`. That's probably about it as far as good places to put your games. If you want to know more about which files you will need
to edit to change the path to something other than `/var/games`, read the below section as well.


## Notes on setup with a system package Steam

If you installed Steam with a system pacakage manager (apt, yum, dnf, etc) and NOT flatpak, you can ignore the above section, but will need to edit the STEAMPREFIX
variable in your shell profile after install. As far as to where this variable is located, it depends on your shell. You can find out the name of your shell with the
following command:

  echo $SHELL | awk -F "/" '{print $NF}'

The most common shells include `bash`, `sh`, and `zsh`. If you do not have one of these shells, you should do some googling to find out where your shell profile is located/
The `sh` shell is unsupported. If you have this as your main shell, either something is very wrong with your system or you know enough to figure out what I'm doing in the script
and can engineer your own solution. `bash` and `zsh` shell profiles are located in `~/.bashrc` and `~/.zshrc`, respectively. As they are "dotfiles" they are hidden from commands and the file
viewer by default, so if you want to list them in the shell or your file browser, you will need to either use `ls -la` or find out how to show hidden files in your graphical file browser.

This is the script that will be added to your profile in your shell, allowing you access to the following commands

  setup_install
  change_install

The `setup_install` command essentially renames an existing install 
