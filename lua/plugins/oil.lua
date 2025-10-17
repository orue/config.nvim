return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Oil will take over directory buffers (e.g. `nvim .`)
    default_file_explorer = true,
    keymaps = {
      ["<C-h>"] = false,
      ["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
      ["<M-h>"] = "actions.select_split",
      ["q"] = "actions.close",
    },
    -- Window-local options for oil buffers
    win_options = {
      relativenumber = false,
      number = false,

    },
    -- Send deleted files to trash (set to true if you want this behavior)
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
    -- Floating window configuration for :Oil --float
    float = {
      padding = 4,
      max_width = 0.3,  -- 30% of the screen width
      max_height = 0.4, -- 40% of the screen height
      get_win_title = nil,
      win_options = {
        number = false,
        relativenumber = false,
      },
    },
  },
}
