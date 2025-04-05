vim.g.mapleader = " "                               -- change leader to a space
vim.g.maplocalleader = " "                          -- change localleader to a space

local opt = vim.opt

-- line numbers
opt.number = true                                   -- set numbered lines
opt.relativenumber = true                           -- set relative numbered lines

-- tabs & indentation
opt.shiftwidth = 2                                  -- the number of spaces inserted for each indentation
opt.numberwidth = 4                                 -- set number column width to 2 {default 4}
opt.smartindent = true                              -- make indenting smarter again
opt.expandtab = true                                -- convert tabs to spaces
opt.scrolloff = 10                                  -- Makes sure there are always ten lines of context
opt.sidescrolloff = 10                              -- Makes sure there are always ten lines of context
opt.breakindent = true                              -- wrap lines with indent
opt.wrap = false                                    -- display lines as one long line

-- Appearance
opt.termguicolors = true                            -- set term gui colors
opt.guifont = "monospace:h17"                       -- the font used in graphical neovim applications
opt.cursorline = true                               -- highlight the current cursor line
opt.signcolumn = "yes"                              -- always show the sign column, otherwise it would shift the text each time
opt.backspace = "indent,eol,start"                  -- allow backspace on indent, end of line or insert mode start position
opt.showtabline = 0                                 -- always show tabs
opt.title = true                                    -- set the title of window to the value of the titlestring
opt.ruler = false                                   -- Don't show the ruler
opt.mouse = "a"                                     -- allow the mouse to be used in neovim
opt.pumheight = 10                                  -- pop up menu height
opt.undofile = true                                 -- enable persistent undo
opt.conceallevel = 0                                -- so that `` is visible in markdown files
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
opt.smartcase = true                                -- smart case
opt.ignorecase = true                               -- ignore case in search patterns
opt.splitbelow = true                               -- force all horizontal splits to go below current window
opt.splitright = true                               -- force all vertical splits to go to the right of current window
opt.showcmd = false                                 -- Don't show the command in the last line
opt.showmode = true                                 -- Don't show the mode, since it's already in the statusline
opt.incsearch = true                                -- make search act like search in modern browsers
opt.cmdheight = 1                                   -- more space in the neovim command line for displaying messages
opt.hlsearch = true                                 -- highlight all matches on previous search pattern
--vim.opt.laststatus = 0 -- Always display the status line

-- Buffer
opt.fileencoding = "utf-8"                          -- the encoding written to a file
opt.confirm = true                                  -- confirm to save changes before exiting modified buffer
opt.swapfile = false                                -- creates a swapfile
opt.fillchars = { eob = " " }                       -- change the character at the end of buffer
opt.clipboard = "unnamedplus"                       -- allows neovim to access the system clipboard
opt.writebackup = false                             -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.backup = false                                  -- creates a backup file
opt.timeoutlen = 1000                               -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime = 100                                -- faster completion
