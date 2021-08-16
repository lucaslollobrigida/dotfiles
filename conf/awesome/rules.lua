local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local keys = require "keys"

local dpi = beautiful.xresources.apply_dpi

local function colorize_text(text, color)
  return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

local function titlebarbtn(char, color, func)
  return wibox.widget {
    {
      {
        font = beautiful.titlebar_font,
        markup = colorize_text(char, color),
        widget = wibox.widget.textbox,
      },
      top = dpi(20),
      bottom = 4,
      widget = wibox.container.margin,
    },
    font = beautiful.titlebar_font,
    bg = color,
    widget = wibox.container.background,
    buttons = gears.table.join(awful.button({}, 1, func)),
    shape = gears.shape.circle,
  }
end

awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.clientkeys,
      buttons = keys.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA", -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin", -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}

client.connect_signal("manage", function(c)
  if not awesome.startup then
    awful.client.setslave(c)
  end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end

  -- if c.fullscreen then
  -- 	c.shape = function(cr, width, height)
  -- 		gears.shape.rectangle(cr, width, height)
  -- 	end
  -- else
  -- 	c.shape = function(cr, width, height)
  -- 		gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
  -- 	end
  -- end
end)

client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  local minimize = titlebarbtn("", beautiful.xcolor3, function()
    awful.client.next(1)
    c.minimized = true
  end)

  local maximize = titlebarbtn("", beautiful.xcolor2, function()
    c.maximized = not c.maximized
    c:raise()
  end)

  local floating = titlebarbtn("", beautiful.xcolor4, function()
    c.floating = not c.floating
  end)

  local close = titlebarbtn("", beautiful.xcolor1, function()
    c:kill()
  end)

  awful.titlebar(c, { size = beautiful.titlebar_size }):setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    {
      buttons = buttons,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(10),
        floating,
      },
      left = dpi(10),
      right = dpi(10),
      widget = wibox.container.margin,
    },
    {
      buttons = buttons,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(10),
      },
      left = dpi(10),
      right = dpi(10),
      widget = wibox.container.margin,
    },
    {
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(10),
        minimize,
        maximize,
        close,
      },
      left = dpi(10),
      right = dpi(10),
      widget = wibox.container.margin,
    },
  }
end)

client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
