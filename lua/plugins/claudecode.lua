return {
  "coder/claudecode.nvim",
  dependencies = {},
  lazy = true,
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
    { "<leader>ac", "<cmd>ClaudeCode<cr>",              desc = "Toggle Claude Code" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",         desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",     desc = "Resume last session" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",   desc = "Continue conversation" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",   desc = "Select model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",         desc = "Add buffer to context" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",          desc = "Send selection to Claude", mode = "v" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",    desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",      desc = "Deny diff" },
    -- oil.nvim tree integration
    { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>",       desc = "Add file from tree", ft = "oil" },
  },
  opts = {
    -- Use the explicit path since claude is installed at ~/.local/bin/claude
    terminal_cmd = "/Users/orue/.local/bin/claude",
    -- Use native terminal (no snacks.nvim required)
    terminal = {
      provider = "native",
      split_side = "right",
      split_width_percentage = 0.35,
    },
    -- WebSocket server
    auto_start = true,
    log_level = "info",
    -- Send real-time selection context to Claude
    track_selection = true,
    -- Diff behavior
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true,
      open_in_current_tab = true,
    },
  },
  config = function(_, opts)
    require("claudecode").setup(opts)

    -- Register <leader>a group with which-key
    local ok, wk = pcall(require, "which-key")
    if ok then
      wk.add({ { "<leader>a", group = "AI/Claude Code" } })
    end

    -- Auto-reload buffers when Claude edits files externally
    vim.o.autoread = true
    local group = vim.api.nvim_create_augroup("ClaudeCodeAutoReload", { clear = true })
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
      group = group,
      pattern = "*",
      command = "silent! checktime",
    })
  end,
}
