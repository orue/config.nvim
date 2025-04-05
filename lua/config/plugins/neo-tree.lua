return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },

  keys = {
   -- { "<leader>e", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
    { "<leader>e", ":Neotree toggle right<CR>", silent = true, desc = "Right File Explorer" },
    { "<leader><Tab>", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
  },
}
