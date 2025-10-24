-- Catppuccin Frappe colorscheme configuration for Lazy.nvim

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- Load during startup since it's the main colorscheme
  priority = 1000, -- Load before other plugins
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",    -- Available: latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "frappe",
      },
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        noice = true,
        native_lsp = {
          enabled = true,
        },
        lsp_trouble = true,
        which_key = true,
        telescope = {
          enabled = true,
        },
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme("catppuccin-frappe")
  end,
}
