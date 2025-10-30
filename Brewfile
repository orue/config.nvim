# Brewfile for macOS Neovim dependencies
# Install all dependencies with: brew bundle

# Core dependencies
brew "node"              # Needed for some LSP servers
brew "python3"           # Python runtime

# Language Servers
brew "lua-language-server"
brew "gopls"
brew "pyright"
brew "ruff"
brew "marksman"
brew "dockerfile-language-server"
brew "bash-language-server"
brew "taplo"
brew "yaml-language-server"
brew "terraform-ls"
brew "llvm"              # Provides clangd for C/C++

# Debuggers
brew "delve"             # Go debugger
brew "lldb"              # C/C++ debugger (part of LLVM)

# Formatters & Linters
brew "prettier"          # Code formatter (brew instead of npm -g)
brew "clang-format"      # C/C++ formatter

# Search & Navigation Tools
brew "ripgrep"           # Fast search tool

# Git Tools
brew "lazygit"           # Terminal UI for git

# Build Tools
brew "make"              # Build automation

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
