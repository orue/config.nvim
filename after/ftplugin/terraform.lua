local set = vim.opt_local

-- Terraform formatting settings
-- Terraform uses 2 spaces for indentation
set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2

-- Note: <leader>rf formatting is handled by conform.nvim with LSP fallback (see lua/plugins/formatter.lua)
