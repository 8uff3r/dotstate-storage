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

---@type { [1]: string, [2]: string, [3]: function|HL.Dispatcher|string, [4]: HL.BindOptions?}[]
local binds = {
    {
        "CTRL + F2",
        "Increase volume (+2%)",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"),
        { locked = true, repeating = true },
    },
    {
        "CTRL + F1",
        "Decrease volume (-2%)",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
        { locked = true, repeating = true },
    },

    -- Toggle Grouping for active window
    { mainMod .. " + CTRL + g",   "Toggle window group",               hl.dsp.group.toggle() },
    -- Focus next window in group
    { "ALT + L",                  "Focus next grouped window",         hl.dsp.group.next() },
    -- Focus previous window in group
    { "ALT + H",                  "Focus previous grouped window",     hl.dsp.group.prev() },
    -- Swap with next window in group
    { "ALT + SHIFT + L",          "Swap with next grouped window",     hl.dsp.group.move_window({ forward = true }) },
    -- Swap with previous window in group
    { "ALT + SHIFT + H",          "Swap with previous grouped window", hl.dsp.group.move_window({ forward = false }) },

    -- Move window in/out of group in/to left
    { mainMod .. " + CTRL + H",   "Move in/out of group (left)",       into_or_out_of_group("left") },
    -- Move window in/out of group in/to right
    { mainMod .. " + CTRL + L",   "Move in/out of group (right)",      into_or_out_of_group("right") },
    -- Move window + in/out of group in/to up
    { mainMod .. " + CTRL + K",   "Move in/out of group (up)",         into_or_out_of_group("up") },
    -- Move window + in/out of group in/to down
    { mainMod .. " + CTRL + J",   "Move in/out of group (down)",       into_or_out_of_group("down") },

    -- Move focus with mainMod + arrow keys
    { mainMod .. " + H",          "Focus window left",                 hl.dsp.focus({ direction = "left" }) },
    { mainMod .. " + L",          "Focus window right",                hl.dsp.focus({ direction = "right" }) },
    { mainMod .. " + K",          "Focus window up",                   hl.dsp.focus({ direction = "up" }) },
    { mainMod .. " + J",          "Focus window down",                 hl.dsp.focus({ direction = "down" }) },

    { mainMod .. " + SHIFT + H",  "Move window left",                  hl.dsp.window.move({ direction = "left" }) },
    { mainMod .. " + SHIFT + L",  "Move window right",                 hl.dsp.window.move({ direction = "right" }) },
    { mainMod .. " + SHIFT + K",  "Move window up",                    hl.dsp.window.move({ direction = "up" }) },
    { mainMod .. " + SHIFT + J",  "Move window down",                  hl.dsp.window.move({ direction = "down" }) },

    { mainMod .. " + S",          "Toggle scratchpad workspace",       hl.dsp.workspace.toggle_special("special") },
    { mainMod .. " + M",          "Toggle Mousefree mode",             hl.dsp.exec_cmd("mousefree") },
    { mainMod .. " + SHIFT + S",  "Move window to scratchpad",         hl.dsp.window.move({ workspace = "special:special" }) },

    -- Scroll through existing workspaces with mainMod + scroll
    { mainMod .. " + mouse_down", "Next workspace",                    hl.dsp.focus({ workspace = "e+1" }) },
    { mainMod .. " + mouse_up",   "Previous workspace",                hl.dsp.focus({ workspace = "e-1" }) },

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    {
        mainMod .. " + mouse:272",
        "Drag window",
        hl.dsp.window.drag(),
        { mouse = true },
    },
    {
        mainMod .. " + mouse:273",
        "Resize window with mouse",
        hl.dsp.window.resize(),
        { mouse = true },
    },

    {
        "CTRL + SHIFT + L",
        "Expand window right",
        hl.dsp.window.resize({ x = 15, y = 0, relative = true }),
        { repeating = true },
    },
    {
        "CTRL + SHIFT + H",
        "Shrink window left",
        hl.dsp.window.resize({ x = -15, y = 0, relative = true }),
        { repeating = true },
    },
    {
        "CTRL + SHIFT + K",
        "Expand window down",
        hl.dsp.window.resize({ x = 0, y = 15, relative = true }),
        { repeating = true },
    },
    {
        "CTRL + SHIFT + J",
        "Shrink window up",
        hl.dsp.window.resize({ x = 0, y = -15, relative = true }),
        { repeating = true },
    },
    { mainMod .. " + Escape", "Focus previous workspace", hl.dsp.focus({ workspace = "previous" }) },

    { mainMod .. " + X",      "Toggle floating window",   hl.dsp.window.float({ action = "toggle" }) },
    { mainMod .. " + P",      "Toggle pseudo-tiling",     hl.dsp.window.pseudo() },
    { mainMod .. " + C",      "Close focused window",     hl.dsp.window.close() },
    { mainMod .. " + F",      "Toggle full screen",       hl.dsp.window.fullscreen({ mode = "fullscreen" }) },
    { mainMod .. " + D",      "Toggle maximized",         hl.dsp.window.fullscreen({ mode = "maximized" }) },

    -- APPS
    { mainMod .. " + E",      "Launch File Manager",      hl.dsp.exec_cmd(v.fileManager) },
    -- { mainMod .. " + R",   "Launch App Launcher",                 hl.dsp.exec_cmd(v.menu) },
    { mainMod .. " + Z",      "Launch Code Editor",       hl.dsp.exec_cmd(v.editor) },
    { mainMod .. " + N",      "Launch Neovim",            hl.dsp.exec_cmd("export IS_NVIM=1 &&" .. v.terminal .. " -e nvim") },

    { mainMod .. " + Return", "Open Terminal",            hl.dsp.exec_cmd(v.terminal) },
    {
        mainMod .. " + SHIFT + Return",
        "Open Neovim terminal in root directory",
        hl.dsp.exec_cmd("wezterm -e nvim -c 'lua Snacks.terminal.focus(nil, { cwd = LazyVim.root() }) vim.cmd.only()'"),
    },

    -- Laptop multimedia keys for volume and LCD brightness
    {
        "XF86AudioRaiseVolume",
        "Increase volume (+5%)",
        hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioLowerVolume",
        "Decrease volume (-5%)",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioMute",
        "Toggle audio mute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioMicMute",
        "Toggle mic mute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        { locked = true, repeating = true },
    },
    {
        "XF86MonBrightnessUp",
        "Increase brightness (+5%)",
        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
        { locked = true, repeating = true },
    },
    {
        "XF86MonBrightnessDown",
        "Decrease brightness (-5%)",
        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioNext",
        "Next media track",
        hl.dsp.exec_cmd("playerctl next"),
        { locked = true },
    },
    {
        "XF86AudioPause",
        "Pause media",
        hl.dsp.exec_cmd("playerctl play-pause"),
        { locked = true },
    },
    {
        "XF86AudioPlay",
        "Play/Pause media",
        hl.dsp.exec_cmd("playerctl play-pause"),
        { locked = true },
    },
    {
        "XF86AudioPrev",
        "Previous media track",
        hl.dsp.exec_cmd("playerctl previous"),
        { locked = true },
    },

    { mainMod .. " + Space", "Switch keyboard layout", hl.dsp.exec_cmd("hyprctl switchxkblayout kanata next"), { locked = true } },


    --------------------------
    ---- OMARCHY Bindings ----
    --------------------------
    -- Bindings copied over (with modifications to the keybinds) from Omarchy default bindings
    {
        "ALT + X",
        "Omarchy menu",
        "omarchy-menu toggle root",
    },
    {
        "SUPER + R",
        "Omarchy menu",
        "omarchy-menu toggle apps",
    },
    {
        "SUPER + F2",
        "Keybindings",
        "omarchy-menu-keybindings",
    },
    {
        "SUPER + V",
        "Clipboard manager",
        "omarchy-shell shell toggle omarchy.clipboard",
    },
    {
        "SUPER + ALT + K",
        "Tmux keybindings",
        "omarchy-menu-tmux-keybindings",
    },
    {
        "SUPER + Q",
        "Power menu",
        "omarchy-menu toggle system",
        { locked = true },
    },
    {
        "ALT + 4",
        "Lock system",
        "omarchy-system-lock",
    },
    {
        "SUPER + CTRL + S",
        "Take a screenshot",
        "omarchy-shell b.omashot show",
    },
    {
        "SUPER + ALT + S",
        "Extract text (OCR) from screenshot",
        "omarchy-capture-text",
    },
    {
        "SUPER + CTRL + X",
        "Toggle dictation",
        "voxtype record toggle",
    },
    {
        "F9",
        "Start dictation (push-to-talk)",
        "voxtype record start",
    },
    {
        "F9",
        "Stop dictation (push-to-talk)",
        "voxtype record stop",
        { release = true }
    },
    {
        "SUPER + W",
        "Everything",
        "omarchy-shell shell toggle b.everything"
    }
}

for _, value in ipairs(binds) do
    o.bind(value[1], value[2], value[3], value[4])
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    o.bind(mainMod .. " + " .. key, "Switch to workspace " .. i, hl.dsp.focus({ workspace = i }))
    o.bind(mainMod .. " + SHIFT + " .. key, "Move window to workspace " .. i,
        hl.dsp.window.move({ workspace = i }))
    o.bind("SUPER + CTRL + " .. key, "Move window silently to workspace " .. i,
        hl.dsp.window.move({ workspace = tostring(i), follow = false }))
end
