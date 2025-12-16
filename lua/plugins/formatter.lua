return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      prettier = {
        command = "/opt/homebrew/bin/prettier",
      },
      goimports = {
        command = "/Users/orue/go/bin/goimports",
        args = { "-w", "$FILENAME" },
        stdin = false,
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
      -- C/C++
      c = { "clang-format" },
      cpp = { "clang-format" },
      -- Go
      go = { "goimports" },
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
