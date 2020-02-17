local wibox = require("wibox")

local widgets = {}
widgets.musicwidget   = wibox.widget.textbox()
widgets.pingoogwidget = wibox.widget.textbox()
widgets.pingdevwidget = wibox.widget.textbox()
widgets.batterywidget = wibox.widget.textbox()

return widgets

-- vim: ft=lua sts=2 sw=2
