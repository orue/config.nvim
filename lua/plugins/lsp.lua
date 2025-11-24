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

      -- Docker LSP
      vim.lsp.config('dockerls', {
        capabilities = capabilities,
      })

      -- Bash LSP
      vim.lsp.config('bashls', {
        capabilities = capabilities,
      })

      -- TOML LSP
      vim.lsp.config('taplo', {
        capabilities = capabilities,
        cmd = { '/opt/homebrew/bin/taplo', 'lsp', 'stdio' },
      })

      -- YAML LSP (GitHub Actions, Kubernetes, Docker Compose)
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/github-action.json"] = "/.github/action.{yml,yaml}",
              kubernetes = "/*.k8s.yaml",
            },
            format = {
              enable = true,
            },
            validate = true,
            hover = true,
            completion = true,
          },
        },
      })

      -- Terraform LSP
      vim.lsp.config('terraformls', {
        capabilities = capabilities,
      })

      -- C/C++ LSP (clangd)
      vim.lsp.config('clangd', {
        capabilities = capabilities,
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        settings = {
          clangd = {
            InlayHints = {
              Designators = true,
              Enabled = true,
              ParameterNames = true,
              DeducedTypes = true,
            },
          },
        },
      })

      -- TypeScript/JavaScript LSP (also handles Vue <script> sections)
      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- Vue.js LSP (vue_ls)
      vim.lsp.config('vue_ls', {
        capabilities = capabilities,
        filetypes = { 'vue' },
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      })

      -- HTML LSP
      vim.lsp.config('html', {
        capabilities = capabilities,
        filetypes = { 'html' },
      })

      -- CSS LSP
      vim.lsp.config('cssls', {
        capabilities = capabilities,
        filetypes = { 'css', 'scss', 'less' },
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      })

      -- Emmet LSP (HTML/CSS abbreviations)
      vim.lsp.config('emmet_ls', {
        capabilities = capabilities,
        filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescriptreact', 'vue' },
      })

      -- Enable LSP servers on-demand via FileType autocommands for performance
      -- This prevents all 16 servers from starting at once, while still enabling them when needed
      local lsp_enable_group = vim.api.nvim_create_augroup('lsp-enable', { clear = true })

      -- Map filetypes to LSP servers
      local filetype_to_lsp = {
        lua = { 'lua_ls' },
        python = { 'pyright', 'ruff' },
        c = { 'clangd' },
        cpp = { 'clangd' },
        objc = { 'clangd' },
        objcpp = { 'clangd' },
        typescript = { 'ts_ls' },
        javascript = { 'ts_ls' },
        javascriptreact = { 'ts_ls', 'emmet_ls' },
        typescriptreact = { 'ts_ls', 'emmet_ls' },
        vue = { 'ts_ls', 'vue_ls', 'emmet_ls' },
        html = { 'html', 'emmet_ls' },
        css = { 'cssls', 'emmet_ls' },
        scss = { 'cssls', 'emmet_ls' },
        less = { 'cssls', 'emmet_ls' },
        dockerfile = { 'dockerls' },
        sh = { 'bashls' },
        bash = { 'bashls' },
        zsh = { 'bashls' },
        toml = { 'taplo' },
        yaml = { 'yamlls' },
        terraform = { 'terraformls' },
        tf = { 'terraformls' },
      }

      -- Track which servers have been enabled to avoid duplicate enables
      local enabled_servers = {}

      vim.api.nvim_create_autocmd('FileType', {
        group = lsp_enable_group,
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local servers = filetype_to_lsp[ft]

          if servers then
            for _, server in ipairs(servers) do
              if not enabled_servers[server] then
                vim.lsp.enable(server)
                enabled_servers[server] = true
              end
            end
          end
        end,
      })

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
          end
          -- Note: JavaScript/TypeScript/Vue formatting is handled by conform.nvim (formatter.lua)
        end,
      })
    end,
  }
}
