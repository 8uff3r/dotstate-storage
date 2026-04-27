local v = require("vars")
local mainMod = "SUPER" -- Sets "SUPER" key as main modifier

---@type fun(dir: string): function
local into_or_out_of_group = function(dir)
    return function()
        local w = hl.get_active_window()
        if w ~= nil then
            if w.group then
                hl.dispatch(hl.dsp.window.move({ out_of_group = dir, }))
            else
                hl.dispatch(hl.dsp.window.move({ into_group = dir }))
            end
        end
    end
end

---@type { [1]: string, [2]: function, [3]: HL.BindOptions?}[]
local binds = {
    {
        "CTRL + F12", hl.dsp.global("caelestia:brightnessUp"), { locked = true, repeating = true },
    },
    {
        "CTRL + F11", hl.dsp.global("caelestia:brightnessDown"), { locked = true, repeating = true }
    },

    {
        "CTRL + F2",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"),
        { locked = true, repeating = true }
    },
    {
        "CTRL + F1",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
        { locked = true, repeating = true }
    },

    -- Toggle Grouping for active window
    { mainMod .. " + CTRL + g",   hl.dsp.group.toggle() },
    -- Focus next window in group
    { "ALT + l",                  hl.dsp.group.next() },
    -- Focus previous window in group
    { "ALT + h",                  hl.dsp.group.prev() },
    -- Swap with next window in group
    { "ALT + SHIFT + l",          hl.dsp.group.move_window({ forward = true }) },
    -- Swap with previous window in group
    { "ALT + SHIFT + h",          hl.dsp.group.move_window({ forward = false }) },

    -- Move window in/out of group in/to left
    { mainMod .. " + CTRL + h",   into_or_out_of_group("left") },
    -- Move window in/out of group in/to right
    { mainMod .. " + CTRL + l",   into_or_out_of_group("right") },
    -- Move window + in/out of group in/to up
    { mainMod .. " + CTRL + k",   into_or_out_of_group("up") },
    -- Move window + in/out of group in/to down
    { mainMod .. " + CTRL + j",   into_or_out_of_group("down") },

    -- Move focus with mainMod + arrow keys
    { mainMod .. " + h",          hl.dsp.focus({ direction = "left" }) },
    { mainMod .. " + l",          hl.dsp.focus({ direction = "right" }) },
    { mainMod .. " + k",          hl.dsp.focus({ direction = "up" }) },
    { mainMod .. " + j",          hl.dsp.focus({ direction = "down" }) },

    { mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left" }) },
    { mainMod .. " + SHIFT + L",  hl.dsp.window.move({ direction = "right" }) },
    { mainMod .. " + SHIFT + K",  hl.dsp.window.move({ direction = "up" }) },
    { mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }) },

    { mainMod .. " + S",          hl.dsp.workspace.toggle_special("special") },
    { mainMod .. " + SHIFT + S",  hl.dsp.window.move({ workspace = "special:special" }) },

    -- Scroll through existing workspaces with mainMod + scroll
    { mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }) },
    { mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }) },

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    {
        mainMod .. " + mouse:272",
        hl.dsp.window.drag(),
        { mouse = true },
    },
    {
        mainMod .. " + mouse:273",
        hl.dsp.window.resize(),
        { mouse = true },
    },

    { mainMod .. " + X",       hl.dsp.window.float({ action = "toggle" }) },
    { mainMod .. " + P",       hl.dsp.window.pseudo() },
    { mainMod .. " + C",       hl.dsp.window.close() },
    { mainMod .. " + F",       hl.dsp.window.fullscreen({ mode = "fullscreen" }) },
    { mainMod .. " + D",       hl.dsp.window.fullscreen({ mode = "maximized" }) },

    -- APPS
    { mainMod .. " + E",       hl.dsp.exec_cmd(v.fileManager) },
    -- { mainMod .. " + R",      hl.dsp.exec_cmd(v.menu) },
    {mainMod.." + Z", hl.dsp.exec_cmd("zed")},

    -- { mainMod .. " + R",       hl.dsp.global("caelestia:launcher") },
    { mainMod .. " + R",       hl.dsp.exec_cmd("caelestia shell drawers toggle launcher") },
    { mainMod .. " + Q",       hl.dsp.global("caelestia:session") },
    { "CTRL + ALT + C",        hl.dsp.global("caelestia:clearNotifs"),                   { locked = true } },
    { mainMod .. " + Y",       hl.dsp.global("caelestia:showall") },
    { "ALT + 4",               hl.dsp.global("caelestia:lock") },
    { mainMod .. " + V",       hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard") },
    { mainMod .. " + ALT + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard -d") },
    { mainMod .. " + Period",  hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p") },
    { mainMod .. " + Return",  hl.dsp.exec_cmd(v.terminal) },


    -- Laptop multimedia keys for volume and LCD brightness
    {
        "XF86AudioRaiseVolume",
        hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioLowerVolume",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioMicMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        { locked = true, repeating = true },
    },
    {
        "XF86MonBrightnessUp",
        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
        { locked = true, repeating = true },
    },
    {
        "XF86MonBrightnessDown",
        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
        { locked = true, repeating = true },
    },
    {
        "XF86AudioNext",
        hl.dsp.exec_cmd("playerctl next"),
        { locked = true },
    },
    {
        "XF86AudioPause",
        hl.dsp.exec_cmd("playerctl play-pause"),
        { locked = true },
    },
    {
        "XF86AudioPlay",
        hl.dsp.exec_cmd("playerctl play-pause"),
        { locked = true },
    },
    {
        "XF86AudioPrev",
        hl.dsp.exec_cmd("playerctl previous"),
        { locked = true },
    },

    { "CTRL + SHIFT + l",               hl.dsp.window.resize({ x = 15, y = 0 }) },
    { "CTRL + SHIFT + h",               hl.dsp.window.resize({ x = -15, y = 0 }), },
    { "CTRL + SHIFT + k",               hl.dsp.window.resize({ x = 0, y = 15 }) },
    { "CTRL + SHIFT + j",               hl.dsp.window.resize({ x = 0, y = -15 }) },

    { mainMod .. " + Space",            hl.dsp.exec_cmd("hyprctl switchxkblayout kanata next"), { locked = true } },

    { mainMod .. " + Escape",           hl.dsp.focus({ workspace = "previous" }) },

    -- bind = $kbWindowPip, exec, caelestia resizer pip  # Move window to picture-in-picture mode
    --
    -- Utilities
    -- bindl = , Print, exec, caelestia screenshot  # Full screen capture > clipboard
    -- Capture region (freeze)
    { mainMod .. " + CTRL + S",         hl.dsp.global("caelestia:screenshotFreeze") },
    -- Capture region
    { mainMod .. " + SHIFT + ALT + S",  hl.dsp.global("caelestia:screenshot") },
    -- Record screen with sound
    { mainMod .. " + ALT + R",          hl.dsp.exec_cmd("caelestia record -s") },
    -- Record screen
    { "CTRL + ALT + R",                 hl.dsp.exec_cmd("caelestia record") },
    -- Record region
    { mainMod .. " + SHIFT + ALT + R",  hl.dsp.exec_cmd("caelestia record -r") },
    -- Colour picker
    { mainMod .. " + SHIFT + C",        hl.dsp.exec_cmd("hyprpicker -a ") }
}

for _, value in ipairs(binds) do
    hl.bind(value[1], value[2], value[3])
end


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
