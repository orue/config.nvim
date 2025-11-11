-- Rose Pine Moon colorscheme configuration for Lazy.nvim

return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,    -- Load during startup since it's the main colorscheme
  priority = 1000, -- Load before other plugins
  config = function()
    require("rose-pine").setup({
      variant = "moon", -- Available: auto, main, moon, dawn
      dark_variant = "moon",
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      highlight_groups = {
        -- Disable italic for imported module/library names in Python
        ["@variable.member.python"] = { fg = "foam", italic = false },
        ["@module.python"] = { fg = "foam", italic = false },
        -- Thin transparent colorcolumn
        ColorColumn = { bg = "surface" },
      },
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme("rose-pine-moon")
  end,
}
