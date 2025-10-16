return {
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "google",
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>nf", function() require("neogen").generate({ type = "func" }) end, desc = "Generate function docstring" },
      { "<leader>nc", function() require("neogen").generate({ type = "class" }) end, desc = "Generate class docstring" },
    },
  },
}
