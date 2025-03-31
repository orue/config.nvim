-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

vim.api.nvim_set_keymap("n", "<leader>q", ":wq<CR>", { noremap = true })

-- Fugitive
keymap.set("n", "<leader>g", ":vertical Git <cr>", opts)

-- Markdown Preview
keymap.set("n", "<leader>md", ":MarkdownPreviewToggle<cr>", opts)

-- bufferline
keymap.set("n", "<leader>bl", ":BufferLinePick<CR>", {desc = "Buffer Pick"},  opts)
keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", {desc = "Close Buffer"},  opts)

