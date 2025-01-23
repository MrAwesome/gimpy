local globals = {}

globals.modkey = "Mod4"

globals.cmd_shell = "zsh"
globals.base_terminal = "prime-run wezterm "
globals.terminal_winclass_option = " --class "
globals.terminal_startcmd = " start "

globals.terminal = globals.base_terminal .. globals.terminal_startcmd .. globals.cmd_shell .. " "

-- unfortunately, this is wezterm-specific because of command argument ordering
local make_terminal_cmd = function(classname)
  return globals.base_terminal ..
      globals.terminal_startcmd ..
      globals.terminal_winclass_option ..
      classname ..
      " -- " ..
      globals.cmd_shell .. " "
end

globals.work_terminal_name = "WORK_TERMINAL"
globals.work_terminal_cmd = make_terminal_cmd(globals.work_terminal_name)

globals.screen_one_terminal_name = "SCREEN_ONE_TERMINAL"
globals.screen_one_terminal_cmd = make_terminal_cmd(globals.screen_one_terminal_name)

globals.screen_four_terminal_name = "SCREEN_FOUR_TERMINAL"
globals.screen_four_terminal_cmd = make_terminal_cmd(globals.screen_four_terminal_name)

globals.float_terminal_name = "FLOAT_TERMINAL"
globals.float_terminal_cmd = make_terminal_cmd(globals.float_terminal_name)

globals.editor = os.getenv("EDITOR") or "editor"
globals.editor_cmd = globals.terminal .. " -c " .. globals.editor

globals.theme_config = "/usr/share/awesome/themes/zenburn/theme.lua"

return globals

-- vim: ft=lua sts=2 sw=2
