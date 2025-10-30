# Neovim Configuration Manual

Complete guide for using this Neovim configuration, including all keybindings, workflows, and tips.

## Table of Contents

- [Getting Started](#getting-started)
- [Leader Key](#leader-key)
- [Core Keybindings](#core-keybindings)
  - [General](#general)
  - [Buffer Management](#buffer-management)
  - [Window Navigation](#window-navigation)
  - [Text Editing](#text-editing)
- [LSP (Language Server Protocol)](#lsp-language-server-protocol)
- [File Navigation & Search](#file-navigation--search)
- [Git Integration](#git-integration)
- [Debugging](#debugging)
- [Testing](#testing)
- [Code Documentation](#code-documentation)
- [Language-Specific Keybindings](#language-specific-keybindings)
  - [Python](#python)
  - [Go](#go)
  - [JavaScript/TypeScript/Vue](#javascripttypescriptvue)
  - [HTML/CSS](#htmlcss)
  - [C/C++](#cc)
- [Plugin-Specific Features](#plugin-specific-features)
  - [Oil File Explorer](#oil-file-explorer)
  - [Flash Navigation](#flash-navigation)
  - [Multi-Grep Search](#multi-grep-search)
  - [LazyGit](#lazygit)
  - [Comment Plugin](#comment-plugin)
  - [Surround Plugin](#surround-plugin)
  - [Auto-pairs](#auto-pairs)
  - [Auto-tag (HTML/JSX/Vue)](#auto-tag-htmljsxvue)
- [Tips & Tricks](#tips--tricks)

---

## Getting Started

This configuration uses a modern, plugin-based approach with lazy-loading for optimal performance. Most plugins load automatically when needed, so you don't need to worry about managing them manually.

### First Steps

1. When you open Neovim without a file, you'll see the Alpha dashboard
2. Press the number key corresponding to the action you want to take
3. Press `q` to close the dashboard
4. Use `<Leader>a` to reopen the dashboard anytime

## Leader Key

The **leader key** is set to `<Space>` (spacebar). When you see `<Leader>` in a keybinding, it means press the spacebar first.

**Example:** `<Leader>ca` means: Press `Space`, then `c`, then `a`

---

## Core Keybindings

### General

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Space><Space>x` | Normal | Source current file | Execute/reload the current Lua file |
| `<Space>x` | Normal | Execute Lua line | Execute the current line as Lua code |
| `<Space>x` | Visual | Execute Lua selection | Execute the selected text as Lua code |
| `<Space>-` | Normal | Open file explorer | Open Oil file explorer in floating window |
| `<Leader>a` | Normal | Open dashboard | Display the Alpha dashboard |

### Buffer Management

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `[b` | Normal | Previous buffer | Switch to the previous buffer |
| `]b` | Normal | Next buffer | Switch to the next buffer |
| `<Leader>bd` | Normal | Delete buffer | Close the current buffer |

### Window Navigation

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<C-h>` | Normal | Left window | Move to the window on the left |
| `<C-j>` | Normal | Lower window | Move to the window below |
| `<C-k>` | Normal | Upper window | Move to the window above |
| `<C-l>` | Normal | Right window | Move to the window on the right |

### Text Editing

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<A-j>` | Normal | Move line down | Move current line down |
| `<A-k>` | Normal | Move line up | Move current line up |
| `<A-j>` | Visual | Move selection down | Move selected lines down |
| `<A-k>` | Visual | Move selection up | Move selected lines up |
| `<` | Visual | Indent left | Decrease indentation and keep selection |
| `>` | Visual | Indent right | Increase indentation and keep selection |
| `<Left>` | Visual | Indent left | Decrease indentation and keep selection |
| `<Right>` | Visual | Indent right | Increase indentation and keep selection |

**Note:** `<A-j>` means `Alt+j` on Linux/Windows or `Option+j` on macOS.

---

## LSP (Language Server Protocol)

LSP provides intelligent code completion, navigation, and refactoring. These keybindings work across all supported languages.

### Navigation

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `gd` | Normal | Go to definition | Jump to where a symbol is defined |
| `gr` | Normal | Go to references | Show all references to a symbol |
| `K` | Normal | Hover documentation | Show documentation for symbol under cursor |

### Code Actions

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>ca` | Normal | Code actions | Show available code actions (fixes, refactorings) |
| `<Leader>rn` | Normal | Rename symbol | Rename symbol under cursor project-wide |

### Diagnostics

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>d` | Normal | Line diagnostics | Show diagnostics for current line |
| `<Leader>wd` | Normal | Workspace diagnostics | Show all diagnostics in location list |
| `[d` | Normal | Previous diagnostic | Jump to previous diagnostic |
| `]d` | Normal | Next diagnostic | Jump to next diagnostic |

### Auto-formatting

Most file types are configured to auto-format on save. The LSP or formatter (conform.nvim/prettier) will automatically format your code when you save the file.

---

## File Navigation & Search

Powered by Telescope, a powerful fuzzy finder.

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Space>fd` | Normal | Find files | Search for files in current directory |
| `<Space>fb` | Normal | Find buffers | Search open buffers |
| `<Space>fg` | Normal | Multi-grep | Custom multi-grep with glob pattern support |
| `<Space>fr` | Normal | LSP references | Find references to symbol under cursor |
| `<Space>fs` | Normal | Document symbols | Browse symbols in current file |
| `<Space>fh` | Normal | Help tags | Search help documentation |
| `<Space>fo` | Normal | Recent files | Browse recently opened files |
| `<Space>en` | Normal | Edit Neovim config | Open Neovim config directory |

### Telescope Tips

When in Telescope:
- Type to filter results
- `<C-n>` / `<C-p>` or arrow keys to navigate
- `<CR>` (Enter) to open selection
- `<Esc>` to close
- `<C-q>` to send results to quickfix list

---

## Git Integration

Powered by Gitsigns for inline git operations.

### Hunk Navigation

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `]h` | Normal | Next hunk | Jump to next git change |
| `[h` | Normal | Previous hunk | Jump to previous git change |

### Hunk Operations

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>hp` | Normal | Preview hunk | Show diff of current hunk |
| `<Leader>hs` | Normal | Stage hunk | Stage current hunk |
| `<Leader>hr` | Normal | Reset hunk | Discard changes in current hunk |
| `<Leader>hb` | Normal | Blame line | Show git blame for current line |

### LazyGit

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>gg` | Normal | Open LazyGit | Launch LazyGit TUI for full git operations |

---

## Debugging

Powered by nvim-dap (Debug Adapter Protocol) with a visual debugging UI.

### Supported Languages
- Python (using debugpy)
- Go (using delve)
- C/C++ (using lldb)

### Debug Controls

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>db` | Normal | Toggle breakpoint | Set/remove breakpoint on current line |
| `<Leader>dc` | Normal | Continue | Start/continue debugging |
| `<Leader>ds` | Normal | Step over | Step over current line |
| `<Leader>di` | Normal | Step into | Step into function call |
| `<Leader>dt` | Normal | Terminate | Stop debugging session |

### Debug UI

The debug UI opens automatically when you start debugging and closes when the session ends. It shows:
- Variables and their values
- Call stack
- Breakpoints
- Console output

---

## Testing

Powered by Neotest for running and managing tests.

### Supported Languages
- Python (using pytest)
- Go (using go test)

### Test Commands

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>tt` | Normal | Run nearest test | Run the test closest to cursor |
| `<Leader>tf` | Normal | Run file tests | Run all tests in current file |
| `<Leader>ts` | Normal | Toggle test summary | Show/hide test results panel |

### Test Results

Tests run asynchronously and results appear inline:
- ✓ Green checkmark for passing tests
- ✗ Red X for failing tests
- Click on failed tests to see error details

---

## Code Documentation

Powered by Neogen for automatic docstring generation.

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>nf` | Normal | Generate function docstring | Create docstring for function under cursor |
| `<Leader>nc` | Normal | Generate class docstring | Create docstring for class under cursor |

**Note:** For Python, uses Google-style docstrings.

---

## Language-Specific Keybindings

Some keybindings are only available in specific file types.

### Python

This configuration includes comprehensive Python support with full LSP, testing, and debugging capabilities.

**File-specific settings:**
- 4-space indentation (PEP 8 compliant)
- 120-character line length indicator
- Auto-format on save (using Ruff)
- Auto-organize imports on save

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>rf` | Normal | Format file | Manually format Python file |
| `<Leader>ri` | Normal | Organize imports | Sort and organize import statements |

**Features:**

#### Virtual Environment Support
- Automatically detects and uses `.venv/bin/python` if available
- Falls back to system Python if no virtual environment exists
- Virtual environment indicator in statusline

#### LSP Configuration
- **Pyright**: Type checking and IntelliSense
- **Ruff**: Fast linting and formatting
- Auto-formatting on save
- Import organization

#### Testing
- **Neotest** with pytest adapter
- Run individual tests or entire files
- Visual test results and summary window
- Uses virtual environment Python if available

#### Debugging
- **nvim-dap** with Python debugpy adapter
- Full debugging UI with variable inspection
- Breakpoint management
- Uses virtual environment Python if available

### Go

Full Go language support with LSP, testing, and debugging capabilities.

**File-specific settings:**
- Tab indentation (Go standard)
- 120-character line length indicator
- Auto-format on save (using gofumpt)
- Automatic import organization on save

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>rf` | Normal | Format file | Manually format Go file |
| `<Leader>ri` | Normal | Organize imports | Sort and organize import statements |
| `<Leader>rj` | Normal | Add struct tags | Add JSON/YAML tags to struct fields |

**Features:**
- **gopls** LSP server with static analysis
- Inlay hints for types and parameters
- **Neotest** integration for Go tests
- **Delve** debugger (DAP) support
- Auto-formatting on save (gofumpt)
- Automatic import organization

### JavaScript/TypeScript/Vue

Full support for JavaScript, TypeScript, JSX, TSX, and Vue development.

**File-specific settings:**
- 2-space indentation (Node.js/web standard)
- 100-character line length indicator
- Auto-format on save (using Prettier)
- Auto-organize imports on save

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>rf` | Normal | Format file | Manually format with Prettier |
| `<Leader>ri` | Normal | Organize imports | Sort and organize import statements |

**Supported file types:**
- `.js` - JavaScript
- `.ts` - TypeScript
- `.jsx` - JavaScript with JSX (React)
- `.tsx` - TypeScript with JSX (React)
- `.vue` - Vue single-file components

**Features:**

#### TypeScript/JavaScript
- **ts_ls** (TypeScript Language Server): IntelliSense, type checking, refactoring
- Inlay hints for parameter names, types, and return values
- Auto-formatting on save
- Import organization

#### Vue.js
- **vue_ls** (Volar): Official Vue Language Server for templates, scripts, and styles
- **ts_ls**: TypeScript support in `<script>` sections
- Template autocomplete and IntelliSense
- Component props validation
- Full TypeScript/JavaScript support in `<script>` tags
- CSS/SCSS/Less support in `<style>` tags

### HTML/CSS

**File-specific settings:**
- 2-space indentation (web standard)
- 120-character line length indicator
- Auto-format on save (using Prettier)

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>rf` | Normal | Format file | Manually format with Prettier |

**Supported file types:**
- `.html` - HTML files
- `.css` - CSS files
- `.scss` - SCSS/Sass files
- `.less` - Less files

**Features:**
- HTML/CSS LSP with validation and autocomplete
- Auto-close HTML tags: Type `<div>` → `<div></div>`
- Auto-rename tags: Change `<div>` and closing tag updates automatically
- Emmet abbreviations: `div.container>ul>li*3` → full HTML structure
- CSS property autocomplete with browser compatibility info
- Emmet also works in JSX, TSX, and Vue files

**Emmet Examples:**
- `!` → HTML5 boilerplate
- `div.container` → `<div class="container"></div>`
- `ul>li*3` → `<ul><li></li><li></li><li></li></ul>`
- `a[href="#"]` → `<a href="#"></a>`

### C/C++

Comprehensive C/C++ support with LSP, debugging, and formatting capabilities.

**File-specific settings:**
- 4-space indentation
- 120-character line length indicator
- Auto-format on save (using clang-format)

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Leader>rf` | Normal | Format file | Manually format C/C++ file |
| `<Leader>rh` | Normal | Switch header/source | Toggle between .h and .c/.cpp files |

**Features:**
- **clangd** LSP server with clang-tidy integration
- **clang-format** for code formatting
- Header/source file switching (`<leader>rh`)
- Inlay hints for types and parameters
- **lldb** debugger support via nvim-dap

---

## Plugin-Specific Features

### Oil File Explorer

Oil treats directories like buffers - you can edit them with normal Vim commands.

**Opening Oil:**
- Press `<Space>-` for floating window
- Type `:Oil` for current directory

**Usage:**
- Navigate with `j`/`k` or arrow keys
- Press `<CR>` (Enter) to open file/directory
- Edit the buffer to rename, move, or delete:
  - Delete a line → delete that file (moves to trash)
  - Add a line → create new file
  - Edit a line → rename file
- Press `<CR>` on a pending change to execute it
- Press `-` to go up to parent directory

**Safety:** Deleted files go to trash, not permanently deleted.

### Flash Navigation

Flash allows you to jump to any visible location with just a few keystrokes.

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `s` | Normal/Visual/Operator | Flash jump | Jump to any word on screen |
| `S` | Normal/Visual/Operator | Treesitter jump | Jump using syntax-aware navigation |
| `r` | Operator | Remote flash | Use flash in operator-pending mode |
| `R` | Visual/Operator | Treesitter search | Search using treesitter |
| `<C-s>` | Command | Toggle flash | Toggle flash in command mode |

**How to use:**
1. Press `s` in normal mode
2. Type 1-2 characters of the word you want to jump to
3. Labels appear on matching locations
4. Type the label to jump

**Advanced:** Use in operator mode:
- `ds<label>` - Delete to flash target
- `ys<label>w"` - Surround to flash target with quotes

### Multi-Grep Search

A powerful custom search that combines text search with file pattern filtering.

**Usage:**
1. Press `<Leader>fg` (or `<Space>fg`)
2. Type your search pattern
3. Press `<Space><Space>` (double space)
4. Type a glob pattern (e.g., `*.py`, `src/**/*.lua`, `**/*.{js,ts}`)
5. Press `<Enter>` to search

**Examples:**
- Search "function" in Python files: `function  *.py`
- Search "TODO" in src directory: `TODO  src/**/*`
- Search "import" in JS/TS files: `import  **/*.{js,ts}`

### LazyGit

LazyGit is a full-featured terminal UI for git operations.

**Opening:** Press `<Leader>gg`

**Features:**
- Visual git status and diff
- Stage/unstage changes
- Commit with editor
- Push/pull operations
- Branch management
- Interactive rebase
- Stash management

**Navigation in LazyGit:**
- `j`/`k` or arrows to navigate
- `<Space>` to stage/unstage
- `c` to commit
- `P` to push
- `p` to pull
- `?` for help
- `q` to quit

### Comment Plugin

Toggle comments easily with standard Vim motions.

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `gcc` | Normal | Toggle line comment | Comment/uncomment current line |
| `gbc` | Normal | Toggle block comment | Comment/uncomment as block |
| `gc` + motion | Normal | Comment motion | Comment using motion (e.g., `gc3j`) |
| `gc` | Visual | Comment selection | Comment selected lines |

**Examples:**
- `gcc` - Toggle comment on current line
- `gc3j` - Comment next 3 lines
- `gcip` - Comment current paragraph
- `gc$` - Comment from cursor to end of line

### Surround Plugin

Add, change, or delete surrounding characters (quotes, brackets, tags, etc.).

**Default keybindings:**
- `ys{motion}{char}` - Add surround (e.g., `ysiw"` surrounds word with quotes)
- `ds{char}` - Delete surround (e.g., `ds"` removes quotes)
- `cs{old}{new}` - Change surround (e.g., `cs"'` changes " to ')

**Examples:**
- `ysiw"` - Surround word with double quotes
- `yss)` - Surround entire line with parentheses
- `ds"` - Remove surrounding double quotes
- `cs"'` - Change double quotes to single quotes
- `cst<div>` - Change surrounding tag to `<div>`
- Visual mode: Select text, press `S`, then type the character

### Auto-pairs

Automatically inserts matching pairs of brackets, quotes, etc.

**Features:**
- Auto-closes: `()`, `[]`, `{}`, `""`, `''`, ``` `` ```
- Smart deletion: Deleting opening character also deletes closing
- Fast wrap: Select text in visual mode, press `<M-e>`, then type opening character

**Note:** `<M-e>` means `Alt+e` on Linux/Windows or `Option+e` on macOS.

### Auto-tag (HTML/JSX/Vue)

Automatically closes and renames HTML tags using nvim-ts-autotag.

**Features:**
- Auto-close tags: Type `<div>` and it becomes `<div>|</div>` (cursor at `|`)
- Auto-rename tags: Change `<div>` to `<section>` and closing tag updates automatically
- Works in HTML, Vue, JSX, and TSX files
- Treesitter-powered for accurate tag detection

**Examples:**
- Type `<button>` → `<button></button>`
- Change `<div>` to `<span>` → closing `</div>` becomes `</span>`
- Type `<h1>Title` → `<h1>Title</h1>`

---

## Tips & Tricks

### Efficient Workflow

1. **Use Flash (`s`) instead of searching:** Much faster for jumping to visible text
2. **Use Telescope for everything:** File finding, grep, help docs, buffers
3. **Learn the motion operators:** `gcc`, `ys`, `ds`, `cs` with text objects
4. **Use Oil for file operations:** Safer and more intuitive than shell commands
5. **Leverage LazyGit:** Much easier than command-line git for complex operations

### Performance Tips

- Large files (>100KB) automatically disable some features
- Plugins are lazy-loaded, so startup is fast
- Use `:Lazy` to check plugin status
- Use `:checkhealth` to verify everything is working

### Customization

- **Add keybindings:** Edit `lua/config/keymaps.lua`
- **Add plugins:** Create file in `lua/plugins/`
- **Language settings:** Edit files in `after/ftplugin/`
- **LSP settings:** Edit `lua/plugins/lsp.lua`
- **Change colorscheme:** Edit `lua/plugins/colorscheme.lua`

### Learning Resources

- **Which-key plugin:** Press `<Space>` and wait - shows available keybindings
- **Help system:** Use `<Space>fh` to search help or `:help <topic>`
- **LSP info:** Use `:LspInfo` to see active language servers
- **Plugin manager:** Use `:Lazy` to manage plugins

### Troubleshooting

#### LSP Not Working

1. Check if the language server is installed
2. Run `:LspInfo` to see server status
3. Check `:Mason` for available servers
4. Verify the language server binary is in your PATH

#### Plugins Not Loading

1. Run `:Lazy` to see plugin status
2. Press `U` in Lazy window to update plugins
3. Press `S` to sync (install missing plugins)
4. Check for error messages in `:messages`

#### Python Features Not Working

1. Ensure all dependencies are installed (see Dependencies section in README)
2. Install Python packages in your project's virtual environment:
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install debugpy pytest
   ```
3. Restart Neovim after activating the virtual environment
4. Check `:LspInfo` to verify Pyright is running

#### Missing Dependencies

1. Run `brew bundle check --verbose` to see what's missing (macOS)
2. Install missing packages: `brew bundle`
3. Verify installation with `:checkhealth` in Neovim

#### Format on Save Not Working

1. Check LSP status with `:LspInfo`
2. Verify the formatter is installed (e.g., Prettier, Ruff)
3. Check formatter configuration in `lua/plugins/lsp.lua`
4. Look for error messages when saving with `:messages`

#### Troubleshooting Quick Reference

| Issue | Solution |
|-------|----------|
| LSP not working | `:LspInfo` to check status, verify language server installed |
| Plugin not loading | `:Lazy` to see status, try `U` to update |
| Key binding not working | Check with `:verbose map <key>` to see what it's mapped to |
| Slow startup | `:Lazy profile` to see plugin load times |
| Python features broken | Check virtual environment, install debugpy/pytest |
| Format on save not working | Check LSP status and formatter configuration |

### Common Workflows

**Starting a new Python project:**
1. Create virtual environment: `python -m venv .venv`
2. Activate: `source .venv/bin/activate`
3. Install packages: `pip install debugpy pytest`
4. Open Neovim: LSP will auto-detect the virtual environment

**Debugging a program:**
1. Set breakpoints with `<Leader>db`
2. Start debugging with `<Leader>dc`
3. Step through with `<Leader>ds` (over) or `<Leader>di` (into)
4. Inspect variables in the debug UI
5. Stop with `<Leader>dt`

**Running tests:**
1. Open a test file
2. Use `<Leader>tt` to run test under cursor
3. Use `<Leader>tf` to run all tests in file
4. Use `<Leader>ts` to see results summary
5. Click failed tests to see details

**Git workflow:**
1. Make changes in your editor
2. Gitsigns shows inline diff markers
3. Use `]h` / `[h` to navigate changes
4. Stage hunks with `<Leader>hs`
5. Open LazyGit with `<Leader>gg` to commit

**Refactoring code:**
1. Use `<Leader>rn` to rename a symbol
2. Use `<Leader>ca` for code actions (extract, inline, etc.)
3. Use `gr` to see all references before renaming
4. Use `gd` to jump to definition

---

## Keyboard Layout Reference

Here's a visual guide to the most important keybindings:

### Space (Leader) Mappings
```
<Space> <Space> x  →  Source file
<Space> x          →  Execute Lua
<Space> -          →  Oil explorer
<Space> f...       →  Telescope (find)
  ├─ fd  Files
  ├─ fb  Buffers
  ├─ fg  Multi-grep
  ├─ fr  References
  ├─ fs  Symbols
  ├─ fh  Help
  └─ fo  Recent files
<Space> en         →  Edit nvim config
```

### Leader Mappings
```
<Leader> a    →  Dashboard
<Leader> ca   →  Code actions
<Leader> rn   →  Rename
<Leader> d    →  Diagnostics
<Leader> wd   →  Workspace diagnostics
<Leader> bd   →  Delete buffer

Git:
<Leader> h...  →  Git hunks
  ├─ hp  Preview
  ├─ hs  Stage
  ├─ hr  Reset
  └─ hb  Blame
<Leader> gg    →  LazyGit

Debug:
<Leader> d...  →  Debugging
  ├─ db  Breakpoint
  ├─ dc  Continue
  ├─ ds  Step over
  ├─ di  Step into
  └─ dt  Terminate

Test:
<Leader> t...  →  Testing
  ├─ tt  Run test
  ├─ tf  Run file
  └─ ts  Summary

Docs:
<Leader> n...  →  Docstrings
  ├─ nf  Function
  └─ nc  Class

Format (language-specific):
<Leader> rf   →  Format file
<Leader> ri   →  Organize imports
<Leader> rh   →  Switch header/source (C/C++)
<Leader> rj   →  Add struct tags (Go)
```

### Navigation Mappings
```
gd             →  Definition
gr             →  References
K              →  Hover docs

[b / ]b        →  Buffer prev/next
[h / ]h        →  Git hunk prev/next
[d / ]d        →  Diagnostic prev/next

<C-h/j/k/l>    →  Window navigation
<A-j> / <A-k>  →  Move lines up/down
```

### Quick Actions
```
s / S          →  Flash jump
gcc            →  Toggle comment
ys / ds / cs   →  Surround
```

---

This manual covers all the essential keybindings and features. For more details on specific plugins or LSP configurations, refer to the plugin's documentation or use `:help <plugin-name>` in Neovim.
