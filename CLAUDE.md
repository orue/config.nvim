# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Neovim configuration targeting Neovim >= 0.12, managed by lazy.nvim, using Catppuccin Mocha as the colorscheme. macOS-focused but mostly portable.

## Commands

```bash
# Install all dependencies (macOS)
./install.sh

# Install only brew dependencies
brew bundle

# Install npm-based LSP servers
npm install -g @olrtg/emmet-language-server

# Verify setup inside Neovim
:checkhealth
:LspInfo
:ConformInfo
:Lazy
```

## Boot sequence

`init.lua` loads three files in order:
1. `lua/config/options.lua` -- editor settings, diagnostics config
2. `lua/config/keymaps.lua` -- global keybindings (leader = Space)
3. `lua/config/lazy.lua` -- bootstraps lazy.nvim, which auto-discovers all files in `lua/plugins/`

## Architecture

### LSP (lua/plugins/lsp.lua)

Uses Neovim's native `vim.lsp.config()` and `vim.lsp.enable()` APIs (not the older lspconfig setup pattern). The key mechanism:

- nvim-lspconfig supplies each server's defaults (`cmd`, `filetypes`, root markers) via its `lsp/*.lua` files
- `vim.lsp.config('server_name', { ... })` in `lsp.lua` holds only overrides
- A single `vim.lsp.enable({ ... })` list turns servers on; each attaches to the filetypes in its config
- blink.cmp registers completion capabilities for every server itself (`vim.lsp.config('*')` in its plugin file), so don't pass `capabilities` per server

To add a new LSP server: add its name to the `vim.lsp.enable()` list, plus a `vim.lsp.config()` block only if it needs overrides.

Vue: vue_ls 3.x needs `@vue/typescript-plugin` loaded into `ts_ls` (resolved from the installed vue-language-server package) and is started with `--tsdk` pointing at the project's `node_modules/typescript/lib`. Homebrew's `typescript` formula is TypeScript 7 (native port, no tsserver API), which neither ts_ls nor vue_ls can use.

### Formatting

Conform.nvim (`lua/plugins/formatter.lua`) handles all format-on-save. Filetypes without a conform formatter (Lua, YAML, TOML, Terraform) fall back to LSP formatting via `lsp_format = "fallback"`. Do not add separate `BufWritePre` LSP-format autocmds (they would format twice).

Ruff line length: 120 is a fallback only. The ruff LSP uses `configurationPreference = "filesystemFirst"`, and conform's ruff formatters add `--config line-length=120` only when the project has no `ruff.toml`/`.ruff.toml`/`[tool.ruff]`.

### Python virtual environment detection (lua/config/utils.lua)

`utils.lua` exports `get_python_path(start_dir?)`, `get_venv_info(start_dir?)`, and `has_venv()`. These walk up from `start_dir` (default: cwd) looking for `.venv/`, `venv/`, or `env/` directories (`$VIRTUAL_ENV` wins if set). Used by:
- `lsp.lua` -- Pyright settings (pythonPath, venvPath, venv), resolved per project root in `before_init`
- `debug.lua` -- debugpy adapter path
- `neotest.lua` -- pytest python path (resolved per test root)
- `lualine.lua` -- venv indicator in statusline

### Python LSP split

Pyright handles type checking and IntelliSense. Ruff handles linting and formatting. Ruff's hover is disabled to avoid duplication with Pyright.

### Ftplugin files (after/ftplugin/)

Set per-language local options (indent, textwidth, colorcolumn) and buffer-local keymaps (format, organize imports). These run before LSP attaches and do not conflict with plugin configs.

### Treesitter (lua/plugins/treesitter.lua)

`nvim-treesitter` is pinned to its `main` branch (the `master` branch is archived and incompatible with Neovim 0.12's changed query/predicate API -- it crashes with `attempt to call method 'range' (a nil value)` while editing). The `main` branch only installs parsers/queries; highlighting is native Neovim (`vim.treesitter.start()`), wired up by a `FileType` autocmd in `treesitter.lua` that skips oversized files and markdown (handled separately below). Requires the `tree-sitter-cli` Homebrew formula to compile parsers (see Brewfile) -- the plain `tree-sitter` formula is just the runtime library and isn't enough.

Neovim 0.12's built-in `$VIMRUNTIME/ftplugin/markdown.lua` calls `vim.treesitter.start()`, which triggers a `conceal_line` crash (nil node). The fix is in `after/ftplugin/markdown.lua`: it calls `vim.treesitter.stop()` synchronously after the built-in ftplugin runs. The `FileType` autocmd in `treesitter.lua` also skips starting the highlighter for markdown, since the built-in ftplugin already handles (and then this stops) it.

## Conventions

- One plugin per file in `lua/plugins/`, or a small group of related plugins (e.g., `git.lua` has gitsigns + lazygit)
- Lazy-load plugins via `event`, `cmd`, `ft`, or `keys` whenever possible
- LSP keymaps are buffer-local, set on `LspAttach` (not global)
- Python packages (debugpy, pytest) are per-project in virtualenvs, never global
- Hardcoded paths should use `vim.fn.exepath()` with a fallback
