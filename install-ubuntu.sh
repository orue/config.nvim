#!/usr/bin/env bash

# Comprehensive installation script for Neovim configuration (Ubuntu/Debian)
# This script will:
#   1. Install/update Neovim
#   2. Install all system dependencies (LSP servers, formatters, tools)
#   3. Install all npm dependencies
#   4. Set up Neovim plugins
#
# Usage: ./install-ubuntu.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

echo "========================================"
echo "Neovim Configuration Setup (Ubuntu/Debian)"
echo "========================================"
echo ""

# Check if running on Ubuntu/Debian
if ! command -v apt &> /dev/null; then
  print_error "This script is designed for Ubuntu/Debian systems"
  exit 1
fi

print_success "Running on Ubuntu/Debian"
echo ""

# Check for sudo privileges
if [ "$EUID" -ne 0 ]; then
  print_info "This script requires sudo privileges for some installations"
  echo "You may be prompted for your password..."
  echo ""
fi

# ============================================================
# 1. Update Package Lists
# ============================================================
echo ""
echo "Step 1: Updating Package Lists..."
echo "----------------------------"
sudo apt update
print_success "Package lists updated"

# ============================================================
# 2. Install/Update Neovim
# ============================================================
echo ""
echo "Step 2: Installing/Updating Neovim..."
echo "--------------------------------------"

if command -v nvim &> /dev/null; then
  CURRENT_VERSION=$(nvim --version | head -1)
  print_info "Current Neovim version: $CURRENT_VERSION"
fi

print_info "Installing Neovim (latest stable)..."
# Add Neovim PPA for latest version
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim

print_success "Neovim installed: $(nvim --version | head -1)"

# ============================================================
# 3. Install Core Dependencies
# ============================================================
echo ""
echo "Step 3: Installing Core Dependencies..."
echo "----------------------------------------"

# Core packages
declare -a core_packages=(
  "curl"
  "wget"
  "git"
  "build-essential"
  "unzip"
)

for package in "${core_packages[@]}"; do
  if dpkg -l | grep -q "^ii  $package "; then
    print_success "$package (already installed)"
  else
    print_info "Installing $package..."
    sudo apt install -y "$package"
  fi
done

# ============================================================
# 4. Install Node.js and npm
# ============================================================
echo ""
echo "Step 4: Installing Node.js and npm..."
echo "--------------------------------------"

if ! command -v node &> /dev/null; then
  print_info "Installing Node.js via NodeSource..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt install -y nodejs
  print_success "Node.js installed"
else
  print_success "Node.js is already installed ($(node --version))"
fi

if ! command -v npm &> /dev/null; then
  print_error "npm is not installed"
  exit 1
fi

print_success "npm: $(npm --version)"

# ============================================================
# 5. Install Python 3
# ============================================================
echo ""
echo "Step 5: Installing Python 3..."
echo "-------------------------------"

if ! command -v python3 &> /dev/null; then
  print_info "Installing Python3..."
  sudo apt install -y python3 python3-pip python3-venv
  print_success "Python3 installed"
else
  print_success "Python3 is already installed ($(python3 --version))"
fi

# Ensure pip is installed
if ! command -v pip3 &> /dev/null; then
  sudo apt install -y python3-pip
fi

# ============================================================
# 6. Install Go
# ============================================================
echo ""
echo "Step 6: Installing Go..."
echo "------------------------"

if ! command -v go &> /dev/null; then
  print_info "Installing Go..."
  # Get latest Go version
  GO_VERSION="1.21.5"
  wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
  rm "go${GO_VERSION}.linux-amd64.tar.gz"

  # Add to PATH if not already there
  if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
  fi
  export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
  print_success "Go installed"
else
  print_success "Go is already installed ($(go version))"
  export PATH=$PATH:$HOME/go/bin
fi

# ============================================================
# 7. Install APT Packages
# ============================================================
echo ""
echo "Step 7: Installing APT Packages..."
echo "-----------------------------------"

declare -a apt_packages=(
  "ripgrep"
  "make"
)

for package in "${apt_packages[@]}"; do
  if dpkg -l | grep -q "^ii  $package "; then
    print_success "$package (already installed)"
  else
    print_info "Installing $package..."
    sudo apt install -y "$package"
  fi
done

# ============================================================
# 8. Install Language Servers (NPM)
# ============================================================
echo ""
echo "Step 8: Installing npm Language Servers..."
echo "-------------------------------------------"

declare -a npm_packages=(
  "bash-language-server"
  "dockerfile-language-server-nodejs"
  "yaml-language-server"
  "typescript-language-server"
  "@vue/language-server"
  "vscode-langservers-extracted"
  "emmet-ls"
  "prettier"
)

for package in "${npm_packages[@]}"; do
  if npm list -g "$package" &> /dev/null; then
    print_success "$package (already installed)"
  else
    print_info "Installing $package globally..."
    sudo npm install -g "$package"
  fi
done

# ============================================================
# 9. Install Language Servers (Python/pipx)
# ============================================================
echo ""
echo "Step 9: Installing Python Language Servers..."
echo "----------------------------------------------"

# Install pipx if not available
if ! command -v pipx &> /dev/null; then
  print_info "Installing pipx..."
  python3 -m pip install --user pipx
  python3 -m pipx ensurepath
  export PATH="$HOME/.local/bin:$PATH"
fi

declare -a pipx_packages=(
  "pyright"
  "ruff"
)

