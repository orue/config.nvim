-- Sessions: saved automatically per directory (and git branch) when Neovim exits;
-- restored only when asked (dashboard `s`, or <leader>qs)
return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- start tracking once a real file is opened
  opts = {},
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore session (this directory)" },
    { "<leader>qS", function() require("persistence").select() end, desc = "Pick a session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save this session" },
  },
}
