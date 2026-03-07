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
      local utils = require('config.utils')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Lua LSP
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
      })

      -- Python LSP (Pyright)
      local pyright_settings = {
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
      }

      -- Add venv info so Pyright resolves venv packages
      local venv_info = utils.get_venv_info()
      if venv_info then
        pyright_settings.python.venvPath = venv_info.venv_path
        pyright_settings.python.venv = venv_info.venv_name
      end

      vim.lsp.config('pyright', {
        capabilities = capabilities,
        settings = pyright_settings,
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

      -- Go LSP (gopls)
      vim.lsp.config('gopls', {
        cmd = { '/Users/orue/go/bin/gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.mod', 'go.sum', '.git' },
        capabilities = capabilities,
        settings = {
          gopls = {
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            semanticTokens = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
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

      -- Enable LSP servers on-demand via FileType autocommands
      local lsp_enable_group = vim.api.nvim_create_augroup('lsp-enable', { clear = true })

      local filetype_to_lsp = {
        lua = { 'lua_ls' },
        python = { 'pyright', 'ruff' },
        c = { 'clangd' },
        cpp = { 'clangd' },
        objc = { 'clangd' },
        objcpp = { 'clangd' },
        go = { 'gopls' },
        gomod = { 'gopls' },
        gowork = { 'gopls' },
        gotmpl = { 'gopls' },
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

      vim.api.nvim_create_autocmd('FileType', {
        group = lsp_enable_group,
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local servers = filetype_to_lsp[ft]
          if servers then
            for _, server in ipairs(servers) do
              vim.lsp.enable(server, { bufnr = args.buf })
            end
          end
        end,
      })

      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>wd", function()
        vim.diagnostic.setloclist()
      end, { desc = "Workspace diagnostics" })

      -- LSP attach: buffer-local keymaps + inlay hints
      local lsp_group = vim.api.nvim_create_augroup('lsp-attach', { clear = true })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = lsp_group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          local buf = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          -- Core LSP keymaps (moved from keymaps.lua to be buffer-local)
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gr", vim.lsp.buf.references, "Go to references")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

          -- VS Code-like additional keymaps
          map("n", "gD", vim.lsp.buf.type_definition, "Type definition")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gO", vim.lsp.buf.document_symbol, "Document symbols")
          map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
          map("n", "gp", function()
            vim.lsp.buf.definition({ on_list = function(options)
              if #options.items == 0 then return end
              local item = options.items[1]
              local buf_id = vim.fn.bufadd(item.filename)
              vim.fn.bufload(buf_id)
              local lines = vim.api.nvim_buf_get_lines(buf_id, math.max(0, item.lnum - 6), item.lnum + 14, false)
              vim.lsp.util.open_floating_preview(lines, 'lua', {
                border = 'rounded',
                title = vim.fn.fnamemodify(item.filename, ':t'),
                title_pos = 'center',
              })
            end })
          end, "Peek definition")

          -- Inlay hints
          if client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            map("n", "<leader>ih", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
            end, "Toggle inlay hints")
          end

          -- Format-on-save for Lua (conform.nvim handles Python and JS/TS/Vue)
          if vim.bo[buf].filetype == "lua" then
            local bufgroup = vim.api.nvim_create_augroup('lsp-format-' .. buf, { clear = true })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = bufgroup,
              buffer = buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
