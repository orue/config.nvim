return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-python",
      { "fredrikaverpil/neotest-golang", version = "*" }, -- needs the Go parser from nvim-treesitter's main branch
    },
    config = function()
      local utils = require('config.utils')

      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
            -- Resolved per test root, not once at startup from cwd
            python = function(root)
              return utils.get_python_path(root)
            end,
          }),
          require("neotest-golang")({
            -- gotestsum writes results to a file, avoiding garbled `go test -json` stdout
            runner = vim.fn.executable("gotestsum") == 1 and "gotestsum" or "go",
          }),
        },
      })
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
    },
  },
}
