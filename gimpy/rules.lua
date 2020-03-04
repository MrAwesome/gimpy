local beautiful = require("beautiful")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

local globals = require("gimpy/globals")

local floating_client_rules = {
  rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
    },
    class = {
      globals.float_terminal_name,
      "Arandr",
      "Gpick",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Sxiv",
      "Dolphin",
      "Wpa_gui",
      "pinentry",
      "veromix",
      ".*inecraft.*",
      "xtightvncviewer"
    },

    name = {
      globals.float_terminal_name,
      "Event Tester",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "pop-up",     -- e.g. Google Chrome's (detached) Developer Tools.
    }
  },
  properties = { floating = true }
}

local zero_border_client_rules = {
  rule_any = {
    class = {
      ".*inecraft.*",
    },
  },
  properties = { border_width = 0 }
}

local rules = {}

-- Rules to apply to new clients (through the "manage" signal).
rules.set_all_client_rules = function (clientkeys, clientbuttons)
  awful.rules.rules = {
    -- All clients will match this rule.
    {
      rule = { },
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen
      }
    },

    -- Floating clients.
    floating_client_rules,
    zero_border_client_rules,

    -- NO TITLEBARS EGGMAN
    {
      rule_any = { type = { "normal", "dialog" } },
      properties = { titlebars_enabled = false }
    },

    { rule = { class = "Firefox" }, properties = { tag = "1" } },
    { rule = { class = "Chromium" }, properties = { tag = "1" } },
    { rule = { class = ".*Brave" }, properties = { tag = "1" } },
    { rule = { class = "Google Chrome" }, properties = { tag = "1" } },
    { rule = { name = globals.screen_one_terminal_name }, properties = { tag = "1" } },
    { rule = { name = globals.work_terminal_name }, properties = { tag = "2" } },
    { rule = { name = "Signal" }, properties = { tag = "3" } },
    { rule = { class = ".*inecraft.*" }, properties = { tag = "4" } },
    { rule = { name = ".*potify.*" }, properties = { tag = "8" } },
    { rule = { class = ".*potify.*" }, properties = { tag = "8" } },
  }
end

return rules

-- vim: ft=lua sts=2 sw=2
