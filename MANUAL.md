# Manual

Leader key is `Space`. Press `Space` and wait to see available keybindings via which-key.

## Core

| Key | Action |
|-----|--------|
| `Space Space x` | Source current file |
| `Space x` | Execute current line as Lua (visual: selection) |
| `Space -` | File explorer (Oil) |
| `Space a` | Dashboard |

## Buffers

| Key | Action |
|-----|--------|
| `[b` / `]b` | Previous / next buffer |
| `Space bd` | Close buffer |

## Windows

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Move between windows |

## Text editing

| Key | Mode | Action |
|-----|------|--------|
| `Alt+j` / `Alt+k` | Normal, Visual | Move line(s) down / up |
| `<` / `>` | Visual | Indent left / right (keeps selection) |

## Find and search (Telescope)

| Key | Action |
|-----|--------|
| `Space fd` | Find files |
| `Space fb` | Find buffers |
| `Space fg` | Multi-grep (see below) |
| `Space fr` | LSP references |
| `Space fs` | Document symbols |
| `Space fh` | Help tags |
| `Space fo` | Recent files |
| `Space en` | Browse Neovim config |

Inside Telescope: type to filter, `Ctrl+n`/`Ctrl+p` to navigate, `Enter` to open, `Esc` to close, `Ctrl+q` to send to quickfix.

### Multi-grep

`Space fg` opens a grep prompt. Type your search, then `Space Space` (double space), then a file glob.

Examples:
- `function  *.py` -- search "function" in Python files
- `TODO  src/**/*` -- search "TODO" under src/
- `import  **/*.{js,ts}` -- search "import" in JS/TS files

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gD` | Type definition |
| `gi` | Implementation |
| `gO` | Document symbols |
| `gp` | Peek definition (floating) |
| `K` | Hover docs |
| `Space ca` | Code actions |
| `Space rn` | Rename symbol |
| `Space ws` | Workspace symbols |
| `Space ih` | Toggle inlay hints |

### Diagnostics

| Key | Action |
|-----|--------|
| `Space d` | Line diagnostics |
| `[d` / `]d` | Previous / next diagnostic |
| `Space wd` | Workspace diagnostics list |

### Format on save

Enabled for all supported languages. Formatters: Ruff (Python), Prettier (JS/TS/Vue/HTML/CSS), clang-format (C/C++), goimports (Go), lua_ls (Lua).

## Git

| Key | Action |
|-----|--------|
| `Space gg` | Open LazyGit |
| `]h` / `[h` | Next / previous hunk |
| `Space hp` | Preview hunk |
| `Space hs` | Stage hunk |
| `Space hr` | Reset hunk |
| `Space hb` | Blame line |

## Debugging (DAP)

Supported: Python (debugpy), C/C++ (lldb), Go (delve).

| Key | Action |
|-----|--------|
| `Space db` | Toggle breakpoint |
| `Space dc` | Start / continue |
| `Space ds` | Step over |
| `Space di` | Step into |
| `Space dt` | Terminate |

The debug UI opens automatically when a session starts and closes when it ends. It shows variables, call stack, breakpoints, and console output.

## Testing (Neotest)

Supported: Python (pytest).

| Key | Action |
|-----|--------|
| `Space tt` | Run nearest test |
| `Space tf` | Run all tests in file |
| `Space ts` | Toggle test summary |

## Docstrings (Neogen)

| Key | Action |
|-----|--------|
| `Space nf` | Generate function docstring |
| `Space nc` | Generate class docstring |

Python uses Google-style docstrings.

## Language-specific keys

### Python

Settings: 4-space indent, 120-char ruler, format on save (Ruff).

| Key | Action |
|-----|--------|
| `Space rf` | Format file |
| `Space ri` | Organize imports |

Virtual environments are detected automatically. The statusline shows the active venv.

### JavaScript / TypeScript / Vue

Settings: 2-space indent, 100-char ruler, format on save (Prettier).

| Key | Action |
|-----|--------|
| `Space rf` | Format file |
| `Space ri` | Organize imports |

Vue files get ts_ls (script sections), vue_ls (templates), and emmet_ls (abbreviations).

### HTML / CSS

Settings: 2-space indent, 120-char ruler, format on save (Prettier).

| Key | Action |
|-----|--------|
| `Space rf` | Format file |

Features: auto-close tags, auto-rename tags, Emmet abbreviations (also in JSX, TSX, Vue).

### C / C++

Settings: 4-space indent, 120-char ruler, format on save (clang-format).

| Key | Action |
|-----|--------|
| `Space rf` | Format file |
| `Space rh` | Switch header/source |

### Go

Settings: tab indent (width 4), 120-char ruler, format on save (goimports).

## Plugins

### Oil (file explorer)

`Space -` opens a floating Oil window. Directories are editable buffers:
- Navigate with `j`/`k`, `Enter` to open
- Delete a line to delete a file (goes to trash)
- Add a line to create a file
- Edit a line to rename
- `-` to go to parent directory

### Flash (navigation)

| Key | Action |
|-----|--------|
| `s` | Jump to any visible word (type 2 chars, then a label) |
| `S` | Treesitter-aware jump |
| `r` | Remote flash (operator-pending) |

Works in operator mode: `ds<label>` deletes to target, `ys<label>w"` surrounds to target.

### Comments

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc` + motion | Comment with motion (`gc3j`, `gcip`) |
| `gc` (visual) | Comment selection |

### Surround

| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround (`ysiw"` wraps word in quotes) |
| `ds{char}` | Delete surround (`ds"` removes quotes) |
| `cs{old}{new}` | Change surround (`cs"'` changes `"` to `'`) |

## Common workflows

**New Python project:**
Create venv, activate it, install debugpy/pytest, open Neovim. LSP detects the venv automatically.

**Debugging:**
Set breakpoints (`Space db`), start (`Space dc`), step (`Space ds`/`Space di`), inspect variables in the UI, stop (`Space dt`).

**Running tests:**
Open a test file, run nearest (`Space tt`) or all (`Space tf`), view results (`Space ts`).

**Git:**
Edit files, navigate hunks (`]h`/`[h`), stage (`Space hs`), open LazyGit (`Space gg`) to commit and push.

**Refactoring:**
Rename (`Space rn`), check references (`gr`), use code actions (`Space ca`), jump to definition (`gd`).

## Troubleshooting

| Problem | What to do |
|---------|------------|
| LSP not working | `:LspInfo` to check status, verify server is installed and in PATH |
| Plugin not loading | `:Lazy` to check status, `U` to update, `S` to sync |
| Python features broken | Activate venv, install debugpy/pytest, restart Neovim |
| Format on save broken | `:ConformInfo` to check formatters, verify tool is installed |
| Key not working | `:verbose map <key>` to see what it maps to |
| Slow startup | `:Lazy profile` to find slow plugins |
| Missing dependencies | `brew bundle check --verbose` |
