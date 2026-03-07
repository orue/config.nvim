return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      themable = true,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "oil",
          text = " File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
      separator_style = "thin",
      show_buffer_close_icons = false,
      show_close_icon = false,
      indicator = {
        style = "underline",
      },
      modified_icon = "●",
      max_name_length = 25,
      tab_size = 22,
    },
  },
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
    { "<leader>bx", "<cmd>bd<cr>", desc = "Close buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    { "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
    { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
  },
}
