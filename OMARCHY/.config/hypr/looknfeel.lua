-- Change the default Omarchy look'n'feel.

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 10,

        border_size = 2,

        col = {
            -- active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            -- inactive_border = "rgba(595959aa)",
            -- nogroup_border = ("rgb(%s)"):format(c.colours.inversePrimary),
            -- nogroup_border_active = ("rgb(%s)"):format(c.colours.surfaceTint),
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    group = {
        auto_group = true,
        groupbar = {
            col = {
                active = hl.get_config("group.col.border_active"),
                inactive = hl.get_config("group.col.border_inactive"),
            },
            height = 18,
            gaps_in = 10,
            gaps_out = 0,
            keep_upper_gap = false,
            round_only_edges = true,
            gradient_rounding = 4,
            gradient_round_only_edges = true,
            indicator_height = 0,
        },
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(ee1a1a1a)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
            special = true,
        },
    },

    animations = {
        enabled = true,
    },
    misc = {
      enable_anr_dialog = false
    }
})
