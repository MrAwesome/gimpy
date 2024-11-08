local menu = require("gimpy/menu")
local theme = require("gimpy/theme")
local keybindings = require("gimpy/keybindings")
local widgets = require("gimpy/widgets")
local globals = require("gimpy/globals")
local widget_timers = require("gimpy/widget_timers")
local signals = require("gimpy/signals")
local rules = require("gimpy/rules")
local layouts = require("gimpy/layouts")
local customize_layout = require("gimpy/customize_layout")
local startup_commands = require("gimpy/startup_commands")
local screen_setup = require("gimpy/screen_setup")
local mouse = require("gimpy/mouse")

local initialize = {}

initialize.initialize = function()
  theme.setup_theme()
  layouts.set_awesome_layouts()
  menu.setup_menu_terminal()
  screen_setup.initialize_screens(widgets)

  mouse.setup_root_mouse_actions()
  root.keys(keybindings.get_all_global_keybindings())

  rules.set_all_client_rules(
    keybindings.get_default_client_keybindings(),
    mouse.get_client_buttons()
  )

  signals.connect_all_signals()
  widget_timers.start_widget_timers(widgets)
  if not os.getenv("GIMPY_NO_STARTUP") then
    startup_commands.run_startup_commands()
  end
  customize_layout.initialize_custom_layout()
end

return initialize
-- vim: ft=lua sts=2 sw=2
