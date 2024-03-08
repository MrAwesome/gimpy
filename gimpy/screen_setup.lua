local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local menu = require("gimpy/menu")

local function client_menu_toggle_fn()
  local instance = nil

  return function ()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end

local taglist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, client_menu_toggle_fn()),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

local function get_per_screen_setup_func (widgets)
  return function (s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
      awful.button({ }, 1, function () awful.layout.inc( 1) end),
      awful.button({ }, 3, function () awful.layout.inc(-1) end),
      awful.button({ }, 4, function () awful.layout.inc( 1) end),
      awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(
      s, 
      awful.widget.taglist.filter.all, 
      taglist_buttons
    )

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(
      s, 
      awful.widget.tasklist.filter.currenttags, 
      tasklist_buttons
    )

    -- Create the wibox
    s.mywibox = awful.wibar({ 
      position = "top", 
      screen = s 
    })

    spacer = wibox.widget.textbox()
    spacer.text = " "

    -- Add widgets to the wibox
    s.mywibox:setup({
      layout = wibox.layout.align.horizontal,
      -- Left widgets
      { 
        layout = wibox.layout.fixed.horizontal,
        menu.mylauncher,
        s.mytaglist,
        s.mypromptbox,
      },
      -- Middle widget
      s.mytasklist, 
      -- Right widgets
      { 
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        widgets.batterywidgetcontainer,
        widgets.musicwidget,
        widgets.pingoogwidget,
        widgets.pingdevwidget,
        widgets.gpu,
        wibox.widget.textclock(),
        s.mylayoutbox,
      },
    })
  end
end

local screen_setup = {}

screen_setup.initialize_screens = function (widgets)
  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  screen.connect_signal("property::geometry", set_wallpaper)

  awful.screen.connect_for_each_screen(get_per_screen_setup_func(widgets))
end

return screen_setup

-- vim: ft=lua sts=2 sw=2
