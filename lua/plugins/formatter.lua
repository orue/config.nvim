return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      prettier = {
        command = "/opt/homebrew/bin/prettier",
      },
      gofumpt = {
        command = vim.fn.expand("~/go/bin/gofumpt"),
      },
      goimports = {
        command = vim.fn.expand("~/go/bin/goimports"),
      },
    },
    formatters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      -- Vue.js
      vue = { "prettier" },
      -- HTML
      html = { "prettier" },
      -- CSS
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      -- JSON
      json = { "prettier" },
      jsonc = { "prettier" },
      -- GraphQL
      graphql = { "prettier" },
      gql = { "prettier" },
      -- Markdown
      markdown = { "prettier" },
      -- Python
      python = { "ruff_format", "ruff_organize_imports" },
      -- Go
      go = { "gofumpt", "goimports" },
      -- C/C++
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  keys = {
    {
      "<leader>rf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
}
