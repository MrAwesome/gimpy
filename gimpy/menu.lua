local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local globals = require("gimpy/globals")

local menu = {}

menu.myawesomemenu = {
  -- { "manual", globals.terminal .. " -e man awesome" },
  -- { "edit config", globals.editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit",   function () awesome.quit() end }
}

menu.mymainmenu = awful.menu({
  items = {
    { "awesome",       menu.myawesomemenu, beautiful.awesome_icon },
    { "open terminal", "wezterm" }
  }
})

menu.mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = menu.mymainmenu
})

menu.setup_menu_terminal = function()
  menubar.utils.terminal = terminal
end


return menu

-- vim: ft=lua sts=2 sw=2
