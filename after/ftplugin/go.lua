-- Go formatting settings
vim.opt_local.expandtab = false  -- Go uses tabs
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "120"
vim.opt_local.textwidth = 120

-- Go-specific keymaps (matching Python setup)
vim.keymap.set("n", "<leader>rf", function()
  vim.lsp.buf.format({ async = true })
end, { buffer = true, desc = "Format Go file" })

vim.keymap.set("n", "<leader>ri", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind and action.kind:match("source.organizeImports")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Organize imports" })

-- Go-specific: Add tags to struct fields
vim.keymap.set("n", "<leader>rj", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.title and action.title:match("tags")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Add struct tags" })
