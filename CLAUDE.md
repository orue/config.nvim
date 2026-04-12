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
npm install -g emmet-ls

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

- Each server is registered with `vim.lsp.config('server_name', { ... })`
- A `filetype_to_lsp` table maps filetypes to server names
- A single `FileType` autocmd looks up the table and calls `vim.lsp.enable()` for matching servers
- All servers share capabilities from `blink.cmp.get_lsp_capabilities()`

To add a new LSP server: add a `vim.lsp.config()` block and an entry in the `filetype_to_lsp` table.

### Formatting

Conform.nvim (`lua/plugins/formatter.lua`) handles format-on-save for all languages except Lua, which uses LSP formatting directly. Do not add LSP format-on-save for non-Lua languages.

### Python virtual environment detection (lua/config/utils.lua)

`utils.lua` exports `get_python_path()`, `get_venv_info()`, and `has_venv()`. These walk up the directory tree looking for `.venv/`, `venv/`, or `env/` directories (also checks `$VIRTUAL_ENV`). Used by:
- `lsp.lua` -- Pyright settings (pythonPath, venvPath, venv)
- `debug.lua` -- debugpy adapter path
- `neotest.lua` -- pytest python path
- `lualine.lua` -- venv indicator in statusline

### Python LSP split

Pyright handles type checking and IntelliSense. Ruff handles linting and formatting. Ruff's hover is disabled to avoid duplication with Pyright.

### Ftplugin files (after/ftplugin/)

Set per-language local options (indent, textwidth, colorcolumn) and buffer-local keymaps (format, organize imports). These run before LSP attaches and do not conflict with plugin configs.

### Treesitter workaround

Neovim 0.12's built-in `$VIMRUNTIME/ftplugin/markdown.lua` calls `vim.treesitter.start()`, which triggers a `conceal_line` crash (nil node). The fix is in `after/ftplugin/markdown.lua`: it calls `vim.treesitter.stop()` synchronously after the built-in ftplugin runs. The nvim-treesitter plugin also disables its highlighter for markdown and falls back to regex highlighting.

## Conventions

- One plugin per file in `lua/plugins/`, or a small group of related plugins (e.g., `git.lua` has gitsigns + lazygit)
- Lazy-load plugins via `event`, `cmd`, `ft`, or `keys` whenever possible
- LSP keymaps are buffer-local, set on `LspAttach` (not global)
- Python packages (debugpy, pytest) are per-project in virtualenvs, never global
- Hardcoded paths should use `vim.fn.exepath()` with a fallback
