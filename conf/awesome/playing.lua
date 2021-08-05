local helpers = require("lain.helpers")
local shell = require("awful.util").shell
local escape_f = require("awful.util").escape
local wibox = require("wibox")

local function factory(opts)
	local args = opts or {}
	local playing = { widget = args.widget or wibox.widget.textbox() }
	local timeout = args.timeout or 2

	local cmd = "playerctl metadata"

	function playing.update()
		helpers.async({ shell, "-c", cmd }, function(f)
			local playing_now = {
				random_mode = false,
				single_mode = false,
				repeat_mode = false,
				consume_mode = false,
				state = string.match(f, "Playing") or string.match(f, "Paused") or "N/A",
				artist = "N/A",
				title = "N/A",
				art_url = "N/A",
				album = "N/A",
				album_artist = "N/A",
			}

			for line in string.gmatch(f, "[^\n]+") do
				for k, v in string.gmatch(line, "spotify [%w]+:([%w]+)[%s]+(.+)") do
					if k == "artUrl" then
						playing_now.art_url = v
					elseif k == "artist" then
						playing_now.artist = escape_f(v)
					elseif k == "title" then
						playing_now.title = escape_f(v)
					elseif k == "album" then
						playing_now.album = escape_f(v)
					elseif k == "albumArtist" then
						playing_now.album_artist = escape_f(v)
					end
				end
			end

			playing.widget:set_text(string.format("%s - %s ", playing_now.title, playing_now.artist))
		end)
	end

	playing.timer = helpers.newtimer("playing", timeout, playing.update, true, true)

	return playing
end

return factory