for package in "${pipx_packages[@]}"; do
  if pipx list | grep -q "$package"; then
    print_success "$package (already installed)"
  else
    print_info "Installing $package via pipx..."
    pipx install "$package"
  fi
done

# ============================================================
# 10. Install Language Servers (Go)
# ============================================================
echo ""
echo "Step 10: Installing Go Language Servers..."
echo "-------------------------------------------"

# gopls
if command -v gopls &> /dev/null; then
  print_success "gopls (already installed)"
else
  print_info "Installing gopls..."
  go install golang.org/x/tools/gopls@latest
fi

# delve (Go debugger)
if command -v dlv &> /dev/null; then
  print_success "delve (already installed)"
else
  print_info "Installing delve..."
  go install github.com/go-delve/delve/cmd/dlv@latest
fi

# ============================================================
# 11. Install Additional Language Servers
# ============================================================
echo ""
echo "Step 11: Installing Additional Language Servers..."
echo "---------------------------------------------------"

# lua-language-server
if command -v lua-language-server &> /dev/null; then
  print_success "lua-language-server (already installed)"
else
  print_info "Installing lua-language-server..."
  cd /tmp
  wget https://github.com/LuaLS/lua-language-server/releases/download/3.7.4/lua-language-server-3.7.4-linux-x64.tar.gz
  mkdir -p ~/.local/share/lua-language-server
  tar -xzf lua-language-server-3.7.4-linux-x64.tar.gz -C ~/.local/share/lua-language-server
  rm lua-language-server-3.7.4-linux-x64.tar.gz

  # Create wrapper script
  mkdir -p ~/.local/bin
  cat > ~/.local/bin/lua-language-server << 'EOF'
#!/usr/bin/env bash
exec "$HOME/.local/share/lua-language-server/bin/lua-language-server" "$@"
EOF
  chmod +x ~/.local/bin/lua-language-server
  export PATH="$HOME/.local/bin:$PATH"
  print_success "lua-language-server installed"
fi

# marksman (Markdown LSP)
if command -v marksman &> /dev/null; then
  print_success "marksman (already installed)"
else
  print_info "Installing marksman..."
  cd /tmp
  wget https://github.com/artempyanykh/marksman/releases/download/2023-12-09/marksman-linux-x64
  chmod +x marksman-linux-x64
  mkdir -p ~/.local/bin
  mv marksman-linux-x64 ~/.local/bin/marksman
  print_success "marksman installed"
fi

# taplo (TOML LSP)
if command -v taplo &> /dev/null; then
  print_success "taplo (already installed)"
else
  print_info "Installing taplo..."
  cd /tmp
  wget https://github.com/tamasfe/taplo/releases/download/0.8.1/taplo-linux-x86_64.gz
  gunzip taplo-linux-x86_64.gz
  chmod +x taplo-linux-x86_64
  mkdir -p ~/.local/bin
  mv taplo-linux-x86_64 ~/.local/bin/taplo
  print_success "taplo installed"
fi

# terraform-ls
if command -v terraform-ls &> /dev/null; then
  print_success "terraform-ls (already installed)"
else
  print_info "Installing terraform-ls..."
  cd /tmp
  wget https://releases.hashicorp.com/terraform-ls/0.32.8/terraform-ls_0.32.8_linux_amd64.zip
  unzip terraform-ls_0.32.8_linux_amd64.zip
  mkdir -p ~/.local/bin
  mv terraform-ls ~/.local/bin/
  rm terraform-ls_0.32.8_linux_amd64.zip
  print_success "terraform-ls installed"
fi

# ============================================================
# 12. Install lazygit
# ============================================================
echo ""
echo "Step 12: Installing lazygit..."
echo "-------------------------------"

if command -v lazygit &> /dev/null; then
  print_success "lazygit (already installed)"
else
  print_info "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  cd /tmp
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  mkdir -p ~/.local/bin
  mv lazygit ~/.local/bin/
  rm lazygit.tar.gz
  print_success "lazygit installed"
fi

# ============================================================
# 13. Verify Installations
# ============================================================
echo ""
echo "Step 13: Verifying Installations..."
echo "------------------------------------"
echo ""

# Check critical LSP servers
LSP_SERVERS=(
  "lua-language-server"
  "gopls"
  "pyright"
  "ruff"
  "typescript-language-server"
  "vscode-html-language-server"
  "emmet-ls"
  "prettier"
)

echo "Checking installed tools:"
for cmd in "${LSP_SERVERS[@]}"; do
  if command -v "$cmd" &> /dev/null; then
    print_success "$cmd"
  else
    print_error "$cmd (not found)"
  fi
done

# ============================================================
# 14. Setup Neovim Plugins
# ============================================================
echo ""
echo "Step 14: Setting up Neovim Plugins..."
echo "--------------------------------------"
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
# 15. Final Instructions
# ============================================================
echo ""
echo "========================================"
echo "✓ Installation Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Restart your shell or run:"
echo "   source ~/.bashrc"
echo ""
echo "2. Start Neovim:"
echo "   nvim"
echo ""
echo "3. Plugins will install automatically (via lazy.nvim)"
echo "   Wait for all plugins to finish installing"
echo ""
echo "4. Restart Neovim after plugins are installed"
echo ""
echo "5. Verify everything works:"
echo "   :checkhealth"
echo "   :LspInfo"
echo ""
echo "6. For Python projects, create a virtual environment:"
echo "   python3 -m venv .venv"
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
