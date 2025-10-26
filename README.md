# Neovim Configuration

A modern, well-organized Neovim configuration focused on Python development with comprehensive LSP support, debugging, testing, and an enhanced UI/UX experience.

## Features

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loaded plugins
- **Colorscheme**: Catppuccin Frappe with transparent background
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
- A [Nerd Font](https://www.nerdfonts.com/) for icons (required for proper icon display)
- [Homebrew](https://brew.sh) (macOS only, for dependency installation)

For all other dependencies (LSP servers, formatters, tools), see the [Dependencies](#dependencies) section below.

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

4. **Install dependencies** (see Dependencies section below)

## Dependencies

This configuration requires several external tools for full functionality. On **macOS**, all dependencies can be easily installed using Homebrew.

### Quick Install (macOS)

The easiest way to install all dependencies is using the included `Brewfile`:

```bash
cd ~/.config/nvim
brew bundle
```

This will install all required tools automatically.

### What Gets Installed

#### Core Dependencies
- **node** - JavaScript runtime (needed for some LSP servers)
- **python3** - Python runtime

#### Language Servers
- **lua-language-server** - Lua LSP
- **gopls** - Go LSP
- **pyright** - Python type checking and IntelliSense
- **ruff** - Fast Python linter and formatter
- **marksman** - Markdown LSP
- **dockerfile-language-server** - Dockerfile LSP
- **bash-language-server** - Bash/shell script LSP
- **taplo** - TOML LSP
- **yaml-language-server** - YAML LSP
- **terraform-ls** - Terraform LSP

#### Debuggers
- **delve** - Go debugger (dlv)

#### Formatters & Linters
- **prettier** - Multi-language code formatter

#### Tools
- **ripgrep** - Fast search tool (required for Telescope)
- **lazygit** - Terminal UI for git commands
- **make** - Build automation tool

#### Python Packages (Per-Project)

The following Python packages should be installed **per-project** in a virtual environment, NOT globally:

```bash
# Create a virtual environment
python -m venv .venv

# Activate it
source .venv/bin/activate  # macOS/Linux

# Install packages
pip install debugpy pytest
```

**Required packages:**
- **debugpy** - Python debugger adapter for nvim-dap
- **pytest** - Testing framework for neotest-python

**Why virtual environments?**
- Avoids conflicts between project dependencies
- Keeps system Python clean
- Allows different versions per project
- Better isolation and reproducibility

### Verifying Installation

After installing dependencies, you can verify everything is working:

1. **Check Homebrew packages:**
   ```bash
   brew bundle check --verbose
   ```

2. **Check in Neovim:**
   ```vim
   :checkhealth
   :LspInfo
   :Mason
   ```

### Other Operating Systems

For Linux or other systems, you'll need to install the equivalent packages using your system's package manager. Refer to the `Brewfile` for the complete list of required tools.

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
│   │   ├── neotest.lua       # Testing (Python & Go)
│   │   └── ...               # Other plugins
│   └── alpha_custom.lua       # Custom dashboard functions
├── after/
│   └── ftplugin/             # Language-specific settings
│       ├── python.lua        # Python config
│       ├── go.lua            # Go config
│       └── lua.lua           # Lua config
├── Brewfile                   # macOS dependencies (Homebrew)
└── README.md
```

## Key Plugins

| Plugin | Purpose |
|--------|---------|
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | Colorscheme |
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
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",  -- latte, frappe, macchiato, mocha
      transparent_background = true,
    })
    vim.cmd.colorscheme("catppuccin-frappe")
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
1. Ensure all dependencies are installed (see [Dependencies](#dependencies) section)
2. Install Python packages in your project's virtual environment:
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install debugpy pytest
   ```
3. Restart Neovim after activating the virtual environment

### Missing Dependencies
1. Run `brew bundle check --verbose` to see what's missing
2. Install missing packages: `brew bundle`
3. Verify installation with `:checkhealth` in Neovim

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
- [folke](https://github.com/folke) for lazy.nvim, which-key, noice, and flash
- [Catppuccin](https://github.com/catppuccin) for the beautiful colorscheme
- [nvim-lua](https://github.com/nvim-lua) for the foundation of modern Neovim configs
- [nvim-treesitter](https://github.com/nvim-treesitter) for amazing syntax highlighting
- All plugin authors whose work made this configuration possible

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim Documentation](https://lazy.folke.io/)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim)
