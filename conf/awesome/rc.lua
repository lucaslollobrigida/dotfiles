pcall(require, "luarocks.loader")

local beautiful = require "beautiful"

require "awful.autofocus"
require "awful.hotkeys_popup.keys"

require "ensure"
require "notifications"

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(string.format("%s/.config/awesome/theme/init.lua", os.getenv("HOME")))
beautiful.init(string.format("%s/.config/awesome/themes/luna/theme.lua", os.getenv "HOME"))

require "widgets"
require "rules"
