-- Go formatting settings (follows Go community standards)
vim.opt_local.expandtab = false  -- Use tabs (Go standard)
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "120"
vim.opt_local.textwidth = 120

-- Go-specific keymaps
-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)

-- Organize imports (gopls code action)
vim.keymap.set("n", "<leader>ri", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind and action.kind:match("source.organizeImports")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Organize imports" })

-- Run current test file
vim.keymap.set("n", "<leader>rt", function()
  vim.cmd("!go test -v ./...")
end, { buffer = true, desc = "Run tests" })

-- Run verbose tests for current directory
vim.keymap.set("n", "<leader>rvt", function()
  vim.cmd("!go test -v -race ./...")
end, { buffer = true, desc = "Run tests (verbose, race)" })

-- Run test coverage for current directory
vim.keymap.set("n", "<leader>rc", function()
  vim.cmd("!go test -cover ./...")
end, { buffer = true, desc = "Run test coverage" })

-- Run all tests in workspace
vim.keymap.set("n", "<leader>re", function()
  vim.cmd("!go test -v ./...")
end, { buffer = true, desc = "Run all tests" })

-- Run benchmark
vim.keymap.set("n", "<leader>rab", function()
  vim.cmd("!go test -bench=. -benchmem ./...")
end, { buffer = true, desc = "Run benchmark" })

-- Add struct tags helper (gopls code action)
vim.keymap.set("n", "<leader>rats", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind and action.kind:match("source.addMissingTag")
    end,
    apply = true,
  })
end, { buffer = true, desc = "Add struct tags" })
