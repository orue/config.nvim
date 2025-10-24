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

      local utils = require('config.utils')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("lspconfig").lua_ls.setup { capabilities = capabilities }

      require("lspconfig").gopls.setup {
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
      }

      require("lspconfig").pyright.setup {
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

      require("lspconfig").marksman.setup {
        capabilities = capabilities,
      }

      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

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
                local params = vim.lsp.util.make_range_params()
                params.context = {only = {"source.organizeImports"}}
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
                for _, res in pairs(result or {}) do
                  for _, action in pairs(res.result or {}) do
                    if action.edit then
                      vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
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
