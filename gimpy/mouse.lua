local awful = require("awful")
local menu = require("gimpy/menu")
local globals = require("gimpy/globals")

local mouse = {}

mouse.setup_root_mouse_actions = function ()
  root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () menu.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
  ))
end

mouse.get_client_buttons = function ()
  return awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ globals.modkey }, 1, awful.mouse.client.move),
    awful.button({ globals.modkey }, 3, awful.mouse.client.resize)
  )
end

return mouse

-- vim: ft=lua sts=2 sw=2
