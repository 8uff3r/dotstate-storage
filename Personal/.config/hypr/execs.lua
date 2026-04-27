local v = require("vars")

local cmds = {
    "gnome-keyring-daemon --start --components=secrets",
    "/usr/lib/polkit-kde-authentication-agent-1",
    -- Clipboard history
    "wl-paste --type text --watch cliphist store",
    "wl-paste --type image --watch cliphist store",

    -- Auto delete trash 30 days old
    "trash-empty 30",

    -- Cursors
    ("hyprctl setcursor %s %s"):format(v.cursorTheme, v.cursorSize),
    ("gsettings set org.gnome.desktop.interface cursor-theme '%s'"):format(v.cursorTheme),
    ("gsettings set org.gnome.desktop.interface cursor-size %s"):format(v.cursorSize),
    "dbus-update-activation-environment --all",
    "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP", -- Some fix idk


    -- Location provider and night light
    "/usr/lib/geoclue-2.0/demos/agent",
    "sleep 1 && gammastep",

    -- Forward bluetooth media commands to MPRIS
    "mpris - proxy",

    -- Resize and move windows based on matches(e.g.pip)
    "caelestia resizer - d",

    -- Start shell
    "caelestia shell - d",


    "xwayland-satellite",
    -- exec-once = v2rayN
    "udiskie"
}
hl.on("hyprland.start", function()
    for _, value in ipairs(cmds) do
        hl.exec_cmd(value)
    end
end)
