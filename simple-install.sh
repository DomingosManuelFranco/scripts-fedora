#!/bin/bash

# Fedora Developer Setup - Simple Installer
# Minimal version focused on reliability

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Repository info
REPO_OWNER="DomingosManuelFranco"
REPO_NAME="scripts-fedora"
INSTALL_DIR="$HOME/fedora-dev-setup"

# Simple logging
log() { echo -e "${GREEN}[INFO] $1${NC}"; }
error() { echo -e "${RED}[ERROR] $1${NC}"; }
warn() { echo -e "${YELLOW}[WARN] $1${NC}"; }

echo -e "${BLUE}"
echo "╔════════════════════════════════════════╗"
echo "║      Fedora Developer Setup           ║"
echo "║        Simple Installer               ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

# Install prerequisites quietly
log "Installing prerequisites..."
sudo dnf install -y curl wget unzip &>/dev/null || {
    error "Failed to install prerequisites"
    exit 1
}

# Create directory
log "Creating installation directory..."
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Clean existing files
rm -rf * .* 2>/dev/null || true

# Download using the most reliable method
log "Downloading setup files..."
ZIP_URL="https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip"

if curl -L --fail --max-time 60 "$ZIP_URL" -o setup.zip; then
    log "✅ Download successful"
    
    # Extract
    log "Extracting files..."
    unzip -q setup.zip
    mv "$REPO_NAME-main"/* . 2>/dev/null || true
    mv "$REPO_NAME-main"/.* . 2>/dev/null || true
    rmdir "$REPO_NAME-main" 2>/dev/null || true
    rm setup.zip
    
    # Make executable
    log "Setting permissions..."
    chmod +x setup-fedora.sh modules/*.sh verify-setup.sh 2>/dev/null || true
    
    # Verify main script
    if [[ -f "setup-fedora.sh" ]]; then
        log "✅ Installation complete!"
        echo -e "${YELLOW}📂 Files installed to: $INSTALL_DIR${NC}"
        echo ""
        log "🚀 Starting setup..."
        echo ""
        
        # Run setup
        bash ./setup-fedora.sh
    else
        error "Main setup script not found after extraction"
        exit 1
    fi
else
    error "Download failed. Please check:"
    error "1. Internet connection"
    error "2. GitHub access: curl -I https://github.com"
    error "3. Try manual download: https://github.com/$REPO_OWNER/$REPO_NAME"
    exit 1
fi
