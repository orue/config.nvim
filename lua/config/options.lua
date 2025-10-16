vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Line number
opt.number = true
opt.relativenumber = true

opt.shiftwidth = 2
opt.wrap = true
opt.clipboard = "unnamedplus"

opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.title = true
opt.showmode = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Python-friendly settings
opt.updatetime = 250
opt.timeoutlen = 300

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 4,
    format = function(diagnostic)
      return string.format("%s", diagnostic.message)
    end,
  },
  float = {
    source = "always",
    border = "rounded",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

