-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "typescript", "javascript" },
  group = vim.api.nvim_create_augroup("rulebook.prettify-ts-error", { clear = true }),
  callback = function(ctx)
    vim.keymap.set("n", "<leader>rp", function()
      require("rulebook").prettifyError()
    end, { buffer = ctx.buf })
  end,
})

vim.lsp.document_color.enable(false)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.lsp.document_color.enable(false, { bufnr = ev.buf })
  end,
})
vim.filetype.add({
  extension = {
    slint = "slint",
  },
})
