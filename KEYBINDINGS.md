# Neovim Keybindings Guide (VS Code Transition)

> **Leader key** = `Space`
> Press `<leader>?` anytime to see available keymaps via which-key.

---

## Essentials (Learn These First)

| VS Code | Neovim | What it does |
|---------|--------|--------------|
| `Ctrl+P` | `<leader>fd` | Find files |
| `Ctrl+Shift+F` | `<leader>fg` | Search across files (grep) |
| `Ctrl+Shift+E` | `<leader>-` | File explorer (Oil) |
| `Ctrl+`` ` | `<C-\>` | Toggle terminal |
| `Ctrl+S` | `:w` | Save file |
| `Ctrl+Z` / `Ctrl+Y` | `u` / `<C-r>` | Undo / Redo |
| `Ctrl+/` | `gcc` | Toggle line comment |
| `Ctrl+Shift+/` | `gbc` | Toggle block comment |

---

## Navigation

### Moving Around a File

| Key | What it does |
|-----|--------------|
| `h` `j` `k` `l` | Left, Down, Up, Right |
| `w` / `b` | Jump forward / back by word |
| `e` | Jump to end of word |
| `0` / `$` | Start / End of line |
| `^` | First non-blank character |
| `gg` / `G` | Top / Bottom of file |
| `{` / `}` | Previous / Next paragraph |
| `<C-u>` / `<C-d>` | Half-page up / down |
| `<C-o>` / `<C-i>` | Jump back / forward (history) |
| `%` | Jump to matching bracket |
| `zz` | Center screen on cursor |

### Flash (Quick Jump)

| Key | What it does |
|-----|--------------|
| `s` | Flash jump — type 2 chars, then label |
| `S` | Flash Treesitter select |

### Search in File

| Key | What it does |
|-----|--------------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` / `N` | Next / Previous match |
| `*` / `#` | Search word under cursor forward / backward |

---

## Buffers (Tabs)

| Key | What it does |
|-----|--------------|
| `Shift+L` | Next buffer |
| `Shift+H` | Previous buffer |
| `<leader>1`–`5` | Jump to buffer 1–5 |
| `<leader>bx` | Close current buffer |
| `<leader>bo` | Close all other buffers |
| `<leader>bp` | Pin buffer |
| `<leader>bl` / `<leader>bh` | Move buffer right / left |

---

## Windows (Splits)

| Key | What it does |
|-----|--------------|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Navigate between splits |
| `:vs` | Vertical split |
| `:sp` | Horizontal split |
| `<C-w>q` | Close split |
| `<C-w>=` | Equal split sizes |
| `<C-w>_` / `<C-w>\|` | Maximize height / width |

---

## Editing

### Basic Operations

| Key | Mode | What it does |
|-----|------|--------------|
| `i` / `a` | Normal | Insert before / after cursor |
| `I` / `A` | Normal | Insert at start / end of line |
| `o` / `O` | Normal | New line below / above |
| `dd` | Normal | Delete line |
| `yy` | Normal | Copy line |
| `p` / `P` | Normal | Paste after / before |
| `ciw` | Normal | Change inner word |
| `ci"` | Normal | Change inside quotes |
| `di(` | Normal | Delete inside parentheses |
| `cc` | Normal | Change entire line |
| `.` | Normal | Repeat last change |

### Visual Selection

| Key | What it does |
|-----|--------------|
| `v` | Character selection |
| `V` | Line selection |
| `<C-v>` | Block (column) selection |
| `viw` | Select word |
| `vi"` | Select inside quotes |
| `vib` | Select inside brackets |

### Move & Indent Lines

| Key | Mode | What it does |
|-----|------|--------------|
| `Alt+j` / `Alt+k` | Normal/Visual | Move line(s) down / up |
| `>` / `<` | Visual | Indent / Outdent (stays selected) |

### Surround (nvim-surround)

| Key | What it does |
|-----|--------------|
| `ys{motion}{char}` | Add surround (e.g., `ysiw"` wraps word in quotes) |
| `cs{old}{new}` | Change surround (e.g., `cs"'` changes `"` to `'`) |
| `ds{char}` | Delete surround (e.g., `ds"` removes quotes) |

---

## Find & Search

| Key | What it does |
|-----|--------------|
| `<leader>fd` | Find files |
| `<leader>fg` | Live grep (multi-grep with `  ` separator for file filter) |
| `<leader>fb` | Find open buffers |
| `<leader>fo` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>ft` | Find TODOs |
| `<leader>en` | Browse nvim config files |

---

## Code Intelligence (LSP)

| Key | What it does |
|-----|--------------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gD` | Go to type definition |
| `gO` | Document symbols (outline) |
| `gp` | Peek definition (floating) |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>rf` | Format buffer |
| `<leader>ws` | Workspace symbols |
| `<leader>ih` | Toggle inlay hints |

### Diagnostics

| Key | What it does |
|-----|--------------|
| `<leader>d` | Show line diagnostics |
| `[d` / `]d` | Previous / Next diagnostic |
| `<leader>wd` | Workspace diagnostics list |

---

## Git

| Key | What it does |
|-----|--------------|
| `<leader>gg` | Open LazyGit |
| `]h` / `[h` | Next / Previous hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hb` | Blame line |

---

## Testing & Debugging

### Tests (Neotest)

| Key | What it does |
|-----|--------------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run all tests in file |
| `<leader>ts` | Toggle test summary |

### Debug (DAP)

| Key | What it does |
|-----|--------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue / Start debugger |
| `<leader>ds` | Step over |
| `<leader>di` | Step into |
| `<leader>dt` | Terminate debugger |

---

## Code Generation

| Key | What it does |
|-----|--------------|
| `<leader>nf` | Generate function docstring |
| `<leader>nc` | Generate class docstring |

---

## Completion (Insert Mode)

| Key | What it does |
|-----|--------------|
| `<C-Space>` | Trigger completions |
| `Tab` / `Shift+Tab` | Next / Previous item |
| `Enter` | Accept completion |
| `<C-u>` / `<C-d>` | Scroll docs up / down |

---

## Quick Tips for VS Code Users

1. **Modes matter**: Press `Esc` to return to Normal mode. `i` to type. This becomes muscle memory fast.
2. **Think in verbs + nouns**: `d` (delete) + `iw` (inner word) = delete word. `c` (change) + `i"` = change inside quotes.
3. **Don't reach for the mouse**: `s` (Flash) lets you jump anywhere in 3 keystrokes.
4. **`:w` to save**, `:q` to quit, `:wq` both. `:q!` to quit without saving.
5. **`<leader>?`** shows all available keymaps — use it when you forget something.
6. **Repeat with `.`** — the most powerful Vim key. Make a change once, repeat it everywhere.
