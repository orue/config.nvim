return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function visual_range()
          return { vim.fn.line("."), vim.fn.line("v") }
        end

        vim.keymap.set("n", "]h", function() gs.nav_hunk("next") end, { buffer = bufnr, desc = "Next hunk" })
        vim.keymap.set("n", "[h", function() gs.nav_hunk("prev") end, { buffer = bufnr, desc = "Previous hunk" })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
        vim.keymap.set("x", "<leader>hs", function() gs.stage_hunk(visual_range()) end, { buffer = bufnr, desc = "Stage selected lines" })
        vim.keymap.set("x", "<leader>hr", function() gs.reset_hunk(visual_range()) end, { buffer = bufnr, desc = "Reset selected lines" })
        vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
      end,
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
