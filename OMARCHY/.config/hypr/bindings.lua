-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")


local v = require("vars")
local mainMod = "SUPER" -- Sets "SUPER" key as main modifier

---@type fun(dir: string): function
local into_or_out_of_group = function(dir)
    return function()
        local w = hl.get_active_window()
        if w ~= nil then
            if w.group then
                hl.dispatch(hl.dsp.window.move({ out_of_group = dir }))
            else
                hl.dispatch(hl.dsp.window.move({ into_group = dir }))
            end
        end
    end
end

---@type { [1]: string, [2]: function, [3]: HL.BindOptions?, [4]: string?}[]
local binds = {
    {
        "CTRL + F2",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"),
        { locked = true, repeating = true },
        "Increase volume (+2%)",
    },
    {
        "CTRL + F1",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
        { locked = true, repeating = true },
        "Decrease volume (-2%)",
    },

    -- Toggle Grouping for active window
    { mainMod .. " + CTRL + g",   hl.dsp.group.toggle(), "Toggle window group" },
    -- Focus next window in group
    { "ALT + L",                  hl.dsp.group.next(), "Focus next grouped window" },
    -- Focus previous window in group
    { "ALT + H",                  hl.dsp.group.prev(), "Focus previous grouped window" },
    -- Swap with next window in group
    { "ALT + SHIFT + L",          hl.dsp.group.move_window({ forward = true }), "Swap with next grouped window" },
    -- Swap with previous window in group
    { "ALT + SHIFT + H",          hl.dsp.group.move_window({ forward = false }), "Swap with previous grouped window" },

    -- Move window in/out of group in/to left
    { mainMod .. " + CTRL + H",   into_or_out_of_group("left"), "Move in/out of group (left)" },
    -- Move window in/out of group in/to right
    { mainMod .. " + CTRL + L",   into_or_out_of_group("right"), "Move in/out of group (right)" },
    -- Move window + in/out of group in/to up
    { mainMod .. " + CTRL + K",   into_or_out_of_group("up"), "Move in/out of group (up)" },
    -- Move window + in/out of group in/to down
    { mainMod .. " + CTRL + J",   into_or_out_of_group("down"), "Move in/out of group (down)" },

    -- Move focus with mainMod + arrow keys
    { mainMod .. " + H",          hl.dsp.focus({ direction = "left" }), "Focus window left" },
    { mainMod .. " + L",          hl.dsp.focus({ direction = "right" }), "Focus window right" },
    { mainMod .. " + K",          hl.dsp.focus({ direction = "up" }), "Focus window up" },
    { mainMod .. " + J",          hl.dsp.focus({ direction = "down" }), "Focus window down" },

    { mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left" }), "Move window left" },
    { mainMod .. " + SHIFT + L",  hl.dsp.window.move({ direction = "right" }), "Move window right" },
    { mainMod .. " + SHIFT + K",  hl.dsp.window.move({ direction = "up" }), "Move window up" },
    { mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }), "Move window down" },

    { mainMod .. " + S",          hl.dsp.workspace.toggle_special("special"), "Toggle scratchpad workspace" },
    { mainMod .. " + M",          hl.dsp.exec_cmd("mousefree"), "Toggle Mousefree mode" },
    { mainMod .. " + SHIFT + S",  hl.dsp.window.move({ workspace = "special:special" }), "Move window to scratchpad" },

    -- Scroll through existing workspaces with mainMod + scroll
    { mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "Next workspace" },
    { mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), "Previous workspace" },

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    {
        mainMod .. " + mouse:272",
        hl.dsp.window.drag(),
        { mouse = true },
        "Drag window",
    },
    {
        mainMod .. " + mouse:273",
        hl.dsp.window.resize(),
        { mouse = true },
        "Resize window with mouse",
    },

    {
        "CTRL + SHIFT + L",
        hl.dsp.window.resize({ x = 15, y = 0, relative = true }),
        { repeating = true },
        "Expand window right",
    },
    {
        "CTRL + SHIFT + H",
        hl.dsp.window.resize({ x = -15, y = 0, relative = true }),
        { repeating = true },
        "Shrink window left",
    },
    {
        "CTRL + SHIFT + K",
        hl.dsp.window.resize({ x = 0, y = 15, relative = true }),
        { repeating = true },
        "Expand window down",
    },
    {
        "CTRL + SHIFT + J",
        hl.dsp.window.resize({ x = 0, y = -15, relative = true }),
        { repeating = true },
        "Shrink window up",
    },
    { mainMod .. " + Escape", hl.dsp.focus({ workspace = "previous" }), "Focus previous workspace" },

    { mainMod .. " + X",      hl.dsp.window.float({ action = "toggle" }), "Toggle floating window" },
    { mainMod .. " + P",      hl.dsp.window.pseudo(), "Toggle pseudo-tiling" },
    { mainMod .. " + C",      hl.dsp.window.close(), "Close focused window" },
    { mainMod .. " + F",      hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Toggle full screen" },
    { mainMod .. " + D",      hl.dsp.window.fullscreen({ mode = "maximized" }), "Toggle maximized" },

    -- APPS
    { mainMod .. " + E",      hl.dsp.exec_cmd(v.fileManager), "Launch File Manager" },
    -- { mainMod .. " + R",      hl.dsp.exec_cmd(v.menu), "Launch App Launcher" },
    { mainMod .. " + Z",      hl.dsp.exec_cmd(v.editor), "Launch Code Editor" },
    { mainMod .. " + N",      hl.dsp.exec_cmd("export IS_NVIM=1 &&" .. v.terminal .. " -e nvim"), "Launch Neovim" },

    { mainMod .. " + Return", hl.dsp.exec_cmd(v.terminal), "Open Terminal" },
    {
        mainMod .. " + SHIFT + Return",
        hl.dsp.exec_cmd("wezterm -e nvim -c 'lua Snacks.terminal.focus(nil, { cwd = LazyVim.root() }) vim.cmd.only()'"),
        "Open Neovim terminal in root directory",
    },

    -- Laptop multimedia keys for volume and LCD brightness
    {
        "XF86AudioRaiseVolume",
        hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
        { locked = true, repeating = true },
        "Increase volume (+5%)",
    },
    {
        "XF86AudioLowerVolume",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        { locked = true, repeating = true },
        "Decrease volume (-5%)",
    },
    {
        "XF86AudioMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        { locked = true, repeating = true },
        "Toggle audio mute",
    },
    {
        "XF86AudioMicMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        { locked = true, repeating = true },
        "Toggle mic mute",
    },
    {
        "XF86MonBrightnessUp",
        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
        { locked = true, repeating = true },
        "Increase brightness (+5%)",
    },
    {
        "XF86MonBrightnessDown",
        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
        { locked = true, repeating = true },
        "Decrease brightness (-5%)",
    },
    {
        "XF86AudioNext",
        hl.dsp.exec_cmd("playerctl next"),
        { locked = true },
        "Next media track",
    },
    {
        "XF86AudioPause",
        hl.dsp.exec_cmd("playerctl play-pause"),
        { locked = true },
        "Pause media",
    },
    {
        "XF86AudioPlay",
        hl.dsp.exec_cmd("playerctl play-pause"),
        { locked = true },
        "Play/Pause media",
    },
    {
        "XF86AudioPrev",
        hl.dsp.exec_cmd("playerctl previous"),
        { locked = true },
        "Previous media track",
    },

    { mainMod .. " + Space", hl.dsp.exec_cmd("hyprctl switchxkblayout kanata next"), { locked = true }, "Switch keyboard layout" },
}



for _, value in ipairs(binds) do
    o.bind(value[1], value[4], value[2], value[3])
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    o.bind(mainMod .. " + " .. key, ("Switch to workspace %s"):format(i), hl.dsp.focus({ workspace = i }))
    o.bind(mainMod .. " + SHIFT + " .. key, ("Move window to workspace %s"):format(i),
        hl.dsp.window.move({ workspace = i }))
end

--------------------------
---- OMARCHY Bindings ----
--------------------------
-- Bindings copied over (with modifications to the keybinds) from Omarchy default bindings
o.bind("ALT + X", "Omarchy menu", "omarchy-menu toggle root")
o.bind("SUPER + R", "Omarchy menu", "omarchy-menu toggle apps")
o.bind("SUPER + V", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")
o.bind("SUPER + F2", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + ALT + K", "Tmux keybindings", "omarchy-menu-tmux-keybindings")
o.bind("SUPER + CTRL + K", "Herdr keybindings", "omarchy-menu-herdr-keybindings")
o.bind("SUPER + Q", "Power menu", "omarchy-menu toggle system", { locked = true })
o.bind("ALT + F4", "Lock system", "omarchy-system-lock")
