vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "120"
vim.opt_local.textwidth = 120

-- Python-specific keymaps
vim.keymap.set("n", "<leader>rf", function()
  vim.lsp.buf.format({ async = true })
end, { buffer = true, desc = "Format Python file" })

vim.keymap.set("n", "<leader>ri", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind and action.kind:match("source.organizeImports")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Organize imports" })
