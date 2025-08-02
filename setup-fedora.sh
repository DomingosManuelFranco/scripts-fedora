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
║                  Fedora Developer Setup                     ║
║                Web & Mobile Development                      ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source other setup modules
source "$SCRIPT_DIR/modules/system-setup.sh"
source "$SCRIPT_DIR/modules/development-tools.sh"
source "$SCRIPT_DIR/modules/web-development.sh"
source "$SCRIPT_DIR/modules/mobile-development.sh"
source "$SCRIPT_DIR/modules/theming-fonts.sh"
source "$SCRIPT_DIR/modules/zsh-setup.sh"

# Main setup function
main() {
    log "Starting Fedora Developer Setup..."
    
    # Ask user what to install
    echo "What would you like to set up? (Enter comma-separated numbers)"
    echo "1. System Updates & RPM Fusion"
    echo "2. Multimedia Codecs"
    echo "3. Development Tools (Git, Docker, etc.)"
    echo "4. Web Development (Node.js, VS Code, etc.)"
    echo "5. Mobile Development (Android Studio, Flutter, etc.)"
    echo "6. Zsh Shell Setup with Oh My Zsh"
    echo "7. Fonts & Theming (FiraCode, KDE themes, etc.)"
    echo "8. Flatpak & Additional Repositories"
    echo "9. All of the above"
    
    read -p "Your choice: " choices
    
    # Convert to array
    IFS=',' read -ra ADDR <<< "$choices"
    
    for choice in "${ADDR[@]}"; do
        case $choice in
            1|9) setup_system ;;
            2|9) setup_multimedia ;;
            3|9) setup_development_tools ;;
            4|9) setup_web_development ;;
            5|9) setup_mobile_development ;;
            6|9) setup_zsh ;;
            7|9) setup_theming_fonts ;;
            8|9) setup_flatpak_repos ;;
        esac
    done
    
    log "Setup completed! Please reboot your system to ensure all changes take effect."
    log "After reboot, you may need to:"
    log "- Configure your development tools"
    log "- Set up your Git credentials"
    log "- Install additional extensions for your editors"
    log "- Configure your shell preferences"
}

# Run main function
main "$@"
