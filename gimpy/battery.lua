local io = io
local math = math
local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local tonumber = tonumber
local tostring = tostring
local string = require("string")
local print = print
local pairs = pairs

local limits = {
  {16, 5},
  {8, 3},
  {4, 1},
  {0, 0}
}
-- TODO: How can you reset it after charge?
local nextlim = limits[1][1]

local color_low = "#ff66cc"

local function get_bat_state(acpi_line)
  local battstring = acpi_line:gsub('.* (%d+)%%.*', '%1')
  local percentage = tonumber(battstring)

  local dir = 0
  local remtime = ""
  local idx = nil

  if percentage == nil then
    -- nothing
  elseif acpi_line:match("Charging") then
    dir = 1
    idx = acpi_line:find('until charged')
    if idx == nil then
      idx = 0
    end
    remtime = acpi_line:sub(idx - 9, idx - 5)
  elseif acpi_line:match("Discharging") then
    dir = -1
    idx = acpi_line:find('remaining')
    if idx == nil then
      idx = 0
    end
    remtime = acpi_line:sub(idx - 9, idx - 5)
  end

  return {percentage = percentage,
          dir = dir,
          remtime = remtime}
end

local function getnextlim (num)
  local lim = nil
  local step = nil
  for ind, pair in pairs(limits) do
    lim = pair[1]
    step = pair[2]
    nextlim = limits[ind+1][1] or 0
    if num > nextlim then
      repeat
        lim = lim - step
      until num > lim
      if lim < nextlim then
        lim = nextlim
      end
      return lim
    end
  end
end

local function notify_on_low(percentage)
  naughty.notify({title = "   ҉ Beware!    ҉ ",
    text = "Battery charge is low ("..percentage.."%)!",
    timeout = 7,
    position = "bottom_right",
    fg = beautiful.fg_focus,
    bg = beautiful.bg_focus
    })
end

local function get_battery_status_text(acpi_output)
  local prefix = "⚝"
  local output_string = " "
  acpi_lines = gears.string.split(acpi_output, "\n")
  for ind, acpi_line in pairs(acpi_lines) do
    local bat_state = get_bat_state(acpi_line)
    local percentage = bat_state.percentage
    local dir = bat_state.dir
    local remtime = bat_state.remtime

    --local percentage, dir, remtime = bat_state
    if percentage == nil then
      return nil
    end

    local percentage_string = percentage.."%"
    if dir == -1 then
      prefix = "-"
    elseif dir == 1 then
      prefix = "+"
      nextlim = limits[1][1]
    else
      prefix = ""
    end

    if remtime == nil or dir == nil then
      if remtime == nil then
        print("remtime is nil")
      else
        print("remtime: "..remtime)
      end
      if dir == nil then
        print("dir is nil")
      else
        print("dir: "..dir)
      end
      print("acpi_line: "..acpi_line)
      print("percentage: "..percentage)
    end

    remaining = dir == 0 and "" or " ("..prefix..""..remtime..") "

    if percentage <= limits[1][1] then
      percentage_string = string.format(
        "<span color='%s'> %s </span>",
        color_low,
        percentage.."%"
      )
    end

    output_string = output_string..percentage_string..remaining.." // "
  end
  return "[["..output_string:sub(1,-5).."]]"
end

local battery = {}

battery.update_battery_widget_text = function (widget)
  awful.spawn.easy_async('acpi -b',
    function (stdout, stderr, reason, exit_code)
      -- TODO: use a normal chomp function here
      local chomped = stdout:gsub('(.*)\n$', '%1')
      widget.markup = get_battery_status_text(chomped)
    end
  )
end

return battery

-- vim: ft=lua sts=2 sw=2
