-- set leader key to space
vim.g.mapleader = " "

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Run line as Lua" })
vim.keymap.set("x", "<leader>x", ":lua<CR>", { desc = "Run selection as Lua" })

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })

-- Oil
vim.keymap.set("n", "<leader>-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

-- Alpha Dashboard
vim.keymap.set("n", "<leader>A", "<cmd>Alpha<CR>", { desc = "Open Dashboard" })

-- Buffer navigation
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Better indenting
vim.keymap.set("x", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right" })
vim.keymap.set("x", "<Left>", "<gv", { desc = "Indent left" })
vim.keymap.set("x", "<Right>", ">gv", { desc = "Indent right" })

-- Move lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("x", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
vim.keymap.set("x", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
