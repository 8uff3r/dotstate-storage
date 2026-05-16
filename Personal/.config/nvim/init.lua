-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd([[
set mouse=
set termbidi
set noarabicshape
]])

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "typescript", "javascript" },
  group = vim.api.nvim_create_augroup("rulebook.prettify-ts-error", { clear = true }),
  callback = function(ctx)
    vim.keymap.set("n", "<leader>rp", function()
      require("rulebook").prettifyError()
    end, { buffer = ctx.buf })
  end,
})
vim.g.snacks_animate = false
