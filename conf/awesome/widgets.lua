local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local gears = require("gears")
local lain = require("lain")
local wibox = require("wibox")

local theme = require("theme")

local markup = lain.util.markup
local separators = lain.util.separators

local spr = wibox.widget.textbox(" ")
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

-- icons
local mpdicon = wibox.widget.imagebox(theme.widget_music)
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mailicon = wibox.widget.imagebox(theme.widget_mail)
local neticon = wibox.widget.imagebox(theme.widget_net)
local memicon = wibox.widget.imagebox(theme.widget_mem)
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
local volicon = wibox.widget.imagebox(theme.widget_vol)
local baticon = wibox.widget.imagebox(theme.widget_battery)

local keyboardlayout = awful.widget.keyboardlayout:new()

local clock = awful.widget.watch("date +'%a %d %b %R'", 60, function(widget, stdout)
	widget:set_markup(" " .. markup.font(theme.font, stdout))
end)

local mem = lain.widget.mem({
	settings = function()
		local formatted = string.format(" %.2fGB ", mem_now.used / 1024)
		widget:set_markup(markup.font(theme.font, formatted))
	end,
})

local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
	end,
})

local temp = lain.widget.temp({
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
	end,
})

local net = lain.widget.net({
	settings = function()
		widget:set_markup(
			markup.font(
				theme.font,
				markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
					.. " "
					.. markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")
			)
		)
	end,
})

lain.widget.cal({
	attach_to = { clock },
	notification_preset = {
		font = "Iosevka 10",
		fg = theme.fg_normal,
		bg = theme.bg_normal,
	},
})

local bat = lain.widget.bat({
	settings = function()
		if bat_now.status and bat_now.status ~= "N/A" then
			if bat_now.ac_status == 1 then
				baticon:set_image(theme.widget_ac)
			elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
				baticon:set_image(theme.widget_battery_empty)
			elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
				baticon:set_image(theme.widget_battery_low)
			else
				baticon:set_image(theme.widget_battery)
			end
			widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
		else
			widget:set_markup(markup.font(theme.font, " AC "))
			baticon:set_image(theme.widget_ac)
		end
	end,
})

-- local mpd = lain.widget.mpd({
-- 	settings = function()
-- 		if mpd_now.state == "play" then
-- 			artist = " " .. mpd_now.artist .. " "
-- 			title = mpd_now.title .. " "
-- 			mpdicon:set_image(theme.widget_music_on)
-- 		elseif mpd_now.state == "pause" then
-- 			artist = " mpd "
-- 			title = "paused "
-- 		else
-- 			artist = ""
-- 			title = ""
-- 			mpdicon:set_image(theme.widget_music)
-- 		end
--
-- 		widget:set_markup(markup.font(theme.font, markup("#EA6F81", artist) .. title))
-- 	end,
-- })

local playing = require("playing")()

-- mpdicon:buttons(my_table.join(
-- 	awful.button({ "Mod4" }, 1, function()
-- 		awful.spawn("kitty -title Music -e ncmpcpp")
-- 	end),
-- 	awful.button({}, 1, function()
-- 		os.execute("mpc prev")
-- 		theme.mpd.update()
-- 	end),
-- 	awful.button({}, 2, function()
-- 		os.execute("mpc toggle")
-- 		theme.mpd.update()
-- 	end),
-- 	awful.button({}, 3, function()
-- 		os.execute("mpc next")
-- 		theme.mpd.update()
-- 	end)
-- ))

local volume = lain.widget.alsa({
	settings = function()
		if volume_now.status == "off" then
			volicon:set_image(theme.widget_vol_mute)
		elseif tonumber(volume_now.level) == 0 then
			volicon:set_image(theme.widget_vol_no)
		elseif tonumber(volume_now.level) <= 50 then
			volicon:set_image(theme.widget_vol_low)
		else
			volicon:set_image(theme.widget_vol)
		end

		widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
	end,
})

volume.widget:buttons(awful.util.table.join(
	awful.button({}, 1, function() -- left click
		awful.spawn("pavucontrol")
	end),
	awful.button({}, 2, function() -- middle click
		os.execute(string.format("%s set %s 100%%", volume.cmd, volume.channel))
		volume.update()
	end),
	awful.button({}, 3, function() -- right click
		os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
		volume.update()
	end),
	awful.button({}, 4, function() -- scroll up
		os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
		volume.update()
	end),
	awful.button({}, 5, function() -- scroll down
		os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
		volume.update()
	end)
))

-- volume.widget:buttons(awful.util.table.join(
-- 	awful.button({}, 4, function()
-- 		awful.util.spawn("amixer set Master 1%+")
-- 		theme.volume.update()
-- 	end),
-- 	awful.button({}, 5, function()
-- 		awful.util.spawn("amixer set Master 1%-")
-- 		theme.volume.update()
-- 	end)
-- ))

-- Mail IMAP check
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
local mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

local fs = lain.widget.fs({
	notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
	end,
})

local myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", "kitty -e man awesome" },
	{ "edit config", "kitty -e" .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

local mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", "kitty" },
	},
})
local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

local function lhs_widgets(s)
	return {
		layout = wibox.layout.fixed.horizontal,
		mylauncher,
		s.mytaglist,
		s.mypromptbox,
		spr,
	}
end

local function rhs_widgets(s)
	return {
		layout = wibox.layout.fixed.horizontal,
		wibox.widget.systray(),
		-- keyboardlayout,
		spr,
		arrl_ld,
		wibox.container.background(mpdicon, theme.bg_focus),
		wibox.container.background(playing.widget, theme.bg_focus),
		arrl_dl,
		volicon,
		volume.widget,
		-- arrl_ld,
		-- wibox.container.background(mailicon, theme.bg_focus),
		--wibox.container.background(mail.widget, theme.bg_focus),
		arrl_ld,
		wibox.container.background(memicon, theme.bg_focus),
		wibox.container.background(mem.widget, theme.bg_focus),
		arrl_dl,
		cpuicon,
		cpu.widget,
		arrl_ld,
		wibox.container.background(tempicon, theme.bg_focus),
		wibox.container.background(temp.widget, theme.bg_focus),
		-- arrl_ld,
		-- wibox.container.background(fsicon, theme.bg_focus),
		-- wibox.container.background(fs.widget, theme.bg_focus),
		arrl_dl,
		baticon,
		bat.widget,
		-- arrl_ld,
		-- wibox.container.background(neticon, theme.bg_focus),
		-- wibox.container.background(net.widget, theme.bg_focus),
		arrl_ld,
		wibox.container.background(clockicon, theme.bg_focus),
		wibox.container.background(clock, theme.bg_focus),
		wibox.container.background(spr, theme.bg_focus),
		arrl_dl,
		s.mylayoutbox,
	}
end

return {
	lhs_widgets = lhs_widgets,
	rhs_widgets = rhs_widgets,
	volume = volume,
}
