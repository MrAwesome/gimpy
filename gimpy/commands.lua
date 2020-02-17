local globals = require("gimpy/globals")

local commands = {}
commands.browser = "google-chrome-stable &> /dev/null " 
-- commands.slow_paste     = 
--   'xvkbd -no-jump-pointer -xsendevent -text "\\D1`xsel`" 2>/dev/null'
commands.paste = 'xdotool getwindowfocus key --window %1 shift click 2'
commands.chat = globals.terminal .. " -title finch -e bash -c finch"
commands.notes = globals.terminal .. " -title hnb -e bash -c hnb"
commands.wlclient = globals.terminal .. " -title wicd-curses -e bash -c wicd-curses"
commands.filebrowser = "dbus-launch nautilus --no-desktop --browser"
commands.screenshot = "scrot -e 'mv $f ~/screenshots'"
commands.screenshot_draw  = "sleep 1; scrot -s /tmp/$(date +'%Y-%m-%d_%H:%M:%S').png"
commands.screenshot_active_window  = "scrot -u -e 'mv $f ~/screenshots'"
commands.screenshotwindow  = "scrot -s -e 'mv $f ~/screenshots'"
commands.dropbox = "killall dropbox; dropboxd"
commands.pomodoro_kill = "kill $(pgrep -f pomodoro | grep -v ^$$\\$); "
commands.pomodoro_prompt = "notify-send -u critical -t 2000 'mod4-p to take a pomodoro'; "
commands.pomodoro_warning = "notify-send -t 2000 '1 minute left in pomodoro'; "
commands.pomodoro_notify = "notify-send -t 2000 'started pomodoro'; "
commands.lockscreen = "xlock -mode hyper -erasedelay 0 -usefirst && " .. commands.pomodoro_prompt
commands.pomodoro = 
  commands.pomodoro_kill .. 
  commands.pomodoro_notify .. 
  " sleep 1400; " .. 
  commands.pomodoro_warning .. 
  "xlock -mode flag -erasedelay 0 -usefirst -message 'break' && " .. 
  commands.pomodoro_prompt
commands.pingoog = 
  "if timeout 1 ping -c 1 8.8.8.8 &> /dev/null; " ..
  "then echo; else echo BROKAN; " ..
  "fi"
commands.pingdev = 
  "if timeout 1 ping -6 -c 1 devbig577.prn2.facebook.com &> /dev/null; " ..
  "then echo VPN; else echo; " ..
  "fi"

commands.one_screen = "/home/glenn/bin/screens/onescreen.sh"
commands.meeting_room = "/home/glenn/bin/screens/meetingroom.sh"
commands.two_screens = "/home/glenn/bin/screens/twoscreens.sh"
commands.hdmi = "/home/glenn/bin/screens/hdmi.sh"

-- LXC settings
commands.lxc_settings = 
  "export ' ' TERM=screen ';' ' ' export ' ' " ..
  "PS1=\\\''[\\u@$(hostname | sed s,.facebook.com,,) \\W]\\$ '\\\' ';' " ..
  "' ' export ' ' ls=\\\'ls ' ' --color=auto\\\' ';' " ..
  "' ' source ' ' /etc/twenv.sh"
commands.awk_print = "\\\'\\{print ' ' \\$1\\}\\\' ' '"

commands.xdotool_echo = "sleep .3; xdotool type "
commands.echo_lxc_settings = commands.xdotool_echo .. commands.lxc_settings
commands.respawn_cmd_shell = 
  "sleep .3; xdotool key --delay 10 ctrl+d Return Up Return"
commands.echo_awk_print = commands.xdotool_echo .. commands.awk_print
commands.terminal_white = globals.terminal .. " -bg white -fg black"
commands.minecraft = "java -jar /home/glenn/minecraft.jar"

-- Alias-style macros
commands.tmux_screen_switch = "xdotool key ctrl+b l"

-- Keyboard Layout Commands
commands.qwerty  = "setxkbmap us"
commands.colemak = "setxkbmap us -variant colemak"

-- Screen manipulation (brightness, color, whatever)
commands.brightness_up   = "xbacklight -inc 5"
commands.brightness_down = "xbacklight -dec 5"
commands.brightness_max  = "xbacklight -set 100"
commands.brightness_min  = "xbacklight -set 5"

-- Music Player Commands
commands.spotify = {}
commands.spotify.launch = "spotify &> /dev/null"
commands.spotify.currsong = "~/bin/spotify_get_song.sh"
commands.spotify.toggle = "playerctl play-pause"
commands.spotify.pause = "playerctl pause"
commands.spotify.prevsong = "playerctl previous"
commands.spotify.nextsong = "playerctl next"

-- Sound Commands
commands.soundcontrol = globals.float_terminal_cmd .. " -c pulsemixer"
commands.masterdown = "amixer sset 'Master' 2%- >> /dev/null"
commands.masterup = "amixer sset 'Master' 2%+ >> /dev/null"
commands.mastermute = "amixer sset 'Master' mute >> /dev/null"
commands.masterunmute = "amixer sset 'Master' unmute >> /dev/null"
commands.frontdown = "amixer sset 'Front' 2%- >> /dev/null"
commands.frontup = "amixer sset 'Front' 2%+ >> /dev/null"

-- Default music player
commands.musicplayer = commands.spotify

return commands

-- vim: ft=lua sts=2 sw=2
