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
          "vue",
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
          "gowork"
        },
        auto_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            -- Disable for markdown: treesitter conceal_line decorator hits a nil node
            -- in nvim 0.12, causing errors when conceallevel > 0
            if lang == "markdown" or lang == "markdown_inline" then
              return true
            end
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = { "markdown" },
        },
      }
    end,
  }
}
