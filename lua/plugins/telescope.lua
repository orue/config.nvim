return {
  'nvim-telescope/telescope.nvim',
  version = '*', -- latest release (was pinned to 0.1.8, which calls APIs deprecated in Nvim 0.12)
  cmd = 'Telescope',
  keys = {
    { "<leader>fd", function() require('telescope.builtin').find_files() end, desc = "Find files" },
    { "<leader>fb", function() require('telescope.builtin').buffers() end, desc = "Find buffers" },
    { "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = "Help tags" },
    { "<leader>fr", function() require('telescope.builtin').lsp_references() end, desc = "LSP references" },
    { "<leader>fs", function() require('telescope.builtin').lsp_document_symbols() end, desc = "Document symbols" },
    { "<leader>fo", function() require('telescope.builtin').oldfiles() end, desc = "Recent files" },
    { "<leader>en", function() require('telescope.builtin').find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Edit neovim config" },
    -- Multi-grep with custom picker
    { "<leader>fg", function() require("config.multigrep").live_multigrep() end, desc = "Multi grep" },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      defaults = {
        -- Performance optimizations
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "%.lock",
          "__pycache__/",
          "%.pyc",
          "%.egg-info/",
          "dist/",
          "build/",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
        -- UI improvements
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        sorting_strategy = "ascending",
        -- Performance settings
        cache_picker = {
          num_pickers = 25,
          limit_entries = 1000,
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!.git/*" }
          end,
        },
        buffers = {
          sort_mru = true,
          sort_lastused = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    }
    require('telescope').load_extension('fzf')
  end
}
