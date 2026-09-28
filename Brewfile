# Brewfile for macOS Neovim dependencies
# Install all dependencies with: brew bundle
#
# Provided by the Xcode Command Line Tools (required by Homebrew itself), so not listed here:
#   clangd, clang, lldb-dap (C/C++ LSP and debugger), make (builds telescope-fzf-native)

# Core dependencies
brew "node"              # Needed for Node-based LSP servers
brew "python"            # Python runtime

# Language Servers
brew "lua-language-server"
brew "pyright"
brew "ruff"
brew "typescript"        # TypeScript 7: `tsc --lsp` is the JS/TS/React language server
brew "vscode-langservers-extracted"  # HTML, CSS, JSON, ESLint LSPs
brew "dockerfile-language-server"
brew "bash-language-server"
brew "taplo"
brew "yaml-language-server"
brew "terraform-ls"

# Go toolchain
brew "go"
brew "gopls"             # Go LSP
brew "goimports"         # Go formatter (conform.nvim)
brew "delve"             # Go debugger (nvim-dap)
brew "gotestsum"         # Go test runner used by neotest-golang

# Formatters & Linters
brew "prettier"          # JS/TS/HTML/CSS/JSON/Markdown formatter
brew "clang-format"      # C/C++ formatter
brew "shellcheck"        # Shell linting (used by bash-language-server)
brew "shfmt"             # Shell formatting (used by bash-language-server)
brew "terraform"         # `terraform fmt`, used by terraform-ls for formatting

# Search & Navigation Tools
brew "ripgrep"           # Fast search tool

# Git Tools
brew "lazygit"           # Terminal UI for git

# Build Tools
brew "tree-sitter-cli"   # Required by nvim-treesitter (main branch) to compile parsers

# ============================================================
# NPM-based Language Servers (Not Managed by Homebrew)
# ============================================================
# The following language servers need to be installed via npm:
#
#   npm install -g @olrtg/emmet-language-server
#
# Required npm packages:
#   - emmet-language-server: Emmet abbreviations for HTML/CSS/JSX/TSX
#

# ============================================================
# Python Packages (Not Managed by Homebrew)
# ============================================================
# The following Python packages are required for debugging and testing
# features in Neovim. They should NOT be installed globally via pip.
# Instead, install them per-project in a virtual environment:
#
#   python -m venv .venv
#   source .venv/bin/activate  # On macOS/Linux
#   pip install debugpy pytest
#
# Required Python packages:
#   - debugpy: Python debugger adapter for nvim-dap
#   - pytest: Testing framework for neotest-python
#
# Why not global installation?
#   - Avoids conflicts between project dependencies
#   - Keeps system Python clean
#   - Allows different versions per project
#   - Better isolation and reproducibility
