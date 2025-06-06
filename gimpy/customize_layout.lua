local awful = require("awful")
local customize_layout = {}

customize_layout.initialize_custom_layout = function()
  local screen = mouse.screen
  --screen.tags[1].master_width_factor = 0.20
  --screen.tags[2].master_width_factor = 0.20
  --screen.tags[1]:view_only()
  screen.tags[1].layout = awful.layout.suit.max
  --screen.tags[3].layout = awful.layout.suit.max
  screen.tags[5].layout = awful.layout.suit.max

  -- To set a layout per tag:
  -- screen.tags[2].layout = awful.layout.suit.tile.bottom
end

return customize_layout

-- vim: ft=lua sts=2 sw=2
