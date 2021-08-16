local xresources = require "beautiful.xresources"
local xrdb = xresources.get_current_theme()
local gfs = require "gears.filesystem"
local theme = dofile(gfs.get_themes_dir() .. "default/theme.lua")
local gears = require "gears"
local dpi = require("beautiful.xresources").apply_dpi

-- local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/luna/icons/titlebar/"

-- Wallpaper
theme.wallpaper = os.getenv "HOME" .. "/.config/awesome/themes/luna/wallpaper.png"

-- Gaps & Borders
theme.gap_single_client = true
theme.useless_gap = dpi(5)
theme.border_width = 0
theme.border_radius = dpi(7)

-- Theme
-- theme.font = "ProFontWindows Nerd Font Mono 14"
theme.font = "JetBrainsMono Nerd Font 12"
theme.tasklist_align = "center"

-- Colors
theme.bg_dark = xrdb.color0
theme.bg_normal = xrdb.background
theme.bg_focus = xrdb.color2
theme.bg_urgent = xrdb.background
theme.bg_minimize = xrdb.color0
theme.bg_systray = xrdb.color0

theme.fg_normal = xrdb.foreground
theme.fg_focus = theme.bg_normal
theme.fg_urgent = xrdb.color1
theme.fg_minimize = theme.fg_normal

theme.xcolor0 = xrdb.color0
theme.xcolor1 = xrdb.color1
theme.xcolor2 = xrdb.color2
theme.xcolor3 = xrdb.color3
theme.xcolor4 = xrdb.color4
theme.xcolor5 = xrdb.color5
theme.xcolor6 = xrdb.color6
theme.xcolor7 = xrdb.color7
theme.xcolor8 = xrdb.color8
theme.xcolor9 = xrdb.color9
theme.xcolor10 = xrdb.color10
theme.xcolor11 = xrdb.color11
theme.xcolor12 = xrdb.color12
theme.xcolor13 = xrdb.color13
theme.xcolor14 = xrdb.color14
theme.xcolor15 = xrdb.color15

-- Tags
theme.taglist_text_font = "JetBrainsMono Nerd Font 12"

-- Tasklist
--theme.tasklist_disable_icon = false
--theme.tasklist_disable_task_name = true
--theme.tasklist_plain_task_name = false

-- Wibar Configuration
-- Systray
theme.systray_pos = "top"
theme.systray_vis = true
theme.systray_width = dpi(151)
theme.systray_height = dpi(30)
-- theme.systray_x = theme.useless_gap * 2 + screen_size / 2 - theme.systray_width / 2 -- Deprecated
theme.systray_y = theme.useless_gap * 2 + dpi(10)

-- Wiboxes
theme.wibox_spacing = dpi(20)

-- Main Wibox
theme.main_border_radius = dpi(6)
theme.main_pos = "top"
theme.main_vis = true
-- theme.main_width = screen_size - (theme.useless_gap * 4) -- Deprecated
theme.main_height = dpi(47)
theme.main_x = theme.useless_gap * 2
theme.main_y = theme.useless_gap * 2

-- Start Menu
theme.startmenu_icon = "λ"
theme.start_border_radius = dpi(12)
theme.start_pos = "top"
theme.start_vis = true
theme.start_width = dpi(38) -- tag fixed width * amount of tags + tag spacing * amount of spaces
theme.start_height = dpi(30)
theme.start_x = theme.useless_gap * 2 + theme.wibox_spacing
theme.start_y = theme.useless_gap * 2 + (theme.main_height - theme.start_height) / 2

-- Left Wibar
theme.l_border_radius = dpi(12)
theme.l_pos = "top"
theme.l_vis = true
theme.l_width = dpi(21 * 7 + 12 * 7) -- tag fixed width * amount of tags + tag spacing * amount of spaces
theme.l_height = dpi(30)
theme.l_x = theme.useless_gap * 2 + theme.wibox_spacing * 2 + theme.start_width
theme.l_y = theme.useless_gap * 2 + (theme.main_height - theme.l_height) / 2

-- Right Wibar
theme.r_pos = "top"
theme.r_vis = true
theme.r_width = dpi(210)
theme.r_height = dpi(30)
-- theme.r_x = screen_size - theme.r_width - theme.useless_gap * 2 - theme.wibox_spacing -- Deprecated
theme.r_y = theme.useless_gap * 2 + (theme.main_height - theme.r_height) / 2

-- Center Wibar
theme.c_pos = "top"
theme.c_vis = true
theme.c_height = dpi(30)
theme.c_x = theme.useless_gap * 2 + theme.l_width + theme.start_width + theme.wibox_spacing * 3
theme.c_y = theme.useless_gap * 2 + (theme.main_height - theme.c_height) / 2

-- Notification
theme.notification_font = "SFNS Display 10"
theme.notification_urgent_font = "SFNS Display 10"
theme.notification_urgent_bg = theme.fg_normal
theme.notification_urgent_fg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_bg = theme.bg_normal
theme.notification_urgent_timeout = 0
theme.notification_timeout = 5
theme.notification_urgent_position = "top_middle"
theme.notification_position = "top_right"
theme.notification_padding = dpi(16)
theme.notification_min_width = dpi(150)
theme.notification_max_width = dpi(300)
theme.notification_icon_size = dpi(64)
theme.notification_margin = dpi(7)
theme.notification_spacing = theme.l_height + theme.useless_gap * 6
theme.notification_border_width = 0
theme.notification_border_color = "#00000000"
theme.notification_shape = function(cr, w, h)
  gears.shape.rounded_rect(cr, w, h, theme.border_radius / 2 or 0)
end

-- Titlebars
theme.titlebar_pos = "top"
theme.titlebar_font = "SFNS Display 8"
theme.titlebar_size = dpi(24)
theme.titlebar_bg_focus = xrdb.color0
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_fg_normal = theme.bg_normal

return theme
