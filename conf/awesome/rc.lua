pcall(require, "luarocks.loader")

local gears = require "gears"
local awful = require "awful"
local lain = require "lain"
local wibox = require "wibox"
local beautiful = require "beautiful"

require "awful.autofocus"
require "awful.hotkeys_popup.keys"

require "ensure"

local theme = require "theme"
local keys = require "keys"
local config = require "config"
local widgets = require "widgets"
require "rules"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(string.format("%s/.config/awesome/theme/init.lua", os.getenv "HOME"))

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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  local workspaces = config.workspaces

  -- Each screen has its own tag table.
  awful.tag(workspaces.names, s, workspaces.layouts)

  -- Quake application
  s.quake = lain.util.quake { app = awful.util.terminal }

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)

  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = keys.taglist_buttons,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = keys.tasklist_buttons,
  }

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    screen = s,
    height = require("beautiful.xresources").apply_dpi(18),
    bg = theme.bg_normal,
    fg = theme.fg_normal,
  }

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    widgets.lhs_widgets(s),
    s.mytasklist,
    widgets.rhs_widgets(s),
  }
end)
