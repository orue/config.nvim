-- Side-by-side diffs of every changed file, and git history per file or repo
local close = { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } }

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  opts = {
    keymaps = {
      view = { close },
      file_panel = { close },
      file_history_panel = { close },
    },
  },
  keys = {
    {
      "<leader>gd",
      function()
        if require("diffview.lib").get_current_view() then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end,
      desc = "Diff view (all changes)",
    },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
  },
}
