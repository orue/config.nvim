# Manual

Complete reference for this configuration. Leader key is `Space`: press it and wait to see available keys (which-key), or press `Space ?` for keys local to the current buffer.

New to Vim coming from VS Code? Start with [KEYBINDINGS.md](KEYBINDINGS.md).

## Core

| Key | Action |
|-----|--------|
| `Space -` | File explorer (Oil, floating) |
| `Space A` | Dashboard |
| `Space en` | Browse Neovim config files |
| `Space Space x` | Source current file |
| `Space x` | Run current line as Lua (visual: selection) |
| `Ctrl+\` | Toggle floating terminal |
| `Esc Esc` | Leave terminal mode in the floating terminal (scroll and copy with Normal-mode keys) |
| `Esc` | Clear search highlighting |

## Buffers

| Key | Action |
|-----|--------|
| `Shift+H` / `Shift+L` | Previous / next buffer (bufferline order) |
| `[b` / `]b` | Previous / next buffer (`:bprevious` / `:bnext`) |
| `Space 1`–`Space 5` | Go to buffer 1–5 |
| `Space bd` / `Space bx` | Close buffer |
| `Space bo` | Close all other buffers |
| `Space bp` | Pin buffer |
| `Space bh` / `Space bl` | Move buffer left / right |

## Windows

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Move between windows |

## Text editing

| Key | Mode | Action |
|-----|------|--------|
| `Alt+j` / `Alt+k` | Normal, Visual | Move line(s) down / up |
| `<` / `>` (or `←` / `→`) | Visual | Indent left / right (keeps selection) |
| `gcc` / `gc{motion}` | Normal | Toggle line comment (`{/* */}` inside JSX) |
| `gbc` / `gb{motion}` | Normal | Toggle block comment |
| `gc` / `gb` | Visual | Comment selection (line / block) |
| `ys{motion}{char}` | Normal | Add surround (`ysiw"` wraps word in quotes) |
| `ds{char}` | Normal | Delete surround (`ds"`) |
| `cs{old}{new}` | Normal | Change surround (`cs"'`) |
| `S{char}` | Visual | Surround selection |

Auto-pairs close brackets and quotes as you type; HTML/JSX/TSX tags auto-close and auto-rename.

### Code text objects

Use these after an operator (`d`, `c`, `y`, `v`) like `iw` or `ip`:

| Key | Selects |
|-----|---------|
| `af` / `if` | A whole function / its body (`daf` deletes a function, `cif` rewrites its body) |
| `ac` / `ic` | A whole class / its body |
| `aa` / `ia` | An argument with / without its comma |
| `]f` / `[f` | Jump to the next / previous function (`Ctrl+o` jumps back) |

### Folding

Code folds by syntax (functions, classes, blocks). Everything starts unfolded.

| Key | Action |
|-----|--------|
| `za` | Toggle the fold under the cursor |
| `zM` / `zR` | Close / open all folds |
| `zc` / `zo` | Close / open one fold |

### Editor behavior

- Undo history is kept after you close a file: reopen it and `u` still works.
- `:q` with unsaved changes asks whether to save instead of showing an error.
- `:%s/old/new/g` previews every replacement live, in a split, as you type.
- Wrapped lines keep their indentation.

## Navigation (Flash)

| Key | Mode | Action |
|-----|------|--------|
| `s` | Normal, Visual, Operator | Jump to any visible location (type 2 chars, then a label) |
| `S` | Normal, Operator | Treesitter-aware jump / select |
| `r` | Operator | Remote flash (`yr<label>iw` yanks a word elsewhere) |
| `R` | Operator, Visual | Treesitter search |
| `Ctrl+s` | Command line (search) | Toggle Flash in `/` search |

`f`/`t`/`F`/`T` are enhanced by Flash too.

## Find and search (Telescope)

| Key | Action |
|-----|--------|
| `Space fd` | Find files (includes hidden files) |
| `Space fg` | Multi-grep (see below) |
| `Space fb` | Open buffers |
| `Space fo` | Recent files |
| `Space fh` | Help tags |
| `Space fr` | LSP references |
| `Space fs` | Document symbols |
| `Space ft` | TODO/FIXME/NOTE comments |
| `]t` / `[t` | Next / previous TODO comment |

