local beautiful = require("beautiful")
local globals = require("gimpy/globals")

local theme = {}

theme.setup_theme = function ()
  beautiful.init(globals.theme_config)
end

return theme

-- vim: ft=lua sts=2 sw=2
