#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Neovim Dependencies - Ubuntu Server"
echo "=========================================="
echo ""

# Check if running on Ubuntu/Debian
if ! command -v apt &> /dev/null; then
  echo -e "${RED}Error: This script is designed for Ubuntu/Debian systems${NC}"
  exit 1
fi

echo -e "${GREEN}✓${NC} Running on Ubuntu/Debian"
echo ""

# Check for sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo -e "${YELLOW}This script requires sudo privileges for some installations${NC}"
  echo "You may be prompted for your password..."
  echo ""
fi

echo "=========================================="
echo "Updating Package Lists"
echo "=========================================="
echo ""
sudo apt update

echo ""
echo "=========================================="
echo "Installing Core Dependencies"
echo "=========================================="
echo ""

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
    echo -e "${GREEN}✓${NC} $package (already installed)"
  else
    echo -e "${YELLOW}→${NC} Installing $package..."
    sudo apt install -y "$package"
  fi
done

echo ""
echo "=========================================="
echo "Installing Node.js"
echo "=========================================="
echo ""

if ! command -v node &> /dev/null; then
  echo -e "${YELLOW}→${NC} Installing Node.js via NodeSource..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt install -y nodejs
  echo -e "${GREEN}✓${NC} Node.js installed"
else
  echo -e "${GREEN}✓${NC} Node.js is already installed ($(node --version))"
fi

echo ""
echo "=========================================="
echo "Installing Python 3"
echo "=========================================="
echo ""

if ! command -v python3 &> /dev/null; then
  echo -e "${YELLOW}→${NC} Installing Python3..."
  sudo apt install -y python3 python3-pip python3-venv
  echo -e "${GREEN}✓${NC} Python3 installed"
else
  echo -e "${GREEN}✓${NC} Python3 is already installed ($(python3 --version))"
fi

# Ensure pip is installed
if ! command -v pip3 &> /dev/null; then
  sudo apt install -y python3-pip
fi

echo ""
echo "=========================================="
echo "Installing Go (for Go tools)"
echo "=========================================="
echo ""

if ! command -v go &> /dev/null; then
  echo -e "${YELLOW}→${NC} Installing Go..."
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
  echo -e "${GREEN}✓${NC} Go installed"
else
  echo -e "${GREEN}✓${NC} Go is already installed ($(go version))"
  export PATH=$PATH:$HOME/go/bin
fi

echo ""
echo "=========================================="
echo "Installing APT Packages"
echo "=========================================="
echo ""

declare -a apt_packages=(
  "ripgrep"
  "make"
)

for package in "${apt_packages[@]}"; do
  if dpkg -l | grep -q "^ii  $package "; then
    echo -e "${GREEN}✓${NC} $package (already installed)"
  else
    echo -e "${YELLOW}→${NC} Installing $package..."
    sudo apt install -y "$package"
  fi
done

echo ""
echo "=========================================="
echo "Installing Language Servers (NPM)"
echo "=========================================="
echo ""

declare -a npm_packages=(
  "bash-language-server"
  "dockerfile-language-server-nodejs"
  "yaml-language-server"
  "prettier"
)

for package in "${npm_packages[@]}"; do
  if npm list -g "$package" &> /dev/null; then
    echo -e "${GREEN}✓${NC} $package (already installed)"
  else
    echo -e "${YELLOW}→${NC} Installing $package globally..."
    sudo npm install -g "$package"
  fi
done

echo ""
echo "=========================================="
echo "Installing Language Servers (Python/pipx)"
echo "=========================================="
echo ""

# Install pipx if not available
if ! command -v pipx &> /dev/null; then
  echo -e "${YELLOW}→${NC} Installing pipx..."
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
    echo -e "${GREEN}✓${NC} $package (already installed)"
  else
    echo -e "${YELLOW}→${NC} Installing $package via pipx..."
    pipx install "$package"
  fi
done

echo ""
echo "=========================================="
echo "Installing Language Servers (Go)"
echo "=========================================="
echo ""

# gopls
if command -v gopls &> /dev/null; then
  echo -e "${GREEN}✓${NC} gopls (already installed)"
else
  echo -e "${YELLOW}→${NC} Installing gopls..."
  go install golang.org/x/tools/gopls@latest
fi

# delve (Go debugger)
if command -v dlv &> /dev/null; then
  echo -e "${GREEN}✓${NC} delve (already installed)"
