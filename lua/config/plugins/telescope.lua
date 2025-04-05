return {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    version = false,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "kkharji/sqlite.lua",
      -- "nvim-telescope/telescope-frecency.nvim",
    },
    keys = {
      { "<leader>f",":Telescope find_files<CR>", silent = true , desc = "Find Files" },
    }
}
