return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  dependencies = {
    -- Context-aware commentstring, e.g. {/* */} inside JSX/TSX instead of //
    { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
  },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
