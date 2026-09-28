-- C: 4-space indent, 120-char ruler
require("config.lang").setup_buffer({ indent = 4, width = 120 })

-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)

-- Switch between header and source file (clangd feature)
vim.keymap.set("n", "<leader>rh", function()
  vim.cmd("LspClangdSwitchSourceHeader")
end, { buffer = true, desc = "Switch header/source" })
