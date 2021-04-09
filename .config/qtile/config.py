from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

# FG and BG colors
FG = "#d8dee9"
BG = "#2e3440"
borderColor = "#81a2be"

""" KEYBINDINGS
modifiers:
    A list of modifier specifications. Modifier specifications are one of:
    "shift", "lock", "control", "mod1", "mod2", "mod3", "mod4", "mod5".
key:
    A key specification, e.g. "a", "Tab", "Return", "space".
commands:
    If multiple Call objects are specified, they are run in sequence.
desc:
    description to be added to the key binding
"""

keys = [
    # Switch between windows
    Key([mod], "h",
        lazy.layout.left(),
        desc="Move focus to left"),
    Key([mod], "l",
        lazy.layout.right(),
        desc="Move focus to right"),
    Key([mod], "j",
        lazy.layout.down(),
        desc="Move focus down"),
    Key([mod], "k",
        lazy.layout.up(),
        desc="Move focus up"),
    Key([mod], "Tab",
        lazy.layout.next(),
        desc="Move window focus to other window"),
    Key([mod, "shift"], "Tab",
        lazy.layout.previous(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"),
    Key([mod], "space",
        lazy.layout.swap_main(),
        desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h",
        lazy.layout.shrink_main(),
        desc="Shrink main window in MonadTall"),
    Key([mod, "control"], "l",
        lazy.layout.grow_main(),
        desc="Grow main window in MonadTall"),
    Key([mod, "control"], "k",
        lazy.layout.grow(),
        desc="Grow current window"),
    Key([mod, "control"], "j",
        lazy.layout.shrink(),
        desc="Shrink current window"),
    Key([mod], "n",
        lazy.layout.reset(),
        desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    Key([mod], "m",
        lazy.window.toggle_maximize(),
        desc="Toggle maximize focused window"),
    Key([mod], "v",
        lazy.window.toggle_floating(),
        desc="Toggle floating on focused window"),
    # Key([mod, "shift"], "Return",
        # lazy.layout.toggle_split(),
        # desc="Toggle between split and unsplit sides of stack"),

    # Miscellaneous
    Key([mod], "period",
        lazy.hide_show_bar(),
        desc="Toggle bar"),
    Key([mod], "w",
        lazy.window.kill(),
        desc="Kill focused window"),
    Key([mod, "control"], "r",
        lazy.restart(),
        desc="Restart Qtile"),
    Key([mod, "control"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"),

]
groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layouts = [ layout.MonadTall(border_focus=borderColor,
                             border_width=1,
                             margin=9,
                             ratio=0.60,
                             max_ratio=0.9,
                             min_ratio=0.1),
            layout.Max(),
           layout.Columns(num_columns=3),
          ]

widget_defaults = dict(
    font='Ubuntu Nerd Font Light',
    # font='Noto Sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


top = bar.Bar(
    [
    widget.Spacer(
        length=960-54,
        foreground=FG),
    widget.Wttr(
        format="%t %c",
        location={"Partille": "Partille"},
        font="Ubuntu Nerd Font",
        foreground=FG),
    widget.Sep(
        size_percent=50,
        foreground=FG
    ),
    widget.Mpris2(
        name='spotifyd',
        objname="org.mpris.MediaPlayer2.spotifyd",
        display_metadata=['xesam:title', 'xesam:artist'],
        scroll_chars=30,
        stop_pause_text='asd',
        foreground=FG,
        # **widget_defaults
    ),
    widget.Clock(
        font="Ubuntu Nerd Font",
        format='%H:%M %a %d/%m',
        foreground=FG),
    # widget.Spacer(),
    ],
    24,
    opacity=0.8,
    name="bar",
    background=BG,
)

screens = [Screen(top=top)]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    # Click([mod], "Button2", lazy.window.bring_to_front())
    Click([mod], "Button8", lazy.window.toggle_floating())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=borderColor,
    border_width=1,
    float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='MATLAB R2021a - academic use')
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# Hide top bar at startup
@hook.subscribe.startup
def autostart():
    top.show(False)


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
