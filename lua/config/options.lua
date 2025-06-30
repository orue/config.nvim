vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Line number
opt.number = true
opt.relativenumber = true

opt.shiftwidth = 2
opt.wrap = false
opt.clipboard = "unnamedplus"

opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.title = true
opt.showmode = false


-- search settings
-- opt.ignorecase = true
-- opt.smartcase = true

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- or any symbol you like
    format = function(diagnostic)
      return string.format("%s", diagnostic.message)
    end,
  },
})