Inside Telescope: type to filter, `Ctrl+n`/`Ctrl+p` to navigate, `Enter` to open, `Esc` to close, `Ctrl+q` to send results to the quickfix list.

### Multi-grep

`Space fg` opens a grep prompt. Type your search, then two spaces, then a file glob.

- `function  *.py` -- search "function" in Python files
- `TODO  src/**/*` -- search "TODO" under src/
- `import  **/*.{js,ts}` -- search "import" in JS/TS files

## LSP

Available in any buffer with a language server attached.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gp` | Peek definition (floating preview) |
| `grr` | References (Neovim built-in; also `grn` rename, `gra` code action, `gri` implementation, `grt` type definition) |
| `gi` | Implementation |
| `gD` | Type definition |
| `gO` | Document symbols |
| `K` | Hover documentation |
| `Space ca` | Code actions (normal and visual) |
| `Space rn` | Rename symbol |
| `Space ws` | Workspace symbols |
| `Space ih` | Toggle inlay hints (servers that support them) |
| `Ctrl+s` | Signature help (insert mode) |

### Diagnostics

| Key | Action |
|-----|--------|
| `Space cd` | Line diagnostics (float); `Ctrl+w d` also works |
| `[d` / `]d` | Previous / next diagnostic (shows its message) |
| `[D` / `]D` | First / last diagnostic |
| `Space wd` | All diagnostics in the quickfix list |

### Formatting

Format on save is enabled for all supported languages.

| Language | Formatter |
|----------|-----------|
| Python | Ruff (format + organize imports) |
| JS, TS, JSX, TSX, HTML, CSS, JSON, GraphQL, Markdown | Prettier |
| C / C++ | clang-format |
| Go | goimports |
| Lua, YAML, TOML, Terraform, shell | The language server (fallback) |

`Space rf` formats manually. `:ConformInfo` shows which formatter applies.

## Completion (insert mode)

| Key | Action |
|-----|--------|
| `Ctrl+Space` | Show completions |
| `Tab` / `Shift+Tab` | Next / previous item, or jump between snippet placeholders |
| `Enter` | Accept |
| `Ctrl+u` / `Ctrl+d` | Scroll documentation |

## Git

| Key | Action |
|-----|--------|
| `Space gg` | LazyGit |
| `]h` / `[h` | Next / previous hunk |
| `Space hp` | Preview hunk |
| `Space hs` | Stage hunk (visual: selected lines) |
| `Space hr` | Reset hunk (visual: selected lines) |
| `Space hb` | Blame line |

## Debugging (DAP)

Supported: Python (debugpy), C/C++ (lldb-dap), Go (Delve).

| Key | Action |
|-----|--------|
| `Space db` | Toggle breakpoint |
| `Space dc` | Start / continue |
| `Space ds` | Step over |
| `Space di` | Step into |
| `Space dt` | Terminate |

The debug UI opens when a session starts and closes when it ends. The first Go debug run in a project can take a while: Delve builds an unoptimized binary.

## Testing (Neotest)

Supported: Python (pytest) and Go (gotestsum). Failed tests are marked in the file, with the failure message on the failing line.

| Key | Action |
|-----|--------|
| `Space tt` | Run nearest test |
| `Space tf` | Run all tests in file |
| `Space ts` | Toggle test summary |
| `Space to` | Show the output of the test under the cursor |

## Sessions

Neovim saves your open files, splits and working directory for each project (and git branch) when you quit. It never restores on its own: press `s` on the dashboard, or use the keys below.

| Key | Action |
|-----|--------|
| `Space qs` | Restore the session for this directory |
| `Space qS` | Pick a saved session from a list |
| `Space ql` | Restore the last session, wherever it was |
| `Space qd` | Don't save a session when quitting this time |

Terminals (including the Claude Code panel) aren't saved in sessions.

## Docstrings (Neogen)

| Key | Action |
|-----|--------|
| `Space nf` | Generate function docstring |
| `Space nc` | Generate class docstring |

Python uses Google-style docstrings.

## Claude Code

| Key | Mode | Action |
|-----|------|--------|
| `Space ac` | Normal | Toggle Claude Code |
| `Space af` | Normal | Focus Claude |
| `Space ar` | Normal | Resume last session |
| `Space aC` | Normal | Continue conversation |
| `Space am` | Normal | Select model |
| `Space ab` | Normal | Add current buffer to context |
| `Space as` | Visual | Send selection to Claude |
| `Space at` | Normal (Oil) | Add file under cursor to context |
| `Space aa` / `Space ad` | Normal | Accept / deny proposed diff |

Files Claude edits are reloaded automatically.

## Language-specific keys and settings

### Python

4-space indent, 120-char ruler, Pyright (types) + Ruff (lint, format).

| Key | Action |
|-----|--------|
| `Space ri` | Organize imports |

Virtual environments (`.venv`, `venv`, `env`, or `$VIRTUAL_ENV`) are detected per project; the statusline shows the active one. Ruff uses 120 columns unless the project has its own ruff config.

### JavaScript / TypeScript / React

2-space indent, 100-char ruler. Language server: TypeScript 7's native `tsc --lsp`; ESLint also runs in projects that have an ESLint config. Emmet works in JSX/TSX.

| Key | Action |
|-----|--------|
| `Space ri` | Organize imports |

### Go

Tab indent (width 4), 120-char ruler, gopls + goimports.

| Key | Action |
|-----|--------|
| `Space ri` | Organize imports |
| `Space rats` | Add struct tags (cursor on a struct) |
| `Space rt` | Run tests (current package) |
| `Space rc` | Run test coverage (current package) |
| `Space re` | Run all tests (`./...`) |
| `Space rvt` | Run all tests with the race detector |
| `Space rab` | Run benchmarks |

Go tests also run through Neotest (`Space tt`, `Space tf`, `Space ts`, `Space to`), like Python.

### C / C++

4-space indent, 120-char ruler, clangd + clang-format.

| Key | Action |
|-----|--------|
| `Space rh` | Switch header / source |

### HTML / CSS

2-space indent, 120-char ruler, Prettier. Emmet abbreviations, auto-close and auto-rename tags.

### Markdown

Wraps at 80 columns, spell check on, markup concealed.

| Key | Action |
|-----|--------|
| `Space mt` | Insert TODO checkbox |
| `Space mc` / `Space mu` | Check / uncheck the checkbox on this line |
| `]]` / `[[` | Next / previous section |
| `gO` | Outline |

### Other languages

YAML, TOML, Terraform (2-space indent), Dockerfile (4-space), Bash, and Lua have language servers and format through them.

## Plugins

### Oil (file explorer)

`Space -` opens a floating Oil window. Directories are editable buffers:
- Navigate with `j`/`k`, `Enter` to open, `-` for the parent directory
- Delete a line to delete a file (goes to the trash)
- Add a line to create a file; edit a line to rename
- `Alt+h` opens in a split, `q` closes

### Dashboard

Shown when Neovim starts without a file. Quick actions: new file (`e`), new project (`n`), restore session (`s`), find file (`f`), recent files (`r`), grep (`g`), browse (`b`), config (`c`), quit (`q`). Recent projects (by git root) are on `1`–`5`.

## Common workflows

**New Python project:**
Create a venv, activate it, `pip install debugpy pytest`, open Neovim. The LSP, debugger and test runner find the venv automatically.

**Debugging:**
Set breakpoints (`Space db`), start (`Space dc`), step (`Space ds` / `Space di`), inspect variables in the UI, stop (`Space dt`).

**Running tests:**
Open a test file, run the nearest test (`Space tt`) or the whole file (`Space tf`), view results (`Space ts`).

**Git:**
Edit files, navigate hunks (`]h` / `[h`), stage (`Space hs`), open LazyGit (`Space gg`) to commit and push.

**Refactoring:**
Rename (`Space rn`), check references (`grr`), apply code actions (`Space ca`), jump to definition (`gd`).

## Troubleshooting

| Problem | What to do |
|---------|------------|
| LSP not working | `:checkhealth vim.lsp`; verify the server is installed and on PATH (`./install.sh` lists missing tools) |
| Plugin not loading | `:Lazy` to check status, `U` to update, `S` to sync |
| Python features broken | Activate the venv, `pip install debugpy pytest`, restart Neovim |
| Format on save broken | `:ConformInfo` to check formatters; verify the tool is installed |
| Key not working | `:verbose map <key>` to see what it maps to |
| Slow startup | `:Lazy profile` to find slow plugins |
| Missing dependencies | `brew bundle check --verbose` |
