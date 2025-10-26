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
      -- Migrated to new vim.lsp.config API (Neovim 0.11+)
      local utils = require('config.utils')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Lua LSP
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
      })

      -- Go LSP
      vim.lsp.config('gopls', {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,  -- Use gofumpt formatting (stricter than gofmt)
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- Python LSP (Pyright)
      vim.lsp.config('pyright', {
        capabilities = capabilities,
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            pythonPath = utils.get_python_path(),
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      })

      -- Python LSP (Ruff)
      vim.lsp.config('ruff', {
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
      })

      -- Markdown LSP
      vim.lsp.config('marksman', {
        capabilities = capabilities,
      })

      -- Docker LSP
      vim.lsp.config('dockerls', {
        capabilities = capabilities,
      })

      -- Enable all configured LSP servers
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('gopls')
      vim.lsp.enable('pyright')
      vim.lsp.enable('ruff')
      vim.lsp.enable('marksman')
      vim.lsp.enable('dockerls')

      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>wd", function()
        vim.diagnostic.setloclist()
      end, { desc = "Workspace diagnostics" })

      -- Create augroup for LSP autocommands to prevent duplicates
      local lsp_group = vim.api.nvim_create_augroup('lsp-attach', { clear = true })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = lsp_group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- Create buffer-specific augroup to prevent duplicate format-on-save
          local bufgroup = vim.api.nvim_create_augroup('lsp-format-' .. args.buf, { clear = true })

          if vim.bo.filetype == "lua" then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = bufgroup,
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          elseif vim.bo.filetype == "python" and client.name == "ruff" then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = bufgroup,
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          elseif vim.bo.filetype == "go" and client.name == "gopls" then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = bufgroup,
              buffer = args.buf,
              callback = function()
                -- Organize imports first
                local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
                params.context = {only = {"source.organizeImports"}}
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
                for _, res in pairs(result or {}) do
                  for _, action in pairs(res.result or {}) do
                    if action.edit then
                      vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                    end
                  end
                end
                -- Then format
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
