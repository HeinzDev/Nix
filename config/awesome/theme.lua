---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local gcolor = require("gears.color")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local rrect = function(radius)
	return 	function(cr, width, height)			
		gears.shape.rounded_rect(cr, width, height, radius)
	  end
end

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

--theme.bg_normal    = "#1e1e2e"
--theme.bg_focus    = "#1e1e2e"
--theme.bg_urgent   = "#1e1e2e"
--theme.bg_minimize = "#1e1e2e"
--theme.bg_systray  = theme.bg_normal

theme.fg_normal   = "#585b70"
theme.fg_focus    = "#fab387"
theme.fg_urgent   = "#f38ba8"
theme.fg_minimize = "#ffffff"

theme.useless_gap   = dpi(10) 
theme.border_width  = dpi(3)
theme.border_normal = "#ab2e5c"
theme.border_focus  = "#f2357b"

theme.notification_width=240
theme.notification_height=70
theme.notification_opacity=80
theme.notification_bg="#1e1e2a"
theme.notification_fg="#b1b1f2"
theme.notification_margin=6
theme.notification_border_color="#ab2e5c"
theme.notification_border_width=3
theme.notification_icon_size = 60
theme.notification_shape = rrect(7)




--theme.border_marked = "#fab387"

return theme
