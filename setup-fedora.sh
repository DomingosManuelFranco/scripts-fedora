#!/bin/bash

# Fedora Developer Setup Script
# Automated setup for web and mobile development environment
# Author: woodzo
# Date: $(date +%Y-%m-%d)

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   error "This script should not be run as root"
fi

# Welcome message
echo -e "${BLUE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                  Fedora Developer Setup                      ║
║                Web & Mobile Development                      ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Main setup function
main() {
    log "Starting Fedora Developer Setup..."
    
    echo "What would you like to set up? (Enter comma-separated numbers)"
    echo "1. System Updates & RPM Fusion"
    echo "2. Development Tools (Git, Docker, etc.)"
    echo "3. Web Development (Node.js, VS Code, etc.)"
    echo "4. Mobile Development (Android Studio, Flutter, etc.)"
    echo "5. Zsh Shell Setup with Oh My Zsh"
    echo "6. Fonts & Theming (FiraCode, KDE themes, etc.)"
    echo "7. Flatpak & Additional Repositories"
    echo "8. All of the above"

    read -p "Your choice: " choices

    # Convert to array
    IFS=',' read -ra ADDR <<< "$choices"

    # Helper function to source modules safely
    source_module() {
        local module_name="$1"
        local module_path="$SCRIPT_DIR/modules/$module_name"
        if [ -f "$module_path" ]; then
            # shellcheck source=/dev/null
            source "$module_path"
        else
            error "Module file not found: $module_path"
        fi
    }

    # Handle "All" choice
    if [[ " ${ADDR[@]} " =~ " 8 " ]]; then
        source_module "system-setup.sh"
        setup_system
        setup_flatpak_repos
        source_module "development-tools.sh"
        setup_development_tools
        source_module "web-development.sh"
        setup_web_development
        source_module "mobile-development.sh"
        setup_mobile_development
        source_module "zsh-setup.sh"
        setup_zsh
        source_module "theming-fonts.sh"
        setup_theming_fonts
    else
        for choice in "${ADDR[@]}"; do
            case $choice in
                1) source_module "system-setup.sh"; setup_system ;;
                2) source_module "development-tools.sh"; setup_development_tools ;;
                3) source_module "web-development.sh"; setup_web_development ;;
                4) source_module "mobile-development.sh"; setup_mobile_development ;;
                5) source_module "zsh-setup.sh"; setup_zsh ;;
                6) source_module "theming-fonts.sh"; setup_theming_fonts ;;
                7) source_module "system-setup.sh"; setup_flatpak_repos ;;
                *) warn "Invalid choice: $choice. Skipping." ;;
            esac
        done
    fi
    
    log "Setup completed! Please reboot your system to ensure all changes take effect."
    log "After reboot, you may need to:"
    log "- Configure your development tools"
    log "- Set up your Git credentials"
    log "- Install additional extensions for your editors"
    log "- Configure your shell preferences"
}

# Run main function
main "$@"
