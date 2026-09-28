# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Neovim configuration targeting Neovim >= 0.12, managed by lazy.nvim, using Catppuccin Macchiato as the colorscheme. macOS-focused but mostly portable.

## Commands

```bash
# Install all dependencies (macOS; safe to re-run, lists any missing tools)
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

`init.lua` loads four files in order:
1. `lua/config/options.lua` -- editor settings, diagnostics config, filetype overrides (`.tf` → terraform)
2. `lua/config/keymaps.lua` -- global keybindings (leader = Space)
3. `lua/config/autocmds.lua` -- global autocommands (yank highlight, reload files changed on disk)
4. `lua/config/lazy.lua` -- bootstraps lazy.nvim, which auto-discovers all files in `lua/plugins/`

Other modules in `lua/config/` are helpers loaded on demand: `utils.lua` (Python venv), `lang.lua` (ftplugin helpers), `multigrep.lua` (Telescope picker), `new_project.lua` (dashboard action). Only plugin specs belong in `lua/plugins/` (lazy.nvim imports every module there).

## Architecture

### LSP (lua/plugins/lsp.lua)

Uses Neovim's native `vim.lsp.config()` and `vim.lsp.enable()` APIs (not the older lspconfig setup pattern). The key mechanism:

- nvim-lspconfig supplies each server's defaults (`cmd`, `filetypes`, root markers) via its `lsp/*.lua` files
- `vim.lsp.config('server_name', { ... })` in `lsp.lua` holds only overrides
- A single `vim.lsp.enable({ ... })` list turns servers on; each attaches to the filetypes in its config
- blink.cmp registers completion capabilities for every server itself (`vim.lsp.config('*')` in its plugin file), so don't pass `capabilities` per server

To add a new LSP server: add its name to the `vim.lsp.enable()` list, plus a `vim.lsp.config()` block only if it needs overrides.

JS/TS/React use `tsc`, TypeScript 7's native language server (`tsc --lsp`), not `ts_ls`: Homebrew's `typescript` formula is TypeScript 7, which no longer ships the tsserver API that ts_ls needs. lspconfig's `tsc` config prefers the project's `node_modules/.bin/tsc` when it is 7+, else the global one. `eslint` attaches only in projects with an ESLint config. Vue is intentionally unsupported (its tooling requires ts_ls/tsserver).

### Formatting

Conform.nvim (`lua/plugins/formatter.lua`) handles all format-on-save. Filetypes without a conform formatter (Lua, YAML, TOML, Terraform) fall back to LSP formatting via `lsp_format = "fallback"`. Do not add separate `BufWritePre` LSP-format autocmds (they would format twice).

Ruff line length: 120 is a fallback only. The ruff LSP uses `configurationPreference = "filesystemFirst"`, and conform's ruff formatters add `--config line-length=120` only when the project has no `ruff.toml`/`.ruff.toml`/`[tool.ruff]`.

### Python virtual environment detection (lua/config/utils.lua)

`utils.lua` exports `get_python_path(start_dir?)`, `get_venv_info(start_dir?)`, `venv_name(start_dir?)` (cached per directory, safe for the statusline), and `has_venv()`. These walk up from `start_dir` (default: cwd) looking for `.venv/`, `venv/`, or `env/` directories (`$VIRTUAL_ENV` wins if set). Used by:
- `lsp.lua` -- Pyright settings (pythonPath, venvPath, venv), resolved per project root in `before_init`
- `debug.lua` -- debugpy adapter path
- `neotest.lua` -- pytest python path (resolved per test root); Go tests use neotest-golang with gotestsum
- `lualine.lua` -- venv indicator in statusline (looked up from the buffer's directory, like Pyright)

### Python LSP split

Pyright handles type checking and IntelliSense. Ruff handles linting and formatting. Ruff's hover is disabled to avoid duplication with Pyright.

### Ftplugin files (after/ftplugin/)

Set per-language local options and buffer-local keymaps through `lua/config/lang.lua`: `setup_buffer({ indent, tabs?, width? })` sets indentation, textwidth and colorcolumn (and always removes `t` from `formatoptions`, so code is never auto-wrapped), and `map_code_action(lhs, kind, desc)` / `map_organize_imports()` map LSP code actions by kind. These run before LSP attaches and do not conflict with plugin configs.

### Treesitter (lua/plugins/treesitter.lua)

`nvim-treesitter` is pinned to its `main` branch (the `master` branch is archived and incompatible with Neovim 0.12's changed query/predicate API -- it crashes with `attempt to call method 'range' (a nil value)` while editing). The `main` branch only installs parsers/queries; highlighting is native Neovim (`vim.treesitter.start()`), wired up by a `FileType` autocmd in `treesitter.lua` that skips oversized files and markdown (handled separately below). The same autocmd turns on Treesitter folding (`foldexpr = vim.treesitter.foldexpr()`) for that window; `options.lua` sets `foldlevel = 99` so files open unfolded. `nvim-treesitter-textobjects` is also on its `main` branch (`lua/plugins/textobjects.lua`); its keymaps are defined in the lazy `keys` table, not by the plugin. Requires the `tree-sitter-cli` Homebrew formula to compile parsers (see Brewfile) -- the plain `tree-sitter` formula is just the runtime library and isn't enough.

Markdown: Neovim's built-in `$VIMRUNTIME/ftplugin/markdown.lua` starts the Treesitter highlighter itself, so the `FileType` autocmd in `treesitter.lua` skips markdown. (An earlier `conceal_line` crash, "attempt to call method 'range'", came from the archived `master` branch queries; a 300-edit stress test on Neovim 0.12.5 with the `main` branch no longer reproduces it, so the old `vim.treesitter.stop()` workaround was removed. If it returns, restore that call in `after/ftplugin/markdown.lua`.)

## Conventions

- One plugin per file in `lua/plugins/`, or a small group of related plugins (e.g., `git.lua` has gitsigns + lazygit)
- Lazy-load plugins via `event`, `cmd`, `ft`, or `keys` whenever possible. Only catppuccin, oil (directory buffers) and nvim-treesitter (main branch requirement) load at startup; a plugin spec with no trigger loads at startup too, so always give one
- Remote-plugin providers (python3, ruby, perl, node) are disabled in `options.lua`; the python3 one cost ~100ms on the first Python file
- Sessions (persistence.nvim) save on exit, never auto-restore; `sessionoptions` in `options.lua` deliberately omits `terminal` and `blank` so terminals (Claude Code, toggleterm) and floats aren't restored
- LSP keymaps are buffer-local, set on `LspAttach` (not global)
- Write mappings with `<leader>` (not a literal `<space>`) and use `x` (not `v`) for visual-mode mappings
- Catppuccin: flavour is Macchiato; `auto_integrations` covers installed plugins (only `noice` is listed explicitly); custom colors go in `custom_highlights` in `colorscheme.lua`, not in ftplugins
- Python packages (debugpy, pytest) are per-project in virtualenvs, never global
- Hardcoded paths should use `vim.fn.exepath()` with a fallback
- clangd, lldb-dap and make come from the Xcode Command Line Tools; don't add `llvm`/`make` to the Brewfile
- When adding a tool or keymap, update together: `Brewfile` + the `TOOLS` check in `install.sh` + README's dependency tables (tools); `MANUAL.md`, the complete key reference (keys). `KEYBINDINGS.md` is only the VS Code transition guide and links to MANUAL
