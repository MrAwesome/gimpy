local awful = require("awful")
local commands = require("gimpy/commands")
local globals = require("gimpy/globals")
local menu = require("gimpy/menu")
local menubar = require("menubar")

-- Utility functions {{{
local key = awful.key
local mc = globals.modkey

local spawn = function (cmd)
  return function ()
    awful.spawn(cmd)
  end
end

local shell = function (cmd)
  return function ()
    awful.spawn.with_shell(cmd)
  end
end
-- }}}

local keybindings = {}

keybindings.get_all_global_keybindings = function ()
  return awful.util.table.join(
    keybindings.get_default_global_keybindings(),
    keybindings.get_global_user_command_keybindings(),
    keybindings.get_number_keys()
  )
end

keybindings.get_default_client_keybindings = function ()
  return awful.util.table.join(
    key({ mc }, "f",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}
    ),
    key({ "Control" }, "F8",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}
    ),
    key({ mc }, "c",
      function (c) c:kill() end,
      {description = "close", group = "client"}
    ),
    key({ mc, "Control" }, "space",
      awful.client.floating.toggle,
      {description = "toggle floating", group = "client"}
    ),
    key({ mc, "Control" }, "Return",
      function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}
    ),
    key({ mc }, "o",
      function (c) c:move_to_screen() end,
      {description = "move to screen", group = "client"}
    ),
    key({ mc }, "t",
      function (c) c.ontop = not c.ontop end,
      {description = "toggle keep on top", group = "client"}
    ),
    key({ mc }, "n",
      function (c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end ,
      {description = "minimize", group = "client"}
    ),
    key({ mc }, "m",
      function (c)
        c.maximized = not c.maximized
        c:raise()
      end ,
      {description = "maximize", group = "client"}
    )
  )
end

