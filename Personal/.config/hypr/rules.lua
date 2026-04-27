---@type HL.WindowRuleSpec[]
local rules = {
    -- Opacity for non-fullscreen windows
    { match = { fullscreen = false },                                 opacity = 1.0 },

    -- Native transparency or force opaque
    {
        match = { class = "foot|equibop|org\\.quickshell|imv|swappy" },
        opacity = "1.0 override",
    },

    -- Center all floating windows (not xwayland)
    { match = { float = true, xwayland = false },                     center = true },

    -- Float
    { match = { class = "guifetch" },                                 float = true },
    { match = { class = "yad" },                                      float = true },
    { match = { class = "zenity" },                                   float = true },
    { match = { class = "wev" },                                      float = true },
    { match = { class = "org\\.gnome\\.FileRoller" },                 float = true },
    { match = { class = "file-roller" },                              float = true },
    { match = { class = "blueman-manager" },                          float = true },
    { match = { class = "com\\.github\\.GradienceTeam\\.Gradience" }, float = true },
    { match = { class = "feh" },                                      float = true },
    { match = { class = "imv" },                                      float = true },
    { match = { class = "system-config-printer" },                    float = true },
    { match = { class = "org\\.quickshell" },                         float = true },

    -- Float, resize and center
    {
        match = { class = "foot", title = "nmtui" },
        float = true,
        size = "60% 70%",
        center = true,
    },
    {
        match = { class = "org\\.gnome\\.Settings" },
        float = true,
        size = "70% 80%",
        center = true,
    },
    {
        match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" },
        float = true,
        size = "60% 70%",
        center = true,
    },
    {
        match = { class = "nwg-look" },
        float = true,
        size = "50% 60%",
        center = true,
    },

    -- Special workspaces
    {
        match = { class = "btop" },
        workspace = "special:sysmon"
    },
    {
        match = { class = "feishin|Spotify|Supersonic|Cider|com\\.github\\.th_ch\\.youtube_music|Plexamp" },
        workspace = "special:music"
    },
    {
        match = { initial_title = "Spotify( Free)?" },
        workspace = "special:music",
    },
    {
        match = { class = "discord|equibop|vesktop|whatsapp" },
        workspace = "special:communication",
    },
    {
        match = { class = "Todoist" },
        workspace = "special:todo",
    },

    -- Dialogs
    {
        match = { title = "(Select|Open)( a)? (File|Folder)(s)?" },
        float = true,
    },
    { match = { title = "File (Operation|Upload)( Progress)?" }, float = true },
    { match = { title = ".* Properties" },                       float = true },
    { match = { title = "Export Image as PNG" },                 float = true },
    { match = { title = "GIMP Crash Debug" },                    float = true },
    { match = { title = "Save As" },                             float = true },
    { match = { title = "Library" },                             float = true },

    -- Picture in picture
    {
        match = { title = "Picture(-| )in(-| )[Pp]icture" },
        move = "100%-w-2% 100%-w-3%",
        keep_aspect_ratio = true,
        float = true,
        pin = true,
    },

    -- Creative software
    {
        match = { class = "krita|gimp|inkscape|darktable|resolve|kdenlive|shotcut|blender|godot" },
        opacity = "1.0 override",
    },

    -- Ueberzugpp
    {
        match = { class = "ueberzugpp_.*" },
        float = true,
        no_initial_focus = true,
    },

    -- Steam
    {
        match = { class = "steam" },
        rounding = 10,
    },
    {
        match = { class = "steam", title = "Friends List" },
        float = true,
    },

    -- Games (Steam, Lutris/Wine, Gamescope)
    {
        match = { class = "steam_app_(default|[0-9]+)|gamescope" },
        opacity = "1.0 override",
        immediate = true,
        idle_inhibit = "always",
    },

    -- Minecraft launcher consoles
    {
        match = { class = "com-atlauncher-App", title = "ATLauncher Console" },
        float = true,
    },
    {
        match = { class = "PandoraLauncher", title = "Minecraft Game Output" },
        float = true,
    },

    -- Autodesk Fusion 360
    {
        match = { class = "fusion360\\.exe", title = "Fusion360|(Marking Menu)" },
        no_blur = true,
    },

    -- Xwayland popups
    {
        match = { xwayland = true, title = "win[0-9]+" },
        no_dim = true,
        no_shadow = true,
        rounding = 10
    },
}

