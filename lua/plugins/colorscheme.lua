return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Ensure it loads before other plugins
    lazy = false,    -- Load immediately, not lazily
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",            -- Set the flavour here: latte, frappe, macchiato, mocha
        transparent_background = true, -- Set to true if you want transparency
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = true,
          -- Add more integrations as needed
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
