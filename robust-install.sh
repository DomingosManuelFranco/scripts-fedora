#!/bin/bash

# Fedora Developer Setup - Error-Resistant Installer
# This version handles authentication issues and provides fallbacks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Repository information
REPO_OWNER="DomingosManuelFranco"
REPO_NAME="scripts-fedora"
INSTALL_DIR="$HOME/fedora-dev-setup"

# Logging functions
log() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# Check internet connectivity
check_internet() {
    if ! ping -c 1 google.com &>/dev/null; then
        error "No internet connection detected. Please check your network and try again."
        exit 1
    fi
}

# Clean Git credentials to avoid authentication issues
clean_git_auth() {
    log "Cleaning Git credentials to avoid authentication issues..."
    
    # Remove any cached credentials
    git config --global --unset credential.helper 2>/dev/null || true
    
    # Configure Git to not use credential helpers for public repos
    git config --global credential.helper ""
    
    # Set Git to use HTTPS instead of SSH for GitHub
    git config --global url."https://github.com/".insteadOf git@github.com:
    git config --global url."https://".insteadOf git://
}

# Test if we can access GitHub
test_github_access() {
    log "Testing GitHub access..."
    
    if curl -s --max-time 10 https://api.github.com/repos/$REPO_OWNER/$REPO_NAME >/dev/null 2>&1; then
        log "✅ GitHub access confirmed"
        return 0
    else
        warn "⚠️ Cannot access GitHub API, but continuing..."
        return 1
    fi
}

# Download method 1: Direct ZIP download (no Git required)
download_zip() {
    log "📦 Downloading repository as ZIP file..."
    
    local zip_url="https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip"
    
    if curl -L --fail --max-time 30 "$zip_url" -o setup.zip; then
        log "✅ ZIP download successful"
        
        # Extract files
        if command -v unzip >/dev/null 2>&1; then
            unzip -q setup.zip
            mv "$REPO_NAME-main"/* . 2>/dev/null || true
            mv "$REPO_NAME-main"/.* . 2>/dev/null || true
            rmdir "$REPO_NAME-main" 2>/dev/null || true
            rm setup.zip
            return 0
        else
            error "unzip command not found. Installing..."
            sudo dnf install -y unzip
            return 1
        fi
    else
        error "Failed to download ZIP file"
        return 1
    fi
}

# Download method 2: Git clone with error handling
download_git() {
    log "📦 Attempting Git clone..."
    
    # Clean any existing authentication issues
    clean_git_auth
    
    local repo_url="https://github.com/$REPO_OWNER/$REPO_NAME.git"
    
    if git clone "$repo_url" temp_clone 2>/dev/null; then
        log "✅ Git clone successful"
        mv temp_clone/* . 2>/dev/null || true
        mv temp_clone/.* . 2>/dev/null || true
        rmdir temp_clone 2>/dev/null || true
        return 0
    else
        error "Git clone failed"
        return 1
    fi
}

# Download method 3: Raw file download
download_raw_files() {
    log "📦 Downloading individual files from GitHub..."
    
    local base_url="https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main"
    
    # Create directory structure
    mkdir -p modules
    
    # Download main files
    local files=(
        "setup-fedora.sh"
        "verify-setup.sh"
        "modules/system-setup.sh"
        "modules/development-tools.sh"
        "modules/web-development.sh"
        "modules/mobile-development.sh"
        "modules/zsh-setup.sh"
        "modules/theming-fonts.sh"
        "README.md"
    )
    
    local success=true
    for file in "${files[@]}"; do
        log "Downloading $file..."
        if ! curl -L --fail --max-time 15 "$base_url/$file" -o "$file"; then
            error "Failed to download $file"
            success=false
        fi
    done
    
    if $success; then
        log "✅ Raw file download successful"
        return 0
    else
        return 1
    fi
}

# Main installation function
main() {
    echo -e "${BLUE}"
    cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║              Fedora Developer Setup Installer               ║
║                   Error-Resistant Version                   ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    # Check prerequisites
    check_internet
    
    # Install required tools
    log "Installing required tools..."
    sudo dnf install -y curl wget unzip git 2>/dev/null || {
        error "Failed to install prerequisites"
        exit 1
    }
    
    # Create and enter installation directory
    mkdir -p "$INSTALL_DIR"
    cd "$INSTALL_DIR"
    
    # Clean any existing files
    rm -rf * .* 2>/dev/null || true
    
    # Test GitHub access
    test_github_access
    
    # Try different download methods
    log "Attempting to download setup files..."
    
    if download_zip; then
        log "✅ Download completed using ZIP method"
    elif download_git; then
        log "✅ Download completed using Git method"
    elif download_raw_files; then
        log "✅ Download completed using raw file method"
    else
        error "All download methods failed. Please check:"
        error "1. Your internet connection"
        error "2. GitHub repository accessibility"
        error "3. Firewall settings"
        exit 1
    fi
    
    # Make scripts executable
    log "Making scripts executable..."
    chmod +x setup-fedora.sh 2>/dev/null || warn "Could not make setup-fedora.sh executable"
    chmod +x modules/*.sh 2>/dev/null || warn "Could not make module scripts executable"
    chmod +x verify-setup.sh 2>/dev/null || warn "Could not make verify-setup.sh executable"
    
    # Verify main script exists
    if [[ ! -f "setup-fedora.sh" ]]; then
        error "Main setup script not found. Download may have failed."
        exit 1
    fi
    
    log "✅ Setup files ready!"
    echo -e "${YELLOW}📂 Files installed to: $INSTALL_DIR${NC}"
    echo ""
    log "🚀 Starting the main setup..."
    echo ""
    
    # Run the main setup script
    bash ./setup-fedora.sh
}

# Handle interruption gracefully
trap 'error "Installation interrupted by user"; exit 130' INT

# Run main function
main "$@"
