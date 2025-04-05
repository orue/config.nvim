local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set("n", "<leader>e", ":Ex<CR>")
vim.api.nvim_set_keymap("n", "<leader>q", ":wq<CR>", { noremap = true })

