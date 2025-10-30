return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false -- Auto close on trailing </
    },
    -- Also applies to JSX/TSX and Vue
    per_filetype = {
      ["html"] = {
        enable_close = true
      },
      ["vue"] = {
        enable_close = true
      },
      ["javascriptreact"] = {
        enable_close = true
      },
      ["typescriptreact"] = {
        enable_close = true
      }
    }
  }
}