else
  echo -e "${YELLOW}→${NC} Installing delve..."
  go install github.com/go-delve/delve/cmd/dlv@latest
fi

echo ""
echo "=========================================="
echo "Installing Additional Language Servers"
echo "=========================================="
echo ""

# lua-language-server
if command -v lua-language-server &> /dev/null; then
  echo -e "${GREEN}✓${NC} lua-language-server (already installed)"
else
  echo -e "${YELLOW}→${NC} Installing lua-language-server..."
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
  echo -e "${GREEN}✓${NC} lua-language-server installed"
fi

# marksman (Markdown LSP)
if command -v marksman &> /dev/null; then
  echo -e "${GREEN}✓${NC} marksman (already installed)"
else
  echo -e "${YELLOW}→${NC} Installing marksman..."
  cd /tmp
  wget https://github.com/artempyanykh/marksman/releases/download/2023-12-09/marksman-linux-x64
  chmod +x marksman-linux-x64
  mkdir -p ~/.local/bin
  mv marksman-linux-x64 ~/.local/bin/marksman
  echo -e "${GREEN}✓${NC} marksman installed"
fi

# taplo (TOML LSP)
if command -v taplo &> /dev/null; then
  echo -e "${GREEN}✓${NC} taplo (already installed)"
else
  echo -e "${YELLOW}→${NC} Installing taplo..."
  cd /tmp
  wget https://github.com/tamasfe/taplo/releases/download/0.8.1/taplo-linux-x86_64.gz
  gunzip taplo-linux-x86_64.gz
  chmod +x taplo-linux-x86_64
  mkdir -p ~/.local/bin
  mv taplo-linux-x86_64 ~/.local/bin/taplo
  echo -e "${GREEN}✓${NC} taplo installed"
fi

# terraform-ls
if command -v terraform-ls &> /dev/null; then
  echo -e "${GREEN}✓${NC} terraform-ls (already installed)"
else
  echo -e "${YELLOW}→${NC} Installing terraform-ls..."
  cd /tmp
  wget https://releases.hashicorp.com/terraform-ls/0.32.8/terraform-ls_0.32.8_linux_amd64.zip
  unzip terraform-ls_0.32.8_linux_amd64.zip
  mkdir -p ~/.local/bin
  mv terraform-ls ~/.local/bin/
  rm terraform-ls_0.32.8_linux_amd64.zip
  echo -e "${GREEN}✓${NC} terraform-ls installed"
fi

echo ""
echo "=========================================="
echo "Installing lazygit"
echo "=========================================="
echo ""

if command -v lazygit &> /dev/null; then
  echo -e "${GREEN}✓${NC} lazygit (already installed)"
else
  echo -e "${YELLOW}→${NC} Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  cd /tmp
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  mkdir -p ~/.local/bin
  mv lazygit ~/.local/bin/
  rm lazygit.tar.gz
  echo -e "${GREEN}✓${NC} lazygit installed"
fi

echo ""
echo "=========================================="
echo "Python Packages (Per-Project)"
echo "=========================================="
echo ""

echo -e "${BLUE}Note:${NC} Python packages for debugging and testing should be installed"
echo "in your project's virtual environment, NOT globally:"
echo ""
echo -e "${YELLOW}  python3 -m venv .venv${NC}"
echo -e "${YELLOW}  source .venv/bin/activate${NC}"
echo -e "${YELLOW}  pip install debugpy pytest${NC}"
echo ""
echo "Required packages:"
echo "  - debugpy: Python debugger adapter for nvim-dap"
echo "  - pytest: Testing framework for neotest-python"
echo ""

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""

echo -e "${GREEN}All dependencies have been installed!${NC}"
echo ""
echo "Summary:"
echo "  - Language Servers: 10"
echo "  - Formatters: 1 (prettier)"
echo "  - Debuggers: 2 (delve, debugpy)"
echo "  - Search Tools: 1 (ripgrep)"
echo "  - Git Tools: 1 (lazygit)"
echo "  - Build Tools: 1 (make)"
echo ""
echo -e "${YELLOW}Important:${NC} You may need to restart your shell or run:"
echo -e "  ${BLUE}source ~/.bashrc${NC}"
echo ""
echo "To ensure all tools are in your PATH."
echo ""
echo -e "${GREEN}You're all set! Start Neovim to use the new tools.${NC}"
echo ""
