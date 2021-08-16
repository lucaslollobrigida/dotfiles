local awful = require "awful"
local icons = require "themes.luna.icons"

awful.layout.layouts = {
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  awful.layout.suit.floating,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

-- local names = { "www", "code", "comms", "call", "media", "system", "others" }
local names = {
  icons.app.firefox,
  icons.app.default,
  icons.app.weechat,
  icons.app.zathura,
  icons.app.mpv,
  icons.app.spior,
  icons.widget.change_theme,
}

local l = awful.layout.suit
local layouts = { l.max, l.tile, l.max, l.floating, l.max, l.tile, l.tile }

return {
  workspaces = {
    names = names,
    layouts = layouts,
  },
}
