#!/bin/bash

# Test script to verify the Fedora setup
# Run this after the main setup to check if everything is working

echo "🔍 Fedora Developer Setup - Verification Test"
echo "============================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✅ $1 is installed${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 is NOT installed${NC}"
        return 1
    fi
}

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅ $1 exists${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 does NOT exist${NC}"
        return 1
    fi
}

echo "Checking development tools..."
check_command git
check_command docker
check_command lazydocker
check_command ctop
check_command node
check_command npm
check_command yarn
check_command pnpm
check_command code
check_command zsh
check_command kubectl
check_command terraform
check_command aws
check_command az
check_command gcloud

echo ""
echo "Checking Docker services..."
if docker ps &> /dev/null; then
    echo -e "${GREEN}✅ Docker is running${NC}"
    if docker ps | grep -q portainer; then
        echo -e "${GREEN}✅ Portainer is running${NC}"
    else
        echo -e "${YELLOW}⚠️  Portainer is not running${NC}"
    fi
else
    echo -e "${RED}❌ Docker is NOT running${NC}"
fi

echo ""
echo "Checking mobile development tools..."
check_command java
check_command flutter
check_command appium
check_command fastlane
if [ -d "$HOME/Android/Sdk" ]; then
    echo -e "${GREEN}✅ Android SDK directory exists${NC}"
else
    echo -e "${RED}❌ Android SDK directory NOT found${NC}"
fi

echo ""
echo "Checking web development tools..."
check_command lighthouse
check_command cypress
if command -v google-chrome &> /dev/null; then
    echo -e "${GREEN}✅ Google Chrome is installed${NC}"
else
    echo -e "${RED}❌ Google Chrome is NOT installed${NC}"
fi
if command -v brave-browser &> /dev/null; then
    echo -e "${GREEN}✅ Brave Browser is installed${NC}"
else
    echo -e "${RED}❌ Brave Browser is NOT installed${NC}"
fi

echo ""
echo "Checking fonts..."
if fc-list | grep -i "firacode" > /dev/null; then
    echo -e "${GREEN}✅ FiraCode font is installed${NC}"
else
    echo -e "${RED}❌ FiraCode font is NOT installed${NC}"
fi

echo ""
echo "Checking shell configuration..."
check_file "$HOME/.zshrc"
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${GREEN}✅ Oh My Zsh is installed${NC}"
else
    echo -e "${RED}❌ Oh My Zsh is NOT installed${NC}"
fi

echo ""
echo "Checking VS Code extensions..."
if code --list-extensions | grep -q "ms-vscode.vscode-typescript"; then
    echo -e "${GREEN}✅ VS Code TypeScript extension installed${NC}"
else
    echo -e "${YELLOW}⚠️  VS Code TypeScript extension not found${NC}"
fi
if code --list-extensions | grep -q "ms-vscode.vscode-docker"; then
    echo -e "${GREEN}✅ VS Code Docker extension installed${NC}"
else
    echo -e "${YELLOW}⚠️  VS Code Docker extension not found${NC}"
fi
if code --list-extensions | grep -q "github.copilot"; then
    echo -e "${GREEN}✅ GitHub Copilot extension installed${NC}"
else
    echo -e "${YELLOW}⚠️  GitHub Copilot extension not found${NC}"
fi

echo ""
echo "Checking GUI applications..."
if flatpak list | grep -q "DBeaver"; then
    echo -e "${GREEN}✅ DBeaver is installed${NC}"
else
    echo -e "${YELLOW}⚠️  DBeaver is not installed${NC}"
fi
if flatpak list | grep -q "Postman"; then
    echo -e "${GREEN}✅ Postman is installed${NC}"
else
    echo -e "${YELLOW}⚠️  Postman is not installed${NC}"
fi

echo ""
echo "System information:"
echo "OS: $(cat /etc/fedora-release)"
echo "Kernel: $(uname -r)"
echo "Shell: $SHELL"
if command -v node &> /dev/null; then
    echo "Node.js: $(node --version)"
fi
if command -v npm &> /dev/null; then
    echo "npm: $(npm --version)"
fi
if command -v docker &> /dev/null; then
    echo "Docker: $(docker --version)"
fi

echo ""
echo "🏁 Verification complete!"
echo "If you see any ❌ marks, you may need to:"
echo "- Restart your terminal or log out/in"
echo "- Run 'source ~/.bashrc' or 'source ~/.zshrc'"
echo "- Reboot your system for some changes to take effect"
