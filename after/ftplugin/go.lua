-- Go: tab indent (width 4), 120-char ruler
local lang = require("config.lang")
lang.setup_buffer({ indent = 4, tabs = true, width = 120 })

-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)

lang.map_organize_imports()
lang.map_code_action("<leader>rats", "refactor.rewrite.addTags", "Add struct tags")

-- Run `go test <args>` in the current file's package directory
local function go_test_package(args)
  local dir = vim.fn.shellescape(vim.fn.expand("%:p:h"))
  vim.cmd("!cd " .. dir .. " && go test " .. args .. " .")
end

vim.keymap.set("n", "<leader>rt", function()
  go_test_package("-v")
end, { buffer = true, desc = "Run tests (current package)" })

vim.keymap.set("n", "<leader>rc", function()
  go_test_package("-cover")
end, { buffer = true, desc = "Run test coverage (current package)" })

vim.keymap.set("n", "<leader>re", function()
  vim.cmd("!go test -v ./...")
end, { buffer = true, desc = "Run all tests" })

vim.keymap.set("n", "<leader>rvt", function()
  vim.cmd("!go test -v -race ./...")
end, { buffer = true, desc = "Run all tests (race)" })

vim.keymap.set("n", "<leader>rab", function()
  vim.cmd("!go test -bench=. -benchmem ./...")
end, { buffer = true, desc = "Run benchmarks" })
