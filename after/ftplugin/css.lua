-- CSS specific settings
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.colorcolumn = "120"
vim.opt_local.textwidth = 120

-- Format file (using conform.nvim with prettier)
vim.keymap.set("n", "<leader>rf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { buffer = true, desc = "Format CSS file" })
