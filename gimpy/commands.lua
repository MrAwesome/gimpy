local globals = require("gimpy/globals")

local commands = {}
commands.browser = "~/bin/run-browser.sh "
commands.kill_browser = "killall firefox "
commands.signal_desktop = "signal-desktop &> /dev/null "
-- commands.slow_paste     =
--   'xvkbd -no-jump-pointer -xsendevent -text "\\D1`xsel`" 2>/dev/null'
-- Doesn't work correctly:
-- commands.paste = 'xdotool getwindowfocus key --window %1 shift click 2'
--

commands.paste = "/home/glenn/bin/get_window_paste_xdotool_command.sh"

commands.notes = globals.terminal .. " -title hnb -e bash -c hnb"
commands.filebrowser = "dbus-launch nautilus --no-desktop --browser"
commands.networking_wifi = "sudo ruwi -m dmenu wifi connect -a"
commands.linepw = "xsel < ~/.linepw"
commands.emailaddr = "xsel < ~/.emailaddr"
local image_to_clipboard = " | xclip -selection clipboard -target image/png"
commands.screenshot = "maim -u | tee ~/screenshots/$(date +'%Y-%m-%d_%H:%M:%S').png" .. image_to_clipboard
commands.screenshot_draw  = "sleep 1; maim -u -s | tee ~/screenshots/$(date +'%Y-%m-%d_%H:%M:%S').png" .. image_to_clipboard
commands.screenshot_active_window  = "maim -i $(xdotool getactivewindow) -u | tee ~/screenshots/$(date +'%Y-%m-%d_%H:%M:%S').png" .. image_to_clipboard
commands.screenshotwindow  = "maim -s -e 'mv $f ~/screenshots'"
commands.dropbox = "killall dropbox; dropboxd"
commands.pomodoro_kill = "kill $(pgrep -f pomodoro | grep -v ^$$\\$); "
commands.pomodoro_prompt = "notify-send -u critical -t 2000 'mod4-p to take a pomodoro'; "
commands.pomodoro_warning = "notify-send -t 2000 '1 minute left in pomodoro'; "
commands.pomodoro_notify = "notify-send -t 2000 'started pomodoro'; "
commands.lockscreen = "xlock -mode hyper -erasedelay 0 -usefirst && " .. commands.pomodoro_prompt
commands.translate_to_english  = globals.float_terminal_cmd .. " -c 'echo To English...;  echo; read -e | trans -b -t en-US | tee >(xsel); read'"
commands.translate_to_mandarin = globals.float_terminal_cmd .. " -c 'echo To Mandarin...; echo; read -e | trans -b -t zh-TW | tee >(xsel); read'"
commands.pomodoro =
  commands.pomodoro_kill ..
  commands.pomodoro_notify ..
  " sleep 1400; " ..
  commands.pomodoro_warning ..
  "xlock -mode flag -erasedelay 0 -usefirst -message 'break' && " ..
  commands.pomodoro_prompt
commands.pingoog =
  "if timeout 1 ping -c 1 8.8.8.8 &> /dev/null; " ..
  "then :; else echo BROKAN; " ..
  "fi"
commands.pingdev =
  "if timeout 1 ping -c 1 10.8.0.1 &> /dev/null; " ..
  "then echo VPN; else :; " ..
  "fi"

commands.pingeu =
  "if timeout 1 ping -c 1 10.9.0.1 &> /dev/null; " ..
  "then echo EU; else :; " ..
  "fi"

commands.checkgpu = '/home/glenn/bin/getgpumode.sh'

commands.one_screen = "/home/glenn/bin/screens/onescreen.sh"
commands.meeting_room = "/home/glenn/bin/screens/meetingroom.sh"
--commands.two_screens = "/home/glenn/bin/screens/twoscreens.sh"
commands.hdmi = "/home/glenn/bin/screens/hdmi_only.sh"

commands.toggle_touchpad_click = "x=$(synclient | grep TapButton1 | awk '{print $3}'); synclient TapButton1=$((1-$x))"
commands.toggle_touchpad = "x=$(synclient | grep TouchpadOff | awk '{print $3}'); synclient TouchpadOff=$((1-$x))"

-- LXC settings
commands.lxc_settings =
  "export ' ' TERM=screen ';' ' ' export ' ' " ..
  "PS1=\\\''[\\u@$(hostname | sed s,.facebook.com,,) \\W]\\$ '\\\' ';' " ..
  "' ' export ' ' ls=\\\'ls ' ' --color=auto\\\' ';' " ..
  "' ' source ' ' /etc/twenv.sh"
commands.awk_print = "\\\'\\{print ' ' \\$1\\}\\\' ' '"

commands.xdotool_echo = "sleep .3; xdotool type "
commands.echo_lxc_settings = commands.xdotool_echo .. commands.lxc_settings
commands.echo_awk_print = commands.xdotool_echo .. commands.awk_print
commands.terminal_white = globals.terminal .. " -bg white -fg black"
commands.minecraft = "prime-run minecraft-launcher"
commands.steam = "steam"
commands.join_class = "~/bin/join_class.sh "

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
commands.spotify.pause = "playerctl -a pause"
commands.spotify.prevsong = "playerctl previous"
commands.spotify.nextsong = "playerctl next"
commands.spotify.rewind = "playerctl position 5-"
commands.spotify.fastfw = "playerctl position 5+"

-- Sound Commands
commands.soundcontrol = globals.float_terminal_cmd .. " -c pulsemixer"
commands.masterdown = "pulsemixer --change-volume -3 &> /dev/null"
commands.masterup = "pulsemixer --change-volume +3 &> /dev/null"
commands.togglemute = "pulsemixer --toggle-mute &> /dev/null"

-- Default music player
commands.musicplayer = commands.spotify

return commands

-- vim: ft=lua sts=2 sw=2
