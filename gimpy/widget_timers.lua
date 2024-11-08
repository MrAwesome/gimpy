local gears = require("gears")
local awful = require("awful")
local battery = require("gimpy/battery")
local commands = require("gimpy/commands")

local function update_widget_text(widget, txt, color)
  if txt == "" or txt == nil then
    widget.text = ""
  elseif color == "" or color == nil then
    widget.text = txt
  else
    txt = awful.util.escape(txt)
    formatted = " <span color='" .. color .. "'> " ..
        txt ..
        " </span> "
    widget.markup = formatted
  end
end

local function run_cmd_and_set_widget_text(command, widget, color, colorcheck)
  awful.spawn.easy_async_with_shell(command,
    function(stdout, stderr, reason, exit_code)
      if color == nil then
        if colorcheck then
          color = colorcheck(stdout)
        else
          color = "#FFFFFF"
        end
      end
      update_widget_text(widget, stdout, color)
    end)
end

local function initiate_and_start_timer_for_function(func, interval)
  func()
  widgtimer = gears.timer({ timeout = interval })
  widgtimer:connect_signal("timeout", func)
  widgtimer:start()
end

local function set_music_text(widget)
  return function()
    run_cmd_and_set_widget_text(commands.spotify.currsong, widget, '#008AFF')
  end
end

local function set_pingoog_text(widget)
  return function()
    run_cmd_and_set_widget_text(commands.pingoog, widget, '#FF8AFF')
  end
end

local function set_pingdev_text(widget)
  return function()
    run_cmd_and_set_widget_text(commands.pingdev, widget, '#00FF00')
  end
end

local function gpu_colorchecker(stdout)
  if string.match(stdout, "NVIDIA") then
    return '#FF6600'
  elseif string.match(stdout, "AMDGPU") then
    return '#0066FF'
  else
    return '#0066FF'
  end
end

local function set_gpu_text(widget)
  return function()
    run_cmd_and_set_widget_text(commands.checkgpu, widget, nil, gpu_colorchecker)
  end
end

local function set_battery_text(widget)
  return function()
    battery.update_battery_widget_text(widget)
  end
end

local widget_timers = {}

widget_timers.start_widget_timers = function(widgets)
  initiate_and_start_timer_for_function(set_music_text(widgets.musicwidget), 5)
  initiate_and_start_timer_for_function(set_pingoog_text(widgets.pingoogwidget), 5)
  initiate_and_start_timer_for_function(set_pingdev_text(widgets.pingdevwidget), 5)
  initiate_and_start_timer_for_function(set_gpu_text(widgets.gpu), 5)
  initiate_and_start_timer_for_function(set_battery_text(widgets.batterywidget), 5)
end

return widget_timers

-- vim: ft=lua sts=2 sw=2
