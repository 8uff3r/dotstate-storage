return {
  {
    "Shatur/neovim-ayu",
    lazy = true,
    config = function()
      vim.g.ayu_extended_palette = 1
      vim.g.ayu_sign_contrast = 1
      require("ayu").setup({
        --     mirage = false,
        --     overrides = {
        --       Normal = { bg = "None" },
        --       NormalFloat = { bg = "none" },
        --       ColorColumn = { bg = "None" },
        --       SignColumn = { bg = "None" },
        --       Folded = { bg = "None" },
        --       FoldColumn = { bg = "None" },
        --       CursorLine = { bg = "None" },
        --       CursorColumn = { bg = "None" },
        --       VertSplit = { bg = "None" },
        --       Pmenu = {
        --         bg = "None",
        --       },
        --       WhichKeyBorder = {
        --         fg = "#FFB454",
        --       },
        --       LspInlayHint = { fg = "#6E6A86", bg = "#221F2E" },
        --       TabLineFill = { bg = "None" },
        --     },
        --
        overrides = {
          Normal = {
            bg = "#07070D",
          },
          Pmenu = {
            bg = "#07070D",
          },
          NormalFloat = {
            bg = "#07070D",
          },
          WhichKeyFloat = {
            bg = "#07070D",
          },
          WhichKeyBorder = {
            fg = "#FFB454",
          },
          LspInlayHint = { fg = "#6E6A86", bg = "#221F2E" },
        }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
      })
      --
      --   vim.opt.background = "dark" -- set this to dark or light
    end,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    lazy = false,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      float = {
        transparent = true, -- enable transparent floating windows
        solid = true, -- use solid styling for floating windows, see |winborder|
      },
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        snacks = true,
        telescope = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.special.bufferline").get_theme()
          end
        end,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
