# Neovim Keybindings Guide (VS Code Transition)

> **Leader key** = `Space`
> Press `Space` and wait to see available keys (which-key), or `Space ?` for keys specific to the current buffer.
>
> This guide maps VS Code habits to this config and covers core Vim editing. The complete reference for every key in this config is [MANUAL.md](MANUAL.md).

---

## VS Code → Neovim

| VS Code | Neovim | What it does |
|---------|--------|--------------|
| `Ctrl+P` | `Space fd` | Find files |
| `Ctrl+Shift+F` | `Space fg` | Search across files (grep) |
| `Ctrl+Shift+E` | `Space -` | File explorer (Oil) |
| `Ctrl+Tab` | `Space fb` | Switch between open files |
| `Ctrl+PageUp/Down` | `Shift+H` / `Shift+L` | Previous / next open file |
| `Ctrl+W` | `Space bd` | Close file |
| `` Ctrl+` `` | `Ctrl+\` | Toggle terminal |
| `Ctrl+S` | `:w` | Save (formats on save) |
| `Shift+Alt+F` | `Space rf` | Format document |
| `Ctrl+Z` / `Ctrl+Y` | `u` / `Ctrl+r` | Undo / redo |
| `Ctrl+/` | `gcc` | Toggle line comment |
| `Shift+Alt+A` | `gbc` | Toggle block comment |
| `Alt+↑` / `Alt+↓` | `Alt+k` / `Alt+j` | Move line up / down |
| `F12` | `gd` | Go to definition |
| `Alt+F12` | `gp` | Peek definition |
| `Shift+F12` | `gr` | Find references |
| `F2` | `Space rn` | Rename symbol |
| `Ctrl+.` | `Space ca` | Quick fix / code actions |
| hover mouse | `K` | Show documentation |
| `Ctrl+Space` | `Ctrl+Space` | Trigger completion |
| `F8` | `]d` | Next problem |
| `Ctrl+Shift+M` | `Space wd` | Problems panel (quickfix list) |
| `Ctrl+Shift+O` | `Space fs` | Go to symbol in file |
| `Ctrl+T` | `Space ws` | Go to symbol in workspace |
| `F9` | `Space db` | Toggle breakpoint |
| `F5` | `Space dc` | Start / continue debugging |
| `F10` / `F11` | `Space ds` / `Space di` | Step over / into |
| `Ctrl+Shift+G` | `Space gg` | Source control (LazyGit) |
| `Ctrl+Shift+P` | `:` | Command palette (Ex commands) |

---

## Moving Around a File

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
| `s` | Flash jump — type 2 chars, then the label |

### Search in File

| Key | What it does |
|-----|--------------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` / `N` | Next / Previous match |
| `*` / `#` | Search word under cursor forward / backward |

---

## Editing

| Key | What it does |
|-----|--------------|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at start / end of line |
| `o` / `O` | New line below / above |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` / `P` | Paste after / before |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `di(` | Delete inside parentheses |
| `cc` | Change entire line |
| `.` | Repeat last change |

### Visual Selection

| Key | What it does |
|-----|--------------|
| `v` | Character selection |
| `V` | Line selection |
| `<C-v>` | Block (column) selection |
| `viw` | Select word |
| `vi"` | Select inside quotes |
| `vib` | Select inside brackets |
| `>` / `<` | Indent / outdent (stays selected) |

### Surround

| Key | What it does |
|-----|--------------|
| `ys{motion}{char}` | Add surround (e.g., `ysiw"` wraps word in quotes) |
| `cs{old}{new}` | Change surround (e.g., `cs"'` changes `"` to `'`) |
| `ds{char}` | Delete surround (e.g., `ds"` removes quotes) |

---

## Splits

| Key | What it does |
|-----|--------------|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Navigate between splits |
| `:vs` / `:sp` | Vertical / horizontal split |
| `<C-w>q` | Close split |
| `<C-w>=` | Equal split sizes |
| `<C-w>_` / `<C-w>\|` | Maximize height / width |

---

## Quick Tips for VS Code Users

1. **Modes matter**: Press `Esc` to return to Normal mode. `i` to type. This becomes muscle memory fast.
2. **Think in verbs + nouns**: `d` (delete) + `iw` (inner word) = delete word. `c` (change) + `i"` = change inside quotes.
3. **Don't reach for the mouse**: `s` (Flash) lets you jump anywhere in 3 keystrokes.
4. **`:w` to save**, `:q` to quit, `:wq` both. `:q!` to quit without saving.
5. **`Space`, then wait** shows what's available — use it when you forget something.
6. **Repeat with `.`** — the most powerful Vim key. Make a change once, repeat it everywhere.
7. **Everything else** (tests, Git hunks, Claude Code, language-specific keys) is in [MANUAL.md](MANUAL.md).
