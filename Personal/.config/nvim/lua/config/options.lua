-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local options = {
  swapfile = false,
  termbidi = true,
  arabicshape = false,
  mousemodel = "extend",
  sidescrolloff = 8, -- Number of columns to keep at the sides of the cursor
  undofile = true, -- Enable persistent undo
  wrap = true, -- enable wrapping of lines longer than the width of window
  writebackup = false,
  exrc = true,
  secure = false,
}

local globals = {
  maplocalleader = " ",
  mapleader = " ", -- set leader key
  highlighturl_enabled = true, -- highlight URLs by default
  codelens_enabled = true, -- enable or disable automatic codelens refreshing for lsp that support it
  snacks_animate = false,
  lazyvim_picker = "snacks",
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end
