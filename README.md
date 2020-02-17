# gimpy: a slightly more awesome awesome
A modularized and battle-tested configuration setup for awesomewm. Some user-specific leftovers remain, but for the most part this can be used out of the box. 

Features:
* Split across many files and functions into easy-to-digest pieces
* A system for conditionally initializing various programs/terminals on start/restart
* Support for modifying the layout on start/restart
* Async statusbar updates for connection/battery status (and VPN status, if relevant)
* Working battery status out of the box (including for laptops with multiple batteries!)
* A decade+ of useful keybindings and sane defaults for power users

## Installation:
Back up any existing local awesome config, if you have one:
    mv ~/.config/awesome/ ~/.config/OLD_AWESOME_BACKUP/

Then clone directly into the awesome config directory:
    git clone https://github.com/MrAwesome/gimpy.git ~/.config/awesome/
