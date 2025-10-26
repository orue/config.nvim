#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Neovim Dependencies Installation Script"
echo "=========================================="
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo -e "${RED}Error: This script is designed for macOS only${NC}"
  exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo -e "${RED}Error: Homebrew is not installed${NC}"
  echo "Please install Homebrew first: https://brew.sh"
  exit 1
fi

echo -e "${GREEN}✓${NC} Homebrew is installed"
echo ""

# Check if npm is installed
if ! command -v npm &> /dev/null; then
  echo -e "${YELLOW}Warning: npm is not installed${NC}"
  echo "Installing Node.js via Homebrew..."
  brew install node
fi

echo -e "${GREEN}✓${NC} npm is available"
echo ""

# Function to check if a brew package is installed
is_brew_installed() {
  brew list "$1" &> /dev/null
}

# Function to check if an npm package is installed globally
is_npm_installed() {
  npm list -g "$1" &> /dev/null
}

echo "=========================================="
echo "Installing Homebrew Packages"
echo "=========================================="
echo ""

# Array of brew packages
declare -a brew_packages=(
  "lua-language-server"
  "gopls"
  "pyright"
  "ruff"
  "marksman"
  "dockerfile-language-server"
  "bash-language-server"
  "taplo"
  "yaml-language-server"
  "terraform-ls"
  "delve"
  "ripgrep"
  "lazygit"
  "make"
)

# Install brew packages
for package in "${brew_packages[@]}"; do
  if is_brew_installed "$package"; then
    echo -e "${GREEN}✓${NC} $package (already installed)"
  else
    echo -e "${YELLOW}→${NC} Installing $package..."
    brew install "$package"
    echo -e "${GREEN}✓${NC} $package installed"
  fi
done

echo ""
echo "=========================================="
echo "Installing NPM Packages"
echo "=========================================="
echo ""

# Array of npm packages
declare -a npm_packages=(
  "prettier"
)

# Install npm packages
for package in "${npm_packages[@]}"; do
  if is_npm_installed "$package"; then
    echo -e "${GREEN}✓${NC} $package (already installed)"
  else
    echo -e "${YELLOW}→${NC} Installing $package globally..."
    npm install -g "$package"
    echo -e "${GREEN}✓${NC} $package installed"
  fi
done

echo ""
echo "=========================================="
echo "Python Dependencies"
echo "=========================================="
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
  echo -e "${RED}Error: python3 is not installed${NC}"
  echo "Installing Python via Homebrew..."
  brew install python3
fi

echo -e "${GREEN}✓${NC} Python3 is available"
echo ""

# Array of Python packages
declare -a python_packages=(
  "debugpy"
  "pytest"
)

echo "Python packages needed: ${python_packages[*]}"
echo ""
echo -e "${YELLOW}Note:${NC} Python packages should be installed in your virtual environment"
echo "or globally using pip/pipx depending on your preference."
echo ""
echo "Would you like to install them globally now? (y/n)"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
  for package in "${python_packages[@]}"; do
    if python3 -m pip show "$package" &> /dev/null; then
      echo -e "${GREEN}✓${NC} $package (already installed)"
    else
      echo -e "${YELLOW}→${NC} Installing $package..."
      python3 -m pip install --user "$package"
      echo -e "${GREEN}✓${NC} $package installed"
    fi
  done
else
  echo ""
  echo "Skipping Python packages. Install them later with:"
  echo "  pip install ${python_packages[*]}"
  echo ""
fi

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "All dependencies have been installed."
echo ""
echo "Summary:"
echo "  - Language Servers: 10"
echo "  - Formatters: 1 (prettier)"
echo "  - Debuggers: 2 (delve, debugpy)"
echo "  - Search Tools: 1 (ripgrep)"
echo "  - Git Tools: 1 (lazygit)"
echo "  - Test Runners: 1 (pytest)"
echo "  - Build Tools: 1 (make)"
echo ""
echo -e "${GREEN}You're all set! Restart Neovim to use the new tools.${NC}"
echo ""
