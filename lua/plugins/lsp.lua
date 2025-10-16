return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- Suppress lspconfig deprecation warning
      local original_deprecate = vim.deprecate
      vim.deprecate = function(name, alternative, version, plugin, backtrace)
        if name and name:match("lspconfig") then
          return
        end
        return original_deprecate(name, alternative, version, plugin, backtrace)
      end
      
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      require("lspconfig").pyright.setup { 
        capabilities = capabilities,
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            pythonPath = ".venv/bin/python",
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      }
      require("lspconfig").ruff.setup { 
        capabilities = capabilities,
        init_options = {
          settings = {
            args = {
              "--line-length=120",
            },
          }
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
        end,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if vim.bo.filetype == "lua" then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          elseif vim.bo.filetype == "python" and client.name == "ruff" then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
