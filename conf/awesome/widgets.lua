local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = require("beautiful.xresources").apply_dpi

local keys = require "keys"

local config = require "config"
--local mymainmenu = require("widgets.startmenu")

-- Widgets
local mytextclock = wibox.widget.textclock " %H:%M"
-- local mytextclock = wibox.widget.textclock(" %H:%M  %d%A %B ")
mytextclock.align = "center"
mytextclock.valign = "center"
mytextclock.font = "SFNS Display 12"

local gstart = wibox.widget.textbox(beautiful.startmenu_icon)

local rounded_shape = function(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

local real_x = function(s, x)
  if s.index == 1 then
    return x
  else
    return x + 1920 -- screen[s.index - 1].geometry.x
  end
end

local function horizontal_pad(width)
  return wibox.widget {
    forced_width = width,
    layout = wibox.layout.fixed.horizontal,
  }
end

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
  local screen_size = s.geometry.width

  -- Each screen has its own tag table.
  awful.tag(workspaces.names, s, workspaces.layouts)

  local bar = wibox {
    visible = beautiful.main_vis,
    margins = beautiful.useless_gap * 2,
    position = beautiful.main_pos,
    screen = s,
    -- x = screen.index == 2 and beautiful.main_x + dpi(1000) or beautiful.main_x,
    y = beautiful.main_y,
    width = screen_size - (beautiful.useless_gap * 4), -- beautiful.main_width,
    height = beautiful.main_height,
    type = "normal",
    shape = rounded_shape(beautiful.border_radius),
  }

  s.padding = { top = beautiful.useless_gap * 2 + beautiful.main_height }
  awful.placement.top(bar, { margins = beautiful.useless_gap * 2 })

  -- Create a promptbox for each screen
  -- local mypromptbox = awful.widget.prompt()

  -- Taglist
  local taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    style = {
      font = beautiful.taglist_text_font,
      forced_width = dpi(24),
      align = "center",
      valign = "center",
      shape = rounded_shape(dpi(30)),
    },
    layout = {
      spacing = dpi(6),
      layout = wibox.layout.flex.horizontal,
    },

    buttons = keys.taglist_buttons,
  }

  local leftwibox = wibox {
    visible = beautiful.l_vis,
    position = beautiful.l_pos,
    screen = s,
    x = real_x(s, beautiful.l_x),
    y = beautiful.l_y,
    width = beautiful.l_width,
    height = beautiful.l_height,
    type = "normal",
    shape = rounded_shape(beautiful.l_border_radius),
  }

  leftwibox:setup {
    layout = wibox.layout.align.horizontal,
    wibox.container.background(
      wibox.container.margin(taglist, 15, 15, 2, 2),
      beautiful.bg_normal,
      rounded_shape(beautiful.l_border_radius)
    ),
  }

  awful.popup {
    widget = require "newtask" {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = keys.tasklist_buttons,
      style = {
        align = "center",
        valign = "center",
        shape = rounded_shape(beautiful.l_border_radius),
      },
      layout = {
        spacing = 10,
        layout = wibox.layout.fixed.horizontal,
      },
      widget_template = {
        {
          {
            {
              {
                id = "clienticon",
                widget = awful.widget.clienticon,
              },
              id = "mat_fg",
              widget = wibox.container.background,
            },
            layout = wibox.layout.align.horizontal,
            {
              id = "text_role",
              font = beautiful.font,
              widget = wibox.widget.textbox,
            },
          },
          left = dpi(8),
          right = dpi(8),
          margins = 2,
          widget = wibox.container.margin,
        },
        id = "background_role",
        forced_height = beautiful.c_height,
        forced_width = dpi(200),
        shape = rounded_shape(beautiful.l_border_radius),
        widget = wibox.container.background,
        create_callback = function(self, c)
          self:get_children_by_id("text_role")[1].client = c
          self:get_children_by_id("clienticon")[1].client = c
        end,
        update_callback = function(self)
          gears.timer.start_new(1 / 1000, function()
            awful.placement.top(self, { margins = beautiful.start_y }) --mylist
          end)
        end,
      },
    },
    ontop = false,
    y = beautiful.c_y,
    x = real_x(s, beautiful.c_x),
    shape = rounded_shape(beautiful.l_border_radius),
  }

  local systray = wibox {
    ontop = true,
    visible = beautiful.systray_vis,
    position = beautiful.systray_pos,
    screen = s,
    x = beautiful.useless_gap * 2 + screen_size / 2 - beautiful.systray_width / 2, -- beautiful.systray_x,
    y = beautiful.systray_y,
    width = beautiful.systray_width,
    height = beautiful.systray_height,
    type = "normal",
    shape = rounded_shape(beautiful.border_radius),
  }

  systray:setup {
    layout = wibox.layout.align.horizontal,
    wibox.widget.systray(),
  }

  local rightwibox = wibox {
    visible = beautiful.r_vis,
    position = beautiful.r_pos,
    screen = s,
    x = real_x(s, screen_size - beautiful.r_width - beautiful.useless_gap * 2 - beautiful.wibox_spacing),
    y = beautiful.r_y,
    width = beautiful.r_width,
    height = beautiful.r_height,
    type = "normal",
    shape = rounded_shape(beautiful.l_border_radius),
  }

  rightwibox:setup {
    layout = wibox.layout.align.horizontal,
    horizontal_pad(dpi(2)),
    widget = wibox.container.place,
    {
      widget = wibox.container.background,
      bg = beautiful.bg_normal,
      {
        widget = wibox.container.margin,
        left = 10,
        right = 10,
        top = 2,
        bottom = 2,
        mytextclock,
      },
    },
    horizontal_pad(dpi(2)),
  }

  local startwibox = wibox {
    visible = beautiful.start_vis,
    position = beautiful.start_pos,
    screen = s,
    x = real_x(s, beautiful.start_x),
    y = beautiful.start_y,
    width = beautiful.start_width,
    height = beautiful.start_height,
    type = "normal",
    shape = rounded_shape(beautiful.l_border_radius),
  }

  startwibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    wibox.container.background(
      wibox.container.margin(gstart, 15, 15, 2, 2),
      beautiful.bg_normal,
      rounded_shape(beautiful.l_border_radius * 30)
    ),
  }

  startwibox:connect_signal("mouse::enter", function()
    startwibox.fg = beautiful.xcolor2
  end)

  startwibox:connect_signal("mouse::leave", function()
    startwibox.fg = beautiful.fg_normal
  end)
end)
