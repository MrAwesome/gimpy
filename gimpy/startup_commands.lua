local globals = require("gimpy/globals")
local commands = require("gimpy/commands")
local awful = require("awful")

local startup_commands = {}

local function noop() end

startup_commands.run_startup_commands = function()
  local screen = mouse.screen
  --awful.spawn.easy_async("xmodmap .xmodmaprc", noop)
  --awful.spawn.easy_async("setxkbmap -option caps:escape", noop)

  screen.tags[1]:view_only()
  awful.spawn.easy_async('pgrep -if firefox', function(stdout, stderr, exitreason, exitcode)
    if exitcode > 0 then
      awful.spawn.easy_async_with_shell(commands.browser, noop)
    end
  end)
  -- TODO: make font size smaller on todo term windows
  --  awful.spawn.easy_async('pgrep -f TODO.txt', function (stdout, stderr, exitreason, exitcode)
  --    if exitcode > 0 then
  --      awful.spawn.easy_async_with_shell(globals.screen_one_terminal_cmd .. "-ic 'vim TODO.txt'")
  --    end
  --  end)

  --  screen.tags[2]:view_only()
  --  awful.spawn.easy_async('pgrep -if godot', function(stdout, stderr, exitreason, exitcode)
  --    if exitcode > 0 then
  --      awful.spawn.easy_async_with_shell("cd ~/code/decktricks; godot --editor --language-server", noop)
  --    end
  --  end)

  screen.tags[3]:view_only()
  awful.spawn.easy_async('pgrep -if signal-desktop', function(stdout, stderr, exitreason, exitcode)
    if exitcode > 0 then
      awful.spawn.easy_async_with_shell(commands.signal_desktop, noop)
    end
  end)

  screen.tags[4]:view_only()
  awful.spawn.easy_async('pgrep -if weechat', function(stdout, stderr, exitreason, exitcode)
    if exitcode > 0 then
      awful.spawn.easy_async_with_shell(globals.screen_four_terminal_cmd .. "-ic 'weechat_tmux.sh'", noop)
    end
  end)

  screen.tags[4]:view_only()
  awful.spawn.easy_async('pgrep -if steam', function(stdout, stderr, exitreason, exitcode)
    if exitcode > 0 then
      awful.spawn.easy_async_with_shell("steam", noop)
    end
  end)

  screen.tags[4]:view_only()
  awful.spawn.easy_async('pgrep -if lutris', function(stdout, stderr, exitreason, exitcode)
    if exitcode > 0 then
      awful.spawn.easy_async_with_shell("lutris", noop)
    end
  end)

  screen.tags[7]:view_only()
  awful.spawn.easy_async('pgrep -if vesktop', function(stdout, stderr, exitreason, exitcode)
    if exitcode > 0 then
      awful.spawn.easy_async_with_shell("vesktop", noop)
    end
  end)
  --   awful.spawn.easy_async('pgrep -f CODE_TODO', function (stdout, stderr, exitreason, exitcode)
  --     if exitcode > 0 then
  --       awful.spawn.easy_async_with_shell(globals.work_terminal_cmd .. " -ic 'sleep .1 && echo CODE_TODO && vim code_todo.txt'", noop)
  --     end
  --   end)
end

return startup_commands

-- vim: ft=lua sts=2 sw=2
