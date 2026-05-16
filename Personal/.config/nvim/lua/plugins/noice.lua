return {
  "folke/noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = true,
    },

    messages = {
      view = "mini", -- use a tiny inline view instead of big popups
      view_error = "mini",
      view_warn = "mini",
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "written" }, -- file save notifications
            { find = "lines" }, -- yank/change line count
            { find = "fewer lines" },
            { find = "search hit" }, -- search wrap messages
          },
        },
        opts = { skip = true }, -- silently drop them
      },
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
    },
  },
}
