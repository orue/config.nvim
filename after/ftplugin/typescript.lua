-- TypeScript specific settings
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.colorcolumn = "100"
vim.opt_local.textwidth = 100

-- Format file (using conform.nvim with prettier)
vim.keymap.set("n", "<leader>rf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { buffer = true, desc = "Format TypeScript file" })

-- Organize imports
vim.keymap.set("n", "<leader>ri", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind and action.kind:match("source.organizeImports")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Organize imports" })
