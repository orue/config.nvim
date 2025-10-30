#!/bin/bash

# Comprehensive installation script for Neovim configuration (macOS)
# This script will:
#   1. Install/update Neovim
#   2. Install all Homebrew dependencies (LSP servers, formatters, tools)
#   3. Install all npm dependencies (emmet-ls)
#   4. Set up Neovim plugins
#
# Usage: ./install.sh

set -e  # Exit on error

echo "========================================"
echo "Neovim Configuration Setup (macOS)"
echo "========================================"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS"
    echo "For Ubuntu/Debian, use ./install-ubuntu.sh instead"
    exit 1
fi

# ============================================================
# 1. Check Homebrew
# ============================================================
echo ""
echo "Step 1: Checking Homebrew..."
echo "----------------------------"

if ! command -v brew &> /dev/null; then
    print_error "Homebrew is not installed"
    echo "Please install Homebrew first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

print_success "Homebrew found: $(brew --version | head -1)"

# ============================================================
# 2. Install/Update Neovim
# ============================================================
echo ""
echo "Step 2: Installing/Updating Neovim..."
echo "--------------------------------------"

if command -v nvim &> /dev/null; then
    CURRENT_VERSION=$(nvim --version | head -1)
    print_info "Current Neovim version: $CURRENT_VERSION"
    print_info "Updating Neovim..."
    brew upgrade neovim || brew install neovim
else
    print_info "Installing Neovim..."
    brew install neovim
fi

print_success "Neovim installed: $(nvim --version | head -1)"

# ============================================================
# 3. Install Homebrew Dependencies
# ============================================================
echo ""
echo "Step 3: Installing Homebrew Dependencies..."
echo "--------------------------------------------"
print_info "This will install LSP servers, formatters, and tools"
echo ""

if [ -f "Brewfile" ]; then
    brew bundle --file=Brewfile
    print_success "All Homebrew dependencies installed"
else
    print_error "Brewfile not found in current directory"
    exit 1
fi

# ============================================================
# 4. Check Node.js and npm
# ============================================================
echo ""
echo "Step 4: Checking Node.js and npm..."
echo "------------------------------------"

if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed"
    print_info "Installing Node.js via Homebrew..."
    brew install node
fi

if ! command -v npm &> /dev/null; then
    print_error "npm is not installed"
    exit 1
fi

print_success "Node.js: $(node --version)"
print_success "npm: $(npm --version)"

# ============================================================
# 5. Install npm Dependencies
# ============================================================
echo ""
echo "Step 5: Installing npm Dependencies..."
echo "---------------------------------------"
print_info "Installing global npm packages"
echo ""

NPM_PACKAGES=(
    "emmet-ls"
)

for package in "${NPM_PACKAGES[@]}"; do
    print_info "Installing $package..."
    npm install -g "$package"
    print_success "$package installed"
done

# ============================================================
# 6. Verify Installations
# ============================================================
echo ""
echo "Step 6: Verifying Installations..."
echo "-----------------------------------"
echo ""

# Check critical LSP servers
LSP_SERVERS=(
    "lua-language-server:lua-language-server"
    "gopls:gopls"
    "pyright:pyright-langserver"
    "ruff:ruff"
    "typescript-language-server:typescript-language-server"
    "vscode-html-language-server:vscode-langservers-extracted"
    "emmet-ls:emmet-ls"
    "prettier:prettier"
    "clangd:/opt/homebrew/opt/llvm/bin/clangd"
)

echo "Checking installed tools:"
for entry in "${LSP_SERVERS[@]}"; do
    IFS=':' read -r cmd package <<< "$entry"
    if command -v "$cmd" &> /dev/null || [ -f "$cmd" ]; then
        print_success "$package"
    else
        print_error "$package (not found)"
    fi
done

# ============================================================
# 7. Setup Neovim Plugins
# ============================================================
echo ""
echo "Step 7: Setting up Neovim Plugins..."
echo "-------------------------------------"
print_info "Neovim will install plugins on first launch"
echo ""

# Create backup of existing Neovim data if it exists
if [ -d "$HOME/.local/share/nvim" ]; then
    print_info "Backing up existing Neovim data..."
    BACKUP_DIR="$HOME/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.local/share/nvim" "$BACKUP_DIR"
    print_success "Backup created at: $BACKUP_DIR"
fi

# ============================================================
# 8. Final Instructions
# ============================================================
echo ""
echo "========================================"
echo "✓ Installation Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Start Neovim:"
echo "   nvim"
echo ""
echo "2. Plugins will install automatically (via lazy.nvim)"
echo "   Wait for all plugins to finish installing"
echo ""
echo "3. Restart Neovim after plugins are installed"
echo ""
echo "4. Verify everything works:"
echo "   :checkhealth"
echo "   :LspInfo"
echo ""
echo "5. For Python projects, create a virtual environment:"
echo "   python -m venv .venv"
echo "   source .venv/bin/activate"
echo "   pip install debugpy pytest"
echo ""
echo "Installed LSP Servers:"
echo "  • Lua, Python, Go, C/C++"
echo "  • TypeScript/JavaScript, Vue.js"
echo "  • HTML, CSS, Emmet"
echo "  • Markdown, Docker, Bash, YAML, TOML, Terraform"
echo ""
echo "For detailed usage, see MANUAL.md"
echo ""
