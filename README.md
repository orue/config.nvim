# Neovim Configuration

A modern, well-organized Neovim configuration focused on Python development with comprehensive LSP support, debugging, testing, and an enhanced UI/UX experience.

## Features

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loaded plugins
- **Colorscheme**: Tokyo Night Storm with custom diagnostic colors
- **LSP**: Fully configured Language Server Protocol for Lua and Python
- **Completion**: Modern completion engine with [blink.cmp](https://github.com/Saghen/blink.cmp)
- **File Navigation**: Oil.nvim for intuitive file browsing, Telescope for fuzzy finding
- **Git Integration**: Gitsigns for inline diff markers and git operations
- **Debugging**: Full DAP setup with UI for Python debugging
- **Testing**: Integrated pytest runner with Neotest
- **Enhanced UI**: Noice.nvim for prettier messages and LSP documentation

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope live grep
- [fd](https://github.com/sharkdp/fd) (optional, for faster file finding)
- [Node.js](https://nodejs.org/) (for some LSP servers)
- Python 3.8+ (for Python development features)

## Installation

1. **Backup your existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

   Lazy.nvim will automatically install all plugins on first launch.

4. **Install language servers** (optional, for LSP):
   - Lua: Included with `lua_ls`
   - Python: `pip install pyright ruff`

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Plugin manager setup
│   │   ├── options.lua        # Editor options
│   │   ├── keymaps.lua        # Global keybindings
│   │   └── utils.lua          # Utility functions
│   ├── plugins/               # Plugin configurations
│   │   ├── lsp.lua           # LSP setup
│   │   ├── completion.lua    # Completion engine
│   │   ├── telescope.lua     # Fuzzy finder
│   │   ├── treesitter.lua    # Syntax highlighting
│   │   ├── debug.lua         # DAP debugging
│   │   ├── python.lua        # Python testing
│   │   └── ...               # Other plugins
│   └── alpha_custom.lua       # Custom dashboard functions
├── after/
│   └── ftplugin/             # Language-specific settings
│       ├── python.lua        # Python config
│       └── lua.lua           # Lua config
└── README.md
```

## Key Plugins

| Plugin | Purpose |
|--------|---------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Completion engine |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard |
| [flash.nvim](https://github.com/folke/flash.nvim) | Fast navigation |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debugging |
| [neotest](https://github.com/nvim-neotest/neotest) | Test runner |
| [noice.nvim](https://github.com/folke/noice.nvim) | Enhanced UI |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding help |

See the full plugin list in the [lua/plugins/](lua/plugins/) directory.

## Keybindings

### Leader Key
The leader key is `<Space>`.

### General

| Key | Action | Mode |
|-----|--------|------|
| `<Space><Space>x` | Source current file | Normal |
| `<Space>x` | Execute Lua line | Normal/Visual |
| `<Space>-` | Open file explorer (float) | Normal |
| `<Leader>h` | Open dashboard | Normal |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<Leader>ca` | Code actions |
| `<Leader>rn` | Rename symbol |
| `<Leader>d` | Line diagnostics |
| `[d` / `]d` | Previous/next diagnostic |

### File Navigation & Search

| Key | Action |
|-----|--------|
| `<Space>fd` | Find files |
| `<Space>fb` | Find buffers |
| `<Space>fg` | Multi-grep (custom) |
| `<Space>fr` | LSP references |
| `<Space>fs` | Document symbols |
| `<Space>fh` | Help tags |
| `<Space>fo` | Recent files |
| `<Space>en` | Edit Neovim config |

### Buffer & Window Navigation

| Key | Action |
|-----|--------|
| `[b` / `]b` | Previous/next buffer |
| `<Leader>bd` | Delete buffer |
| `<C-h/j/k/l>` | Navigate between windows |

### Git Operations

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next/previous hunk |
| `<Leader>hp` | Preview hunk |
| `<Leader>hs` | Stage hunk |
| `<Leader>hr` | Reset hunk |
| `<Leader>hb` | Blame line |

### Debugging (Python)

| Key | Action |
|-----|--------|
| `<Leader>db` | Toggle breakpoint |
| `<Leader>dc` | Continue execution |
| `<Leader>ds` | Step over |
| `<Leader>di` | Step into |
| `<Leader>dt` | Terminate debug |

### Testing (Python)

| Key | Action |
|-----|--------|
| `<Leader>tt` | Run nearest test |
| `<Leader>tf` | Run file tests |
| `<Leader>ts` | Toggle test summary |

### Text Editing

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `ys` / `ds` / `cs` | Surround/delete/change |
| `<M-e>` | Fast wrap (autopairs) |
| `s` / `S` | Flash jump/treesitter jump |
| `<A-j>` / `<A-k>` | Move line down/up |
| `<` / `>` | Better indent (visual mode) |

### Docstring Generation

| Key | Action |
|-----|--------|
| `<Leader>nf` | Generate function docstring |
| `<Leader>nc` | Generate class docstring |

## Python Development

This configuration is optimized for Python development with the following features:

### Virtual Environment Support
- Automatically detects and uses `.venv/bin/python` if available
- Falls back to system Python if no virtual environment exists
- Virtual environment indicator in statusline

### LSP Configuration
- **Pyright**: Type checking and IntelliSense
- **Ruff**: Fast linting and formatting
- Auto-formatting on save
- Import organization

### Testing
- **Neotest** with pytest adapter
- Run individual tests or entire files
- Visual test results and summary window
- Uses virtual environment Python if available

### Debugging
- **nvim-dap** with Python debugpy adapter
- Full debugging UI with variable inspection
- Breakpoint management
- Uses virtual environment Python if available

### File-Specific Settings
- 4-space indentation (PEP 8 compliant)
- 120-character line length indicator
- Auto-formatting keybindings

## Customization

### Changing the Colorscheme
Edit `lua/plugins/colorscheme.lua`:
```lua
return {
  "folke/tokyonight.nvim",
  config = function()
    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
```

### Adding New Plugins
Create a new file in `lua/plugins/` or add to an existing one:
```lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- Lazy load the plugin
  config = function()
    -- Plugin configuration
  end,
}
```

### Modifying Keybindings
Edit `lua/config/keymaps.lua` or the specific plugin configuration file.

### Language-Specific Settings
Add or modify files in `after/ftplugin/` named `{language}.lua`.

## Tips & Tricks

### Multi-Grep Search
Use `<Space>fg` for the custom multi-grep picker:
1. Type your search pattern
2. Press `<Space><Space>` (double space)
3. Type a glob pattern (e.g., `*.py`, `src/**/*.lua`)
4. Press `<Enter>` to search

### Oil File Explorer
- Press `<Space>-` to open Oil in float mode
- Edit files like a buffer (delete lines to delete files, add lines to create)
- Press `<CR>` to save changes
- Deleted files go to trash (not permanently deleted)
- Use `:Oil` to open in current directory

### Dashboard Actions
When opening Neovim without a file:
- Press the number key to select an action
- Recent projects are loaded from your file history
- Press `q` to dismiss the dashboard

### Flash Navigation
- Press `s` followed by characters to jump to any word on screen
- Press `S` for treesitter-aware jumping
- Works in operator-pending mode (e.g., `ds` to delete to flash target)

## Troubleshooting

### LSP Not Working
1. Check if the language server is installed
2. Run `:LspInfo` to see server status
3. Check `:Mason` for available servers

### Plugins Not Loading
1. Run `:Lazy` to see plugin status
2. Press `U` in Lazy window to update plugins
3. Press `S` to sync (install missing plugins)

### Python Features Not Working
1. Ensure you have Python 3.8+ installed
2. Install required packages: `pip install pyright ruff debugpy pytest`
3. Create a virtual environment: `python -m venv .venv`

### Telescope Errors
1. Ensure `ripgrep` is installed: `brew install ripgrep` (macOS) or your package manager
2. Install `fd` for better performance: `brew install fd`

## Performance

This configuration is optimized for performance:
- Lazy-loading for most plugins (load only when needed)
- Treesitter disabled for files larger than 100KB
- Async formatting to avoid blocking
- Fast startup time (~50ms on modern hardware)

## Contributing

Feel free to fork this configuration and customize it for your needs. If you find bugs or have suggestions, please open an issue or submit a pull request.

## License

MIT License - Feel free to use and modify this configuration.

## Acknowledgments

This configuration was built using excellent plugins from the Neovim community. Special thanks to:
- [folke](https://github.com/folke) for lazy.nvim, which-key, noice, flash, and tokyonight
- [nvim-lua](https://github.com/nvim-lua) for the foundation of modern Neovim configs
- [nvim-treesitter](https://github.com/nvim-treesitter) for amazing syntax highlighting
- All plugin authors whose work made this configuration possible

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim Documentation](https://lazy.folke.io/)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim)
