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
theme.border_width  = dpi(1)
theme.border_normal = "#313244"
theme.border_focus  = "#ab2e5c"



theme.border_marked = "#fab387"

return theme
