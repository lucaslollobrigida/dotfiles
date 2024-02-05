import subprocess
import os

from libqtile import hook, bar, layout, widget
from libqtile.lazy import lazy
from libqtile.config import Click, Drag, Group, Key, Match, Screen

@hook.subscribe.startup
def dbus_register():
    id = os.environ.get('DESKTOP_AUTOSTART_ID')
    if not id:
        return
    subprocess.Popen(['dbus-send',
                      '--session',
                      '--print-reply',
                      '--dest=org.gnome.SessionManager',
                      '/org/gnome/SessionManager',
                      'org.gnome.SessionManager.RegisterClient',
                      'string:qtile',
                      'string:' + id])

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart')
    subprocess.Popen([home])

mod = "mod4"
terminal = "alacritty"

colors_background = "#181825"
colors_foreground = "#C5C8C6"
colors_white = "#cdd6f4"
colors_black = "#1e1e2e"
colors_blue = "#89b4fa"
colors_red = "#f38ba8"
colors_green = "#a6e3a1"
colors_yellow = "#f9e2af"
colors_cyan = "#89dceb"
colors_magenta = "#eba0ac"

keys = [
        Key([mod], "p", lazy.spawn("rofi -show drun -show-icons -icon-theme \"Papirus\" -theme ~/.config/leftwm/themes/current/rofi/launcher.rasi"), desc="Open Rofi"),

        # Switch between windows
        Key([mod], "j", lazy.layout.next(), desc="Move window focus to next window"),
        Key([mod], "k", lazy.layout.previous(), desc="Move window focus to previous window"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

        Key([mod, "control"], "h", lazy.layout.shrink(), desc="Shrinks the window horizontally"),
        Key([mod, "control"], "l", lazy.layout.grow(), desc="Grows the window horizontally"),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [mod, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
            ),
        Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "BackSpace", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

        Key([], "Print", lazy.spawn("flameshot gui")),
        Key([], "Delete", lazy.spawn("lock-screen")),
        # F1
        Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
        # F2
        Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 5%+")),
        # F3
        # Key([], "", lazy.spawn("")),
        # F4
        # Key([], "", lazy.spawn("")),
        # F5
        Key([], "XF86KbdBrightnessDown", lazy.spawn("xbacklight -dec 10")),
        # F6
        Key([], "XF86KbdBrightnessUp", lazy.spawn("xbacklight -inc 10")),
        # F7
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
        # F8
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
        # F9
        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        # F10
        Key([], "XF86AudioMute", lazy.spawn("amixer -q -D pulse sset Master toggle")),
        # F11
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q -D pulse sset Master 5%-")),
        # F12
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q -D pulse sset Master 5%+")),
        ]

workspaces = ["", "", "", "", "", "", "", "☭"]

groups = [Group(i) for i in workspaces]

for index, group in enumerate(groups):
    keys.extend(
            [
                # mod1 + letter of group = switch to group
                Key(
                    [mod],
                    str(index + 1),
                    lazy.group[group.name].toscreen(),
                    desc="Switch to group {}".format(group.name),
                    ),
                # mod1 + shift + letter of group = switch to & move focused window to group
                Key(
                    [mod, "shift"],
                    str(index + 1),
                    lazy.window.togroup(group.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(group.name),
                    ),
                # Or, use below if you prefer not to switch to that group.
                # # mod1 + shift + letter of group = move focused window to group
                # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                #     desc="move focused window to group {}".format(i.name)),
                ]
            )

layouts = [
        layout.MonadTall(border_focus=colors_foreground, border_normal=colors_background, border_width=1),
        layout.Max(),
        # Try more layouts by unleashing below layouts.
        # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=2),
        # layout.Stack(num_stacks=2),
        # layout.Bsp(),
        # layout.Matrix(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
        ]

widget_defaults = dict(
        font="SauceCodePro Nerd Font",
        fontsize=13,
        padding=3,
        )
extension_defaults = widget_defaults.copy()

bar = bar.Bar(
        [
            widget.CurrentLayoutIcon(
                custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
                background="#181825",
                foreground="#89b4fa",
                ),
            widget.GroupBox(
                background="#181825",
                foreground="#e5c07b",
                highlight_method='line',
                ),
            widget.Spacer(
                background="#181825",
                foreground="#abb2bf",
                ),
            widget.Systray(padding=6),
            widget.Spacer(length=6),
            # widget.Backlight(
            #   background=colors_background,
            #   foreground="#abb2bf",
            #   backlight_name='acpi_video0',
            #   brightness_file='brightness',
            #   format= '{percent:2.0%}',
            # ),
            # widget.CheckUpdates(distro="Ubuntu", no_update_string='No updates'),

            widget.Spacer(length=6),
            widget.TextBox(
                fontsize = 15,
                text = "墳",
                # background="#181825",
                foreground="#98c379",
                ),
            widget.PulseVolume(),

            widget.Spacer(length=6),
            widget.TextBox(
                fontsize = 15,
                text=" ",
                foreground="#61afef",
                ),
            widget.Battery(format='{percent:2.0%}'),
            widget.TextBox(
                fontsize = 15,
                text = "",
                foreground="#eba0ac",
                ),
            widget.Clock(format="%a %d/%m %I:%M %p"),
            widget.QuickExit(
                foreground="#e06c75",
                default_text = "⏻ ",
                fontsize=15,
                ),
            ],
            24,
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        )

screens = [
        Screen(
            bottom=bar
            )
        ]

# Drag floating layouts.
mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front()),
        ]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
            ]
        )
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
