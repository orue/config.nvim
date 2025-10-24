return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
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

    vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files, { desc = "Find files" })
    vim.keymap.set("n", "<space>fb", require('telescope.builtin').buffers, { desc = "Find buffers" })
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags, { desc = "Help tags" })
    vim.keymap.set("n", "<space>fr", require('telescope.builtin').lsp_references, { desc = "LSP references" })
    vim.keymap.set("n", "<space>fs", require('telescope.builtin').lsp_document_symbols, { desc = "Document symbols" })
    vim.keymap.set("n", "<space>fo", require('telescope.builtin').oldfiles, { desc = "Recent files" })
    vim.keymap.set("n", "<space>en", function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath("config")
      }
    end, { desc = "Edit neovim config" })
    require "plugins.telescope.multigrep".setup()
  end
}
