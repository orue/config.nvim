-- A navigable panel for diagnostics, TODOs and the quickfix list.
-- (No LSP modes: on Nvim 0.12 its lsp_references view comes up empty; use grr or <leader>fr)
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (this file)" },
    {
      "<leader>xt",
      function()
        require("todo-comments") -- registers Trouble's "todo" source
        vim.cmd("Trouble todo toggle")
      end,
      desc = "TODO comments",
    },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
  },
}
