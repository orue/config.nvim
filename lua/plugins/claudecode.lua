return {
  "coder/claudecode.nvim",
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeSelectModel",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude Code" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume last session" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue conversation" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add buffer to context" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "Send selection to Claude", mode = "v" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
    -- oil.nvim tree integration (<leader>at to avoid collision with <leader>as visual mode)
    { "<leader>at", "<cmd>ClaudeCodeTreeAdd<cr>",     desc = "Add file from tree", ft = "oil" },
  },
  opts = {
    terminal_cmd = vim.fn.exepath("claude") ~= "" and vim.fn.exepath("claude") or vim.fn.expand("~/.local/bin/claude"),
    terminal = {
      provider = "native",
      split_side = "left",
      split_width_percentage = 0.35,
    },
    auto_start = true,
    log_level = "info",
    track_selection = true,
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true,
      open_in_current_tab = true,
    },
  },
  -- Buffers edited by Claude are reloaded by the checktime autocmd in lua/config/autocmds.lua
}
