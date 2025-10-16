return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          theme = "ivy"
        }
      },
      extensions = {
        fzf = {}
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
