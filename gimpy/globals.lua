local make_terminal_cmd = function(term, shell, name) 
  return term .. 
    " -title " .. name .. 
    " -name " .. name .. 
    " -e " .. shell .. 
    " "
end

local globals = {}
globals.make_termanal_command = make_termanal_command

globals.modkey = "Mod4"
globals.cmd_shell = "zsh"
globals.base_terminal = "urxvt "
globals.terminal = globals.base_terminal .. "-e " .. globals.cmd_shell .. " "

globals.work_terminal_name = "WORK_TERMINAL"
globals.work_terminal_cmd = make_terminal_cmd(globals.base_terminal, globals.cmd_shell, globals.work_terminal_name)

globals.screen_one_terminal_name = "SCREEN_ONE_TERMINAL"
globals.screen_one_terminal_cmd = make_terminal_cmd(globals.base_terminal, globals.cmd_shell, globals.screen_one_terminal_name)

globals.screen_four_terminal_name = "SCREEN_FOUR_TERMINAL"
globals.screen_four_terminal_cmd = make_terminal_cmd(globals.base_terminal, globals.cmd_shell, globals.screen_four_terminal_name)

globals.float_terminal_name = "FLOAT_TERMINAL"
globals.float_terminal_cmd = make_terminal_cmd(globals.base_terminal, globals.cmd_shell, globals.float_terminal_name)

globals.editor = os.getenv("EDITOR") or "editor"
globals.editor_cmd = globals.terminal .. " -c " .. globals.editor

globals.theme_config = "/usr/share/awesome/themes/zenburn/theme.lua"

return globals

-- vim: ft=lua sts=2 sw=2
