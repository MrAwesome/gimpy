local beautiful = require("beautiful")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

local globals = require("gimpy/globals")

local floating_client_rules = {
  rule_any = {
    instance = {
      "DTA",   -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
    },
    class = {
      globals.float_terminal_name,
      "Arandr",
      "Gpick",
      "Kruler",
      "MessageWin", -- kalarm.
      "Sxiv",
      "Dolphin",
      "Decktricks.*",
      "Wpa_gui",
      "pinentry",
      "veromix",
      ".*inecraft.*",
      "xtightvncviewer"
    },

    name = {
      globals.float_terminal_name,
      "Event Tester", -- xev.
      "Decktricks.*",
    },
    role = {
      "AlarmWindow", -- Thunderbird's calendar.
      "pop-up",      -- e.g. Google Chrome's (detached) Developer Tools.
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

local ontop_rules = {
  rule_any = {
    class = {
      "Decktricks.*",
    }
  },
  properties = { ontop = true }
}


local rules = {}

-- If there's no second+ screen, just use the primary one.
local screen_count = screen.count()
if screen_count > 1 then
  second_screen_progs_go_here = 2
else
  second_screen_progs_go_here = 1
end

-- TODO: this is disabled for use with XR glasses, which should be secondary. Need a better system.
local ss = 1

-- Rules to apply to new clients (through the "manage" signal).
rules.set_all_client_rules = function(clientkeys, clientbuttons)
  awful.rules.rules = {
    -- All clients will match this rule.
    {
      rule = {},
      properties = {
        border_width = 1,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen
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

    { rule = { name = "Firefox" },                         properties = { tag = "1" } },
    { rule = { class = "Firefox" },                        properties = { tag = "1" } },
    { rule = { class = "Chromium" },                       properties = { tag = "1" } },
    { rule = { class = "Google Chrome" },                  properties = { tag = "1" } },
    { rule = { name = globals.screen_one_terminal_name },  properties = { tag = "1" } },
    { rule = { name = globals.work_terminal_name },        properties = { tag = "2" } },
    { rule = { name = ".*Godot.*" },                       properties = { tag = "2" } },
    { rule = { name = globals.screen_four_terminal_name }, properties = { tag = "4", screen = ss } },
    { rule = { name = "Signal" },                          properties = { tag = "3", screen = ss } },
    { rule = { name = ".*Connect a Signal.*" },            properties = { tag = "2", screen = ss } },
    { rule = { class = ".*inecraft.*" },                   properties = { tag = "4" } },
    { rule = { name = "Team Fortress 2.*" },               properties = { tag = "4" } },
    { rule = { name = ".*Red Dead Redemption.*" },         properties = { tag = "4" } },
    { rule = { name = ".*Rockstar Games.*" },              properties = { tag = "4" } },
    { rule = { class = ".*Rockstar Games.*" },             properties = { tag = "4" } },
    { rule = { class = ".*hl_linux.*" },                   properties = { tag = "4" } },
    { rule = { class = ".*[Ll]utris.*" },                  properties = { tag = "5", screen = ss } },
    { rule = { name = "^Steam$" },                         properties = { tag = "5", screen = ss } },
    { rule = { class = "^Steam$" },                        properties = { tag = "5", screen = ss } },
    { rule = { name = "Spotify.*" },                       properties = { tag = "8", screen = ss } },
    { rule = { class = "Spotify.*" },                      properties = { tag = "8", screen = ss } },
    { rule = { class = "Discord" },                        properties = { tag = "7", screen = ss } },
    { rule = { class = "vesktop" },                        properties = { tag = "7", screen = ss } },
    { rule = { name = "vesktop" },                         properties = { tag = "7", screen = ss } },
    { rule = { name = "Discord" },                         properties = { tag = "7", screen = ss } },
    { rule = { name = "WebCord" },                         properties = { tag = "7", screen = ss } },

    -- Reference:
    -- tag = "5",
    -- screen = ss,
    -- titlebars_enabled = false,
    -- floating = true,
    -- border_width = 0,
    -- border_color = 0,
    -- size_hints_honor = false,

    ontop_rules,
  }
end

return rules

-- vim: ft=lua sts=2 sw=2
