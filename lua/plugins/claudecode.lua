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
    -- Explicit path: claude is installed at ~/.local/bin/claude
    terminal_cmd = "/Users/orue/.local/bin/claude",
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
  config = function(_, opts)
    require("claudecode").setup(opts)

    -- Auto-reload buffers when Claude edits files externally
    local group = vim.api.nvim_create_augroup("ClaudeCodeAutoReload", { clear = true })
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
      group = group,
      pattern = "*",
      command = "silent! checktime",
    })
  end,
}
