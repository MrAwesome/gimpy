local gears = require("gears")
local awful = require("awful")
local battery = require("gimpy/battery")
local commands = require("gimpy/commands")

local last_widget_text = setmetatable({}, { __mode = "k" })

local function trim_string(s)
  if s == nil then return s end
  s = s:gsub("\r", "")
  s = s:gsub("\n+$", "")
  s = s:gsub("^%s+", "")
  s = s:gsub("%s+$", "")
  return s
end

local function update_widget_text(widget, txt, color)
  txt = trim_string(txt)
  if txt == "" or txt == nil then
    if last_widget_text[widget] == "" then return end
    widget.text = ""
    last_widget_text[widget] = ""
  elseif color == "" or color == nil then
    if last_widget_text[widget] == txt then return end
    widget.text = txt
    last_widget_text[widget] = txt
  else
    local escaped = awful.util.escape(txt)
    local formatted = " <span color='" .. color .. "'> " .. escaped .. " </span> "
    if last_widget_text[widget] == formatted then return end
    widget.markup = formatted
    last_widget_text[widget] = formatted
  end
end

local function run_cmd_and_set_widget_text(command, widget, color, colorcheck, on_complete)
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
      if on_complete then on_complete() end
    end)
end

local function initiate_and_start_timer_for_function(func, interval)
  func()
  local widgtimer = gears.timer({ timeout = interval })
  widgtimer:connect_signal("timeout", func)
  widgtimer:start()
end

local function set_music_text(widget)
  local running = false
  return function()
    if running then return end
    running = true
    run_cmd_and_set_widget_text(commands.spotify.currsong, widget, '#008AFF', nil, function() running = false end)
  end
end

local function set_pingoog_text(widget)
  local running = false
  return function()
    if running then return end
    running = true
    run_cmd_and_set_widget_text(commands.pingoog, widget, '#FF8AFF', nil, function() running = false end)
  end
end

local function set_pingdev_text(widget)
  local running = false
  return function()
    if running then return end
    running = true
    run_cmd_and_set_widget_text(commands.pingdev, widget, '#00FF00', nil, function() running = false end)
  end
end

local function set_pingza_text(widget)
  local running = false
  return function()
    if running then return end
    running = true
    run_cmd_and_set_widget_text(commands.pingza, widget, '#9F55FF', nil, function() running = false end)
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
  local running = false
  return function()
    if running then return end
    running = true
    run_cmd_and_set_widget_text(commands.checkgpu, widget, nil, gpu_colorchecker, function() running = false end)
  end
end

local function set_battery_text(widget)
  local running = false
  return function()
    if running then return end
    running = true
    battery.update_battery_widget_text(widget, function() running = false end)
  end
end

local widget_timers = {}

widget_timers.start_widget_timers = function(widgets)
  initiate_and_start_timer_for_function(set_music_text(widgets.musicwidget), 5)
  initiate_and_start_timer_for_function(set_pingoog_text(widgets.pingoogwidget), 5)
  initiate_and_start_timer_for_function(set_pingdev_text(widgets.pingdevwidget), 5)
  initiate_and_start_timer_for_function(set_pingza_text(widgets.pingzawidget), 5)
  initiate_and_start_timer_for_function(set_gpu_text(widgets.gpu), 5)
  initiate_and_start_timer_for_function(set_battery_text(widgets.batterywidget), 5)
end

return widget_timers

-- vim: ft=lua sts=2 sw=2
