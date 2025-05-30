# steamtricks
This is a repository of my Steam hacks to allow things such as multiple installs of the same game

## Installation

There are two methods of installing this project. The first requires git:

    git clone  https://github.com/charwrangler404/steamtricks.git && cd steamtricks && git checkout latest
    ./install.sh

And the single-command method requires curl:

    curl https://raw.githubusercontent.com/charwrangler404/steamtricks/refs/heads/main/webinstall.sh | sh

## steamtricks.conf

The steamtricks.conf file has some specific requirements. If you have not created a steamtricks.conf file when you run steamtricks for the first time, the 
main script will create one for you with sane defaults. The default assumption when creating the steamtricks.conf file is that you are running a flatpak 
version of Steam with all your games installed inside the container. If this is not the case, you will need to change the `steam_prefix` variable in the
`[general]` section of the config file to match the absolute path of your `steamapps/common` directory.

### `[general]` Section header

The `[general]` section header currently has one required variable, `steam_prefix`. This variable tells steamtricks where to look for your steam games.
The default value is listed below. If this is not where your Steam games are installed, you will need to change this variable in order for steamtricks to
work correctly.

    steam_prefix=/home/<username>/.var/app/com.valvesoftware.Steam/data/Steam/steamapps/common

The `steamtricks` executable will evaluate the $HOME environment variable when creating the config file. Due to limitations of the path evaluation of the script,
shortcuts (such as ~) will not function as expected and will cause steamtricks to be unable to find your steam files.

### `[install_manager]` Section Header

The `[install_manager]` section header has one required variable, `managed_games[]` which may be added as many times as necessary and may be empty. It is 
required to have at minimum one instance of this variable that may be blank. The `managed_games[]` variable is managed by the config generation section of the
steamtricks script and does not require any manual intervention. It keeps track of managed installs of games to support future features that are on the roadmap
but has no use at this time. You should not set the variable directly, rather let it be auto-populated by prompts in the script.

## Roadmap

- [ ] Add a version selection dialog
- [ ] Add a game selection dialog
- [ ] Add prompts to tell user when to restart Steam and any other actions required of them to maintain the installs
- [ ] Transition to Perl implementation

## Miscellaneous Resources

If you wish to see what other resources I've bookmarked as good reading for those who game with Steam on linux, here's a page of [resources](resources.md) that 
you may consult for further reading.