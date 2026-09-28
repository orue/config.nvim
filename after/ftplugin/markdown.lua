-- Markdown-specific configuration
-- (Markdown highlight colors live in lua/plugins/colorscheme.lua; Treesitter
-- highlighting is started by Neovim's built-in markdown ftplugin)

-- Better line breaking for markdown
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 2  -- Hide markup for cleaner view
vim.opt_local.spell = true       -- Enable spell check
vim.opt_local.textwidth = 80     -- Wrap at 80 characters

-- Markdown-specific keybindings
-- `e` flag: no error on lines without a checkbox; keeppatterns: leave search history alone
local map = vim.keymap.set
map("n", "<leader>mt", "i- [ ] ", { buffer = true, desc = "Insert TODO checkbox" })
map("n", "<leader>mc", "<cmd>keeppatterns s/- \\[ \\]/- [x]/e<cr>", { buffer = true, desc = "Check TODO" })
map("n", "<leader>mu", "<cmd>keeppatterns s/- \\[x\\]/- [ ]/e<cr>", { buffer = true, desc = "Uncheck TODO" })
