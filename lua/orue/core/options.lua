local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Spell Checking
opt.spell = true
opt.spelllang = "en_us"

-- line wrapping
opt.wrap = false -- disable line wrapping

opt.laststatus = 3 -- Global Status Line


-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line
opt.colorcolumn = "120"
opt.textwidth = 120

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

opt.showmode = false -- Don't show the mode, since it's already in the status linie

opt.undofile = true -- file recovery

opt.updatetime = 250 -- interval for writing swap file to disk, also used by gitsigns

 
