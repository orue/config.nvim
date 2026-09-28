return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = { { [[<C-\>]], desc = "Toggle terminal" } },
  opts = {
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = {
      border = "curved",
    },
    shade_terminals = true,
    -- Esc Esc leaves terminal mode (scroll, copy with Normal-mode keys). Buffer-local on purpose:
    -- a global mapping would also catch the Claude Code panel, which uses Esc Esc itself
    on_create = function(term)
      vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = term.bufnr, desc = "Leave terminal mode" })
    end,
  },
}
