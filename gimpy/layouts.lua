local awful = require("awful")

local function get_awesome_layouts()
  -- Table of layouts to cover with awful.layout.inc, order matters.
  return {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.floating,
  }
end

local layouts = {}

layouts.set_awesome_layouts = function()
  awful.layout.layouts = get_awesome_layouts()
end

return layouts

-- vim: ft=lua sts=2 sw=2
