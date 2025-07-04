return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
	ensure_installed = {
	  "json",
	  "javascript",
	  "typescript",
	  "tsx",
	  "yaml",
	  "html",
	  "css",
	  "prisma",
	  "markdown",
	  "markdown_inline",
	  "svelte",
	  "graphql",
	  "bash",
	  "lua",
	  "vim",
	  "dockerfile",
	  "gitignore",
	  "query",
	  "vimdoc",
	  "c",
	  "python",
	  "go"
	},
	auto_install = false,
	highlight = {
	  enable = true,
	  disable = function(lang, buf)
	    local max_filesize = 100 * 1024 -- 100 KB
	    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	    if ok and stats and stats.size > max_filesize then
	      return true
	    end
	  end,
	  additional_vim_regex_highlighting = false,
	},
      }
    end,
  }
}
