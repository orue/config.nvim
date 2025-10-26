local set = vim.opt_local

-- Terraform formatting settings
-- Terraform uses 2 spaces for indentation
set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2

-- Terraform-specific keymap for formatting
vim.keymap.set("n", "<leader>rf", function()
  vim.lsp.buf.format({ async = true })
end, { buffer = true, desc = "Format Terraform file" })
