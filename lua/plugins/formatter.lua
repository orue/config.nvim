-- Use 120 columns for ruff unless the project has its own ruff config
-- (mirrors the ruff LSP's configurationPreference = "filesystemFirst" in lsp.lua)
local function ruff_line_length(_, ctx)
  local found = vim.fs.find({ "ruff.toml", ".ruff.toml", "pyproject.toml" }, { path = ctx.dirname, upward = true })
  for _, file in ipairs(found) do
    if not vim.endswith(file, "pyproject.toml") then
      return {}
    end
    -- pyproject.toml only counts as ruff config when it has a [tool.ruff] section
    for line in io.lines(file) do
      if line:match("^%[tool%.ruff") then
        return {}
      end
    end
  end
  return { "--config", "line-length=120" }
end

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      ruff_format = { prepend_args = ruff_line_length },
      ruff_organize_imports = { prepend_args = ruff_line_length },
    },
    formatters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
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
    -- Filetypes without a formatter above (Lua, YAML, TOML, Terraform) fall back to LSP formatting
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  keys = {
    {
      "<leader>rf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
}
