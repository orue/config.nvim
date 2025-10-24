return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>d", group = "Debug/Diagnostics" },
      { "<leader>t", group = "Test" },
      { "<leader>r", group = "Refactor" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>c", group = "Code" },
      { "<leader>b", group = "Buffer" },
      { "<leader>w", group = "Workspace" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
