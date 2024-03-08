local wibox = require("wibox")
local gears = require("gears")

local widgets = {}
widgets.musicwidget   = wibox.widget.textbox()
widgets.pingoogwidget = wibox.widget.textbox()
widgets.pingdevwidget = wibox.widget.textbox()
widgets.gpu   = wibox.widget.textbox()
widgets.batterywidget = wibox.widget.textbox()

widgets.batterywidgetcontainer = wibox.widget{
        {
            {widget = widgets.batterywidget},
            left   = 8,
            right  = 8,
            top    = 0,
            bottom = 0,
            widget = wibox.container.margin
        },
  shape = gears.shape.rounded_rect,
  shape_border_color = "#777777",
  shape_border_width = 1,
  widget = wibox.container.background
}

return widgets

-- vim: ft=lua sts=2 sw=2
