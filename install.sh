#!/bin/bash

# Direct installer for Fedora Developer Setup
# Downloads and runs the setup without requiring Git authentication

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_OWNER="DomingosManuelFranco"
REPO_NAME="scripts-fedora"
INSTALL_DIR="$HOME/fedora-dev-setup"

echo -e "${BLUE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                  Fedora Developer Setup                     ║
║                   Direct Installer                          ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${GREEN}🚀 Downloading Fedora Developer Setup...${NC}"

# Create installation directory
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Download the repository as a ZIP file (no authentication required)
echo -e "${GREEN}📦 Downloading from GitHub...${NC}"
curl -L "https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip" -o setup.zip

# Extract the files
echo -e "${GREEN}📁 Extracting files...${NC}"
unzip -q setup.zip
mv "$REPO_NAME-main"/* .
mv "$REPO_NAME-main"/.* . 2>/dev/null || true
rmdir "$REPO_NAME-main"
rm setup.zip

# Make scripts executable
chmod +x setup-fedora.sh
chmod +x modules/*.sh
chmod +x verify-setup.sh

echo -e "${GREEN}✅ Download complete!${NC}"
echo -e "${YELLOW}📂 Files extracted to: $INSTALL_DIR${NC}"
echo ""
echo -e "${GREEN}🚀 Starting the setup...${NC}"
echo ""

# Run the main setup script
./setup-fedora.sh
