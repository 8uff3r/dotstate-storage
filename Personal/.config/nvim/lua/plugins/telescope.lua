return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        buffers = {
          mappings = {
            n = {
              ["d"] = "delete_buffer",
            },
            i = {
              ["<C-d>"] = "delete_buffer",
            },
          },
        },
      },
    },
  },
}
