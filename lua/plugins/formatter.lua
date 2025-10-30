return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
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
      -- YAML
      yaml = { "prettier" },
      yml = { "prettier" },
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
