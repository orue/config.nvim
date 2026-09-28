-- Global autocommands (plugin-specific ones stay with their plugin spec)
local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight when yanking (copying) text. Try it with `yap` in normal mode
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("highlight-yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Reload buffers changed outside Neovim (e.g. by Claude Code, git, formatters)
autocmd({ "FocusGained", "BufEnter" }, {
  desc = "Reload files changed on disk",
  group = augroup("auto-reload"),
  command = "silent! checktime",
})