keybindings.get_default_global_keybindings = function ()
  return awful.util.table.join(
  key({ mc, "Control" }, "r", awesome.restart),
  key({ mc, "Shift" }, "q", awesome.quit),
  key({ mc }, "Left", awful.tag.viewprev),
  key({ mc }, "Right", awful.tag.viewnext),
  key({ mc }, "`", awful.tag.viewprev),
  key({ mc }, "0", awful.tag.viewnext),
  key({ mc }, "Escape", awful.tag.history.restore),

  key({ mc }, "j",
    function ()
      awful.client.focus.byidx( 1)
      if client.focus then client.focus:raise() end
    end),
  key({ mc }, "k",
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
  key({ mc, "Shift" }, "m", function () menu.mymainmenu:show(true)    end),

  -- Layout manipulation
  key({ mc, "Shift" }, "j",
    function () awful.client.swap.byidx( 1)  end),
  key({ mc, "Shift" }, "k",
    function () awful.client.swap.byidx(-1)  end),
  key({ mc, "Control" }, "j",
    function () awful.screen.focus_relative( 1) end),
  key({ mc, "Control" }, "k",
    function () awful.screen.focus_relative(-1) end),
  --key({ mc }, "z",
    --function () awful.screen.focus_relative(-1) end),
  key({ mc, "Shift" }, "Escape",
    function () awful.screen.focus_relative(-1) end),
  key({ mc }, "F1",
    function () awful.screen.focus(1) end),
  key({ mc }, "F2",
    function () awful.screen.focus(2) end),
  key({ mc }, "i",
    awful.client.urgent.jumpto),
  key({ mc }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then client.focus:raise() end
    end),

  -- Layout bindings
  key({ mc }, "l", function () awful.tag.incmwfact( 0.05) end),
  key({ mc }, "h", function () awful.tag.incmwfact(-0.05) end),
  key({ mc, "Shift" }, "h", function () awful.tag.incnmaster( 1) end),
  key({ mc, "Shift" }, "l", function () awful.tag.incnmaster(-1) end),
  key({ mc, "Control" }, "h", function () awful.tag.incncol( 1) end),
  key({ mc, "Control" }, "l", function () awful.tag.incncol(-1) end),
  key({ mc }, "space",
    function () awful.layout.inc(awful.layout.layouts,  1) end
  ),
  key({ mc, "Shift"   }, "space",
    function () awful.layout.inc(awful.layout.layouts, -1) end
  ),
  key({ mc, "Control" }, "n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        awful.client.focus = c
        c:raise()
      end
    end,
    {description = "restore minimized", group = "client"}
  ),

  -- Prompt
  key({ mc }, "r",
    function () awful.screen.focused().mypromptbox:run() end,
    {description = "run prompt", group = "launcher"}
  ),

  key({ mc, "Shift" }, "x",
    function ()
      awful.prompt.run {
        prompt     = "Run Lua code: ",
        textbox    = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}
  ),
  -- Menubar
  key({ mc, "Shift" }, "r",
    function() menubar.show() end,
    {description = "show the menubar", group = "launcher"}
  )
  )
end

keybindings.get_global_user_command_keybindings = function ()
  return awful.util.table.join(

  -- Keyboard layout modifications
  --key({ mc, "Control" }, "q", spawn(commands.qwerty)),
  --key({ mc, "Control" }, "c", spawn(commands.colemak)),

  -- Mousepad touch click
  key({ mc }, "z", shell(commands.toggle_touchpad_click)),
  key({ mc, "Shift" }, "z", shell(commands.toggle_touchpad)),
  key({}, "XF86TouchpadToggle", shell(commands.toggle_touchpad)),

  -- Screen modifications
  key({}, "XF86MonBrightnessUp", shell(commands.brightness_up)),
  key({}, "XF86MonBrightnessDown", shell(commands.brightness_down)),
  key({ "Shift" }, "XF86MonBrightnessUp", shell(commands.brightness_max)),
  key({ "Shift" }, "XF86MonBrightnessDown", shell(commands.brightness_min)),

  -- LXC settings echo
  key({ mc, "Shift", "Control" }, "x", shell(commands.echo_lxc_settings)),
  key({ mc, "Control" }, "x", shell(commands.echo_awk_print)),

  -- Standard program
  --key({ mc }, "s", shell(commands.translate_to_english)),
  --key({ mc, "Shift" }, "s", shell(commands.translate_to_mandarin)),
  key({ mc, "Shift" }, "o", spawn(commands.one_screen)),
  key({ mc, "Control" }, "o", spawn(commands.meeting_room)),
  --key({ mc, "Mod1" }, "o", spawn(commands.two_screens)),
  key({ mc, "Mod1" }, "o", spawn(commands.hdmi)),
  key({ mc, "Shift" }, "i", spawn(commands.minecraft)),
  key({ mc          }, "F12", spawn(commands.join_class)),
  key({ mc, "Control" }, "i", spawn(commands.steam)),
  key({ }, "Print", shell(commands.screenshot)),
  key({ mc }, "F6", shell(commands.screenshot)),
  key({ "Shift" }, "Print", shell(commands.screenshot_draw)),
  key({ mc, "Shift" }, "F6", shell(commands.screenshot_draw)),
  key({ "Control" }, "Print", shell(commands.screenshot_active_window)),
  key({ mc, "Control" }, "F6", shell(commands.screenshot_active_window)),
  key({ mc }, "Return", spawn(globals.terminal)),
  key({ mc, "Shift"   }, "Return", spawn(globals.work_terminal_cmd)),
  key({ mc, "Control" }, "Return", spawn(commands.terminal_white)),
  key({ mc }, "b", shell(commands.browser)),
  key({ mc, "Mod1" }, "b", shell(commands.chat)),
  key({ mc, "Control" }, "s", shell(commands.musicplayer.launch)),
  key({ mc, "Control" }, "w", shell(commands.reconnect_wireless)),
  key({ mc }, "v", spawn(commands.alarm)),
  key({ mc, "Shift"   }, "v",
    shell(commands.musicplayer.pause .. "; " .. commands.lockscreen)),
  key({ mc, "Control" }, "v", shell(commands.lockscreen)),
  key({ mc }, "p", shell(commands.pomodoro)),
  key({ mc, "Shift" }, "p", shell(globals.terminal .. " -c python3")),

  -- Learn some Taiwanese
  key({ mc, "Shift" }, "t", shell(commands.browser .. " 'https://www.youtube.com/playlist?list=PLWtS9zTL-EGOzcWAxG1oxlZZ_EJxLc9gK'")),
  key({ mc, "Control" }, "t", shell(commands.browser .. " 'https://www.youtube.com/@user-rv4ei9md3c'")),


  key({ mc, "Shift", "Mod1" }, "k", shell(commands.kill_browser)),

  key({ mc, "Shift" }, "n", shell(commands.networking_wifi)),

  key({ mc, "Mod1" }, "l", shell(commands.linepw)),
  key({ mc, "Mod1" }, "g", shell(commands.emailaddr)),

  -- Paste
  key({ "Shift" }, "XF86Eject", shell(commands.paste)),
  key({ "Shift" }, "F8", shell(commands.paste)),
  key({ "Shift" }, "F9", shell(commands.paste)),

  -- Music bindings
  key({ mc }, "q", shell(commands.musicplayer.toggle)),
  key({ mc }, "w", shell(commands.musicplayer.rewind)),
  key({ mc }, "e", shell(commands.musicplayer.fastfw)),
  key({ mc, "Shift" }, "w", shell(commands.musicplayer.prevsong)),
  key({ mc, "Shift" }, "e", shell(commands.musicplayer.nextsong)),
  key({ mc, "Shift" }, "f", shell(commands.musicplayer.favorite)),
  key({ }, "XF86AudioPlay", shell(commands.musicplayer.toggle)),
  key({ }, "XF86AudioPrev", shell(commands.musicplayer.prevsong)),
  key({ }, "XF86AudioNext", shell(commands.musicplayer.nextsong)),

  -- Volume bindings
  key({ mc, "Shift" }, "a", spawn(commands.soundcontrol)),
  key({ mc }, "y", shell(commands.masterdown)),
  key({ mc }, "u", shell(commands.masterup)),
  key({ }, "XF86AudioLowerVolume", shell(commands.masterdown)),
  key({ }, "XF86AudioRaiseVolume", shell(commands.masterup)),
  key({ }, "XF86AudioMute", shell(commands.togglemute))
  )
end

keybindings.get_number_keys = function ()
  local number_keys = {}
  for i = 1, 9 do
    number_keys = awful.util.table.join(number_keys,
      -- View tag only.
      awful.key({ mc }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            tag:view_only()
          end
        end,
        {description = "view tag #"..i, group = "tag"}
      ),
      -- Toggle tag display.
      awful.key({ mc, "Control" }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            awful.tag.viewtoggle(tag)
          end
        end,
        {description = "toggle tag #" .. i, group = "tag"}
      ),
      -- Move client to tag.
      awful.key({ mc, "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:move_to_tag(tag)
            end
          end
        end,
        {description = "move focused client to tag #"..i, group = "tag"}
      ),
      -- Toggle tag on focused client.
      awful.key({ mc, "Control", "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:toggle_tag(tag)
            end
          end
        end,
        {description = "toggle focused client on tag #" .. i, group = "tag"}
      )
    )
  end

  return number_keys
end

return keybindings

-- vim: ft=lua sts=2 sw=2