---@type HL.LayerRuleSpec[]
local layer_rules = {
    { match = { namespace = "hyprpicker" },    animation = "fade" },
    { match = { namespace = "logout_dialog" }, animation = "fade" },
    { match = { namespace = "selection" },     animation = "fade" },
    { match = { namespace = "wayfreeze" },     animation = "fade" },

    -- Fuzzel
    { match = { namespace = "launcher" },      animation = "popin 80%", blur = true },

    -- Shell
    {
        match = { namespace = "caelestia-(border-exclusion|area-picker)" },
        no_anim = true,
    },
    {
        match = { namespace = "caelestia-(drawers|background)" },
        animation = "fade",
    },
    {
        match = { namespace = "caelestia-drawers" },
        blur = true,
        ignore_alpha = 0.57,
    },

    { match = { namespace = "gtk4-layer-shell" }, no_anim = true },
}

for _, value in ipairs(rules) do
    hl.window_rule(value)
end

for _, value in ipairs(layer_rules) do
    hl.layer_rule(value)
end

---@type HL.WindowRuleSpec[]
local rules_2 = {
    -- Border colors
    { match = { pin = true, float = true }, border_color = "rgb(D9A2D0)" },
    { match = { fullscreen = true }, border_color = "rgb(FFB454)" },
    { match = { fullscreen = true, float = true }, border_color = "rgb(FFB454)" },
    { match = { pin = false, float = true }, border_color = "rgb(349CCF)" },

    -- Group
    { match = { class = ".*" }, group = "set" },
    { match = { float = true }, group = "deny" },
    { match = { class = "^(steam)$", title = "^(Steam Big Picture Mode)$" }, fullscreen = true },
    { match = { class = "^(steam_app_[0-9]+)$" }, group = "deny" },

    -- Apps
    { match = { class = "^(org.telegram.desktop)$" }, workspace = "special:special" },
    { match = { class = "^(v2rayN)$" }, workspace = "special:special" },
    { match = { class = "gephgui-wry" }, float = true },
    { match = { class = "^(nvim)$" }, workspace = "1" },
    { match = { class = "^(dev.zed.Zed)$" }, workspace = "1" },
    { match = { class = "^(brave-browser)$" }, workspace = "2" },
    { match = { class = "^(zen)$" }, workspace = "2" },
    { match = { class = "^(steam_app_.*)$" }, fullscreen = true },
    { match = { class = "^()$", title = "^(Steam - Self Updater)$" }, float = true },
    { match = { class = "^(blueman-manager)$" }, float = true },
    { match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true },
    { match = { class = "^(zenity)$" }, float = true },
    { match = { class = "krunner" }, float = true },
    { match = { title = "Telegram" }, opacity = "0.95" },
    { match = { title = "QQ" }, opacity = "0.95" },
    { match = { class = "kitty" }, animation = "slide right" },
    { match = { class = "alacritty" }, animation = "slide right" },
    { match = { class = "^(firefox)$" }, no_blur = true },
    { match = { class = "^(waybar)$" }, no_blur = true },
    { match = { class = "blueman-manager" }, size = "783 411" },

    -- amnezia
    { match = { class = "^(AmneziaVPN)$" }, float = true, group = "deny" },

    { match = { class = "mpv" }, group = "deny" },
    -- mpv
    { match = { class = "mpv" }, group = "deny", float = true, size = "960 540" },

    -- org.freedesktop.impl.portal.desktop.kde
    { match = { class = "org.freedesktop.impl.portal.desktop.kde" }, float = true, size = "740 490" },

    { match = { class = "steam" }, group = "deny" },
    -- steam
    { match = { class = "^(steam)$" }, group = "deny", suppress_event = "fullscreen" },

    -- brave file picker
    { match = { class = "^(brave-browser)$", title = "^(Open File)$|^(Save File)$" }, float = true },

    -- winboat
    { match = { class = "^(winboat-.*)" }, float = true, group = "deny", border_size = 0, fullscreen_state = "0 0", rounding = 0, no_shadow = true },

    -- xdg-desktop-portal
    { match = { class = "^(xdg-desktop-portal-.*)$" }, float = true },

    -- imv
    { match = { class = "imv" }, float = true, move = "cursor_x-(window_w*0.25) cursor_y-(window_h*0.25)", size = "960 540" },

    { match = { title = "^(Picture-in-Picture)$" }, group = "deny" },
    { match = { title = "^(Picture in picture)$" }, group = "deny" },
    -- picture-in-picture
    { match = { title = "^(Picture-in-Picture)$|^(Picture in picture)$" }, float = true, size = "960 540", move = "25% -", pin = true, group = "deny", suppress_event = "activatefocus" },

    -- termfloat
    { match = { class = "termfloat" }, float = true, move = "cursor_x-(window_w*0.25) cursor_y-(window_h*0.25)", size = "960 540", rounding = 5 },

    -- nemo
    { match = { class = "nemo" }, float = true, move = "cursor_x-(window_w*0.25) cursor_y-(window_h*0.25)", size = "960 540" },

    -- ncmpcpp
    { match = { class = "ncmpcpp" }, float = true, move = "cursor_x-(window_w*0.25) cursor_y-(window_h*0.25)", size = "960 540" },

    -- lucien
    { match = { class = "^(lucien)$" }, no_blur = true, border_size = 0, no_shadow = true },

    { match = { class = ".*-dev-linux-amd64" }, float = true, group = "deny" },
    -- wails apps
    { match = { class = "^(.*)(-dev-linux-amd64)$" }, float = true, group = "deny" },

    -- Disable blur for xwayland context menus
    { match = { class = "^()$", title = "^()$" }, no_blur = true },

    -- Floating: title-based
    { match = { title = "^(Open File)(.*)$" }, float = true, center = true },
    { match = { title = "^(Select a File)(.*)$" }, float = true, center = true },
    { match = { title = "^(Choose wallpaper)(.*)$" }, float = true, center = true, size = "(monitor_w*.60) (monitor_h*.65)" },
    { match = { title = "^(Open Folder)(.*)$" }, float = true, center = true },
    { match = { title = "^(Save As)(.*)$" }, float = true, center = true },
    { match = { title = "^(Library)(.*)$" }, float = true, center = true },
    { match = { title = "^(File Upload)(.*)$" }, float = true, center = true },
    { match = { title = "^(.*)(wants to save)$" }, float = true, center = true },
    { match = { title = "^(.*)(wants to open)$" }, float = true, center = true },

    -- Floating: class-based
    { match = { class = "^(blueberry\\.py)$" }, float = true },
    { match = { class = "^(guifetch)$" }, float = true },
    { match = { class = "^(pavucontrol)$" }, float = true, size = "(monitor_w*.45) (monitor_h*.45)", center = true },
    { match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true, size = "(monitor_w*.45) (monitor_h*.45)", center = true },
    { match = { class = "^(nm-connection-editor)$" }, float = true, size = "(monitor_w*.45) (monitor_h*.45)", center = true },
    { match = { class = ".*plasmawindowed.*" }, float = true },
    { match = { class = "kcm_.*" }, float = true },
    { match = { class = ".*bluedevilwizard" }, float = true },
    { match = { title = ".*Welcome" }, float = true },
    { match = { title = "^(illogical-impulse Settings)$" }, float = true },
    { match = { title = ".*Shell conflicts.*" }, float = true },
    { match = { class = "org.freedesktop.impl.portal.desktop.kde" }, float = true, size = "(monitor_w*.60) (monitor_h*.65)" },
    { match = { class = "^(Zotero)$" }, float = true, size = "(monitor_w*.45) (monitor_h*.45)" },

    -- Move: plasma-changeicons (keep off-screen, no focus)
    { match = { class = "^(plasma-changeicons)$" }, float = true, no_initial_focus = true, move = "999999 999999" },

    -- Dolphin
    { match = { class = "^(org.kde.dolphin)$", title = "^(Copying — Dolphin)$" }, no_initial_focus = true },
    { match = { class = "^(org.kde.dolphin)$", title = "^(.* — Dolphin)$" }, group = "deny" },

    -- Tiling
    { match = { class = "^dev\\.warp\\.Warp$" }, tile = true },

    -- Picture-in-Picture
    { match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, float = true, keep_aspect_ratio = true, move = "(monitor_w*.73) (monitor_h*.72)", size = "(monitor_w*.25) (monitor_h*.25)", pin = true },

    -- Tearing
    { match = { title = ".*\\.exe" }, immediate = true },
    { match = { title = ".*minecraft.*" }, immediate = true },
    { match = { class = "^(steam_app).*" }, immediate = true },

    -- Fix JetBrains IDEs focus/rerendering
    { match = { class = "^jetbrains-.*$", float = true, title = "^$|^\\s$|^win\\d+$" }, no_initial_focus = true },

    -- No shadow for tiled windows
    { match = { float = false }, no_shadow = true },
}
for _, value in ipairs(rules_2) do
    hl.window_rule(value)
end

hl.workspace_rule({ workspace = "special:special", gaps_out = 50 })
