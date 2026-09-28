-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable unused remote-plugin providers. The Python one alone costs ~100ms the
-- first time a Python file opens (it spawns python3 to look for pynvim).
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Neovim maps *.tf to "tf" (TinyFugue); here .tf is always Terraform
vim.filetype.add({ extension = { tf = "terraform" } })

local opt = vim.opt

-- Line number
opt.number = true
opt.relativenumber = true

opt.shiftwidth = 2
opt.wrap = true
opt.breakindent = true -- wrapped lines keep their indentation

opt.undofile = true        -- undo history survives closing the file
opt.confirm = true         -- :q with unsaved changes asks to save instead of erroring
opt.inccommand = "split"   -- live preview of :s substitutions

-- Folding: Treesitter folds are enabled per buffer in lua/plugins/treesitter.lua;
-- everything starts unfolded, fold text keeps syntax colors
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldtext = ""
-- Deferred: clipboard provider detection shouldn't block startup
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

opt.cursorline = true
-- Explicit on purpose: auto-detection can fail (tmux, light terminals) and
-- would switch catppuccin away from Macchiato
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.title = true
opt.showmode = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Python-friendly settings
opt.updatetime = 250
opt.timeoutlen = 300

-- Colorcolumn
opt.colorcolumn = "120"

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 4,
  },
  float = {
    source = true,
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
  -- ]d / [d show the full message at the new position
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})

-- Render whitespace settings
opt.list = true
opt.listchars = {
  tab = '→ ',        -- Show tabs
  trail = '·',       -- Show trailing spaces
  nbsp = '␣',        -- Show non-breaking spaces
  extends = '⟩',     -- Show when line extends beyond screen
  precedes = '⟨',    -- Show when line precedes beyond screen
}
