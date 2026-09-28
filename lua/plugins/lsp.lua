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

      -- Server defaults (cmd, filetypes, root markers) come from nvim-lspconfig's lsp/*.lua.
      -- blink.cmp registers its completion capabilities for every server via vim.lsp.config('*').
      -- Only overrides live here.

      -- Python LSP (Pyright)
      vim.lsp.config('pyright', {
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
        -- Resolve the venv per project root (not once at startup from cwd)
        before_init = function(_, config)
          local root = config.root_dir
          local python = config.settings.python
          python.pythonPath = utils.get_python_path(root)
          local venv_info = utils.get_venv_info(root)
          if venv_info then
            python.venvPath = venv_info.venv_path
            python.venv = venv_info.venv_name
          end
        end,
      })

      -- Python LSP (Ruff)
      vim.lsp.config('ruff', {
        init_options = {
          settings = {
            -- Project ruff config wins; 120 is only the fallback (matches conform's ruff_format)
            configurationPreference = "filesystemFirst",
            lineLength = 120,
          },
        },
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- YAML LSP (GitHub Actions, Kubernetes, Docker Compose)
      vim.lsp.config('yamlls', {
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

      -- Go LSP (gopls)
      vim.lsp.config('gopls', {
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
      })

      -- TypeScript/JavaScript LSP (also serves TypeScript inside .vue files for vue_ls)
      local inlay_hints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }

      -- vue_ls 3.x needs @vue/typescript-plugin loaded into ts_ls; it ships inside the
      -- vue-language-server package, so resolve it from the installed binary.
      local function vue_ts_plugin_path()
        local bin = vim.fn.exepath('vue-language-server')
        if bin == '' then return nil end
        local real = vim.uv.fs_realpath(bin) -- .../@vue/language-server/bin/vue-language-server.js
        if not real then return nil end
        local path = vim.fn.fnamemodify(real, ':h:h') .. '/node_modules/@vue/typescript-plugin'
        return vim.uv.fs_stat(path) and path or nil
      end

      local ts_plugins = {}
      local vue_plugin = vue_ts_plugin_path()
      if vue_plugin then
        table.insert(ts_plugins, { name = '@vue/typescript-plugin', location = vue_plugin, languages = { 'vue' } })
      end

      vim.lsp.config('ts_ls', {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
          plugins = ts_plugins,
        },
        settings = {
          typescript = { inlayHints = inlay_hints },
          javascript = { inlayHints = inlay_hints },
        },
      })

      -- Vue LSP: without --tsdk, vue-language-server loads Homebrew's TypeScript 7 (native
      -- port, no tsserver API) and crashes. Point it at the project's own TypeScript instead.
      vim.lsp.config('vue_ls', {
        cmd = function(dispatchers, config)
          local cmd = { 'vue-language-server', '--stdio' }
          local tsdk = config.root_dir and vim.fs.joinpath(config.root_dir, 'node_modules/typescript/lib')
          if tsdk and vim.uv.fs_stat(tsdk) then
            table.insert(cmd, '--tsdk=' .. tsdk)
          end
          return vim.lsp.rpc.start(cmd, dispatchers, { cwd = config.cmd_cwd or config.root_dir })
        end,
      })

      -- CSS LSP
      local css_settings = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      }
      vim.lsp.config('cssls', {
        settings = {
          css = css_settings,
          scss = css_settings,
          less = css_settings,
        },
      })

      -- Emmet LSP (HTML/CSS abbreviations)
      vim.lsp.config('emmet_language_server', {
        filetypes = { 'html', 'css', 'scss', 'less', 'javascriptreact', 'typescriptreact', 'vue' },
      })

      -- Each server attaches to the filetypes in its config
      vim.lsp.enable({
        'lua_ls',
        'pyright',
        'ruff',
        'clangd',
        'gopls',
        'ts_ls',
        'vue_ls',
        'html',
        'cssls',
        'emmet_language_server',
        'dockerls',
        'bashls',
        'taplo',
        'yamlls',
        'terraformls',
      })

      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>wd", function()
        vim.diagnostic.setqflist()
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
          map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
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
              local ft = vim.filetype.match({ filename = item.filename, buf = buf_id }) or ''
              vim.lsp.util.open_floating_preview(lines, ft, {
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
        end,
      })
    end,
  }
}
