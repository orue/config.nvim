-- Tokyo Night Storm colorscheme configuration for Lazy.nvim

return {
  "folke/tokyonight.nvim",
  lazy = false,    -- Load during startup since it's the main colorscheme
  priority = 1000, -- Load before other plugins
  config = function()
    require("tokyonight").setup({
      style = "storm",     -- Available: storm, moon, night, day
      light_style = "day",
      transparent = false, -- Set to true for transparent background
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark", -- dark, transparent, normal
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "packer" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,

    })

    -- Apply the colorscheme
    vim.cmd([[colorscheme tokyonight-storm]])
  end,
}
