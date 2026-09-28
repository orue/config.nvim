-- Renders headings, lists, checkboxes, code blocks and tables inside markdown buffers
-- (the raw text shows on the cursor line and in Insert mode)
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {},
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle markdown rendering" },
  },
}
