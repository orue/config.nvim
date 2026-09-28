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
        "jsdoc",
        "regex",
        "tsx",
        "yaml",
        "html",
        "css",
        "scss",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "lua",
        "luadoc",
        "vim",
        "dockerfile",
        "gitignore",
        "gitcommit",
        "diff",
        "query",
        "vimdoc",
        "c",
        "cpp",
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
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
          if not lang or lang == "markdown" then
            -- Neovim's built-in markdown ftplugin already starts the highlighter
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
