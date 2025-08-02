#!/bin/bash

# Quick installer for Fedora Developer Setup
# This script can be run directly from the web

set -e

REPO_URL="https://github.com/woodzo/scripts-fedora.git"
INSTALL_DIR="$HOME/fedora-dev-setup"

echo "🚀 Fedora Developer Setup - Quick Installer"
echo "========================================="

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    sudo dnf install -y git
fi

# Clone or update repository
if [ -d "$INSTALL_DIR" ]; then
    echo "📦 Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull
else
    echo "📦 Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# Make scripts executable
chmod +x setup-fedora.sh
chmod +x modules/*.sh

echo "✅ Setup complete! Running the main installer..."
echo ""

# Run the main setup script
./setup-fedora.sh
