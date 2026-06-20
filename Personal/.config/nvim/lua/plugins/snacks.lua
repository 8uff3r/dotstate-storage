return {
  "folke/snacks.nvim",

  keys = {
    {
      "<leader>H",
      function()
        Snacks.picker.explorer({
          layout = { preset = "select" },
          follow_file = false,
          cwd = "~",
        })
      end,
    },
  },
  ---@type snacks.Config
  opts = {
    terminal = {
      shell = "fish",
      -- your terminal configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },

    picker = {
      sources = {
        explorer = {
          hidden = true, -- Shows dotfiles (e.g. .gitignore, .env)
          ignored = false, -- Shows files ignored by your global/local .gitignore
        },
      },

      win = {
        list = {
          keys = {
            ["<a-.>"] = "toggle_hidden",
          },
        },
        input = {
          keys = {
            ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
