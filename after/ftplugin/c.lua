-- C formatting settings
vim.opt_local.expandtab = true  -- Use spaces (set to false for tabs)
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "120"
vim.opt_local.textwidth = 120

-- C-specific keymaps
-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)

-- Switch between header and source file (clangd feature)
vim.keymap.set("n", "<leader>rh", function()
  vim.cmd("ClangdSwitchSourceHeader")
end, { buffer = true, desc = "Switch header/source" })
