return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ensure_installed = {
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
        "toml",
        "hcl",
        "terraform",
        "go",
        "gomod",
        "gowork",
      }

      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(ensure_installed)

      local max_filesize = 100 * 1024 -- 100 KB

      -- The `master` branch's highlight module (and its custom query
      -- predicates) is incompatible with Neovim 0.12's changed treesitter
      -- API and crashes with "attempt to call method 'range' (a nil value)"
      -- while editing. Enable highlighting directly via Neovim's native
      -- vim.treesitter.start(), which the `main` branch queries support.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local bufnr = args.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
          if not lang or lang == "markdown" then
            -- Markdown highlighting is handled in after/ftplugin/markdown.lua
            return
          end

          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          if ok and stats and stats.size > max_filesize then
            return
          end

          pcall(vim.treesitter.start, bufnr, lang)
        end,
      })
    end,
  },
}
