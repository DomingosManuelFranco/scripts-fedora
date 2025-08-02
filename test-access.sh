#!/bin/bash

# Test GitHub Repository Access
# This script tests if the repository is accessible and provides diagnostics

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_OWNER="DomingosManuelFranco"
REPO_NAME="scripts-fedora"

echo -e "${BLUE}🔍 Testing GitHub Repository Access${NC}"
echo "=================================="

# Test 1: Internet connectivity
echo -n "Testing internet connection... "
if ping -c 1 google.com &>/dev/null; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ FAILED${NC}"
    echo "Please check your internet connection"
    exit 1
fi

# Test 2: GitHub connectivity
echo -n "Testing GitHub connectivity... "
if ping -c 1 github.com &>/dev/null; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ FAILED${NC}"
    echo "Cannot reach GitHub"
    exit 1
fi

# Test 3: Repository API access
echo -n "Testing repository API access... "
if curl -s --max-time 10 "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME" | grep -q '"name"'; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ FAILED${NC}"
    echo "Repository may be private or not exist"
fi

# Test 4: Repository ZIP download
echo -n "Testing ZIP download access... "
if curl -s --max-time 10 -I "https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip" | grep -q "200 OK"; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ FAILED${NC}"
    echo "Cannot download repository ZIP"
fi

# Test 5: Git clone test (without actually cloning)
echo -n "Testing Git clone access... "
if git ls-remote "https://github.com/$REPO_OWNER/$REPO_NAME.git" &>/dev/null; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ FAILED${NC}"
    echo "Git clone would fail - authentication or access issue"
fi

# Test 6: Raw file access
echo -n "Testing raw file access... "
if curl -s --max-time 10 "https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main/README.md" | grep -q "Fedora"; then
    echo -e "${GREEN}✅ OK${NC}"
else
    echo -e "${RED}❌ FAILED${NC}"
    echo "Cannot access raw files"
fi

echo ""
echo -e "${BLUE}Repository Information:${NC}"
echo "Owner: $REPO_OWNER"
echo "Name: $REPO_NAME"
echo "URL: https://github.com/$REPO_OWNER/$REPO_NAME"

echo ""
echo -e "${BLUE}Recommended Installation Commands:${NC}"
echo ""
echo -e "${GREEN}Method 1 (Most Reliable):${NC}"
echo "curl -L https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main/robust-install.sh | bash"
echo ""
echo -e "${GREEN}Method 2 (Direct Download):${NC}"
echo "curl -L https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main/install.sh | bash"
echo ""
echo -e "${GREEN}Method 3 (Git Clone):${NC}"
echo "git clone https://github.com/$REPO_OWNER/$REPO_NAME.git && cd $REPO_NAME && ./setup-fedora.sh"

echo ""
echo -e "${YELLOW}If you see failures above, the repository might be:${NC}"
echo "1. Private (requires authentication)"
echo "2. Not yet pushed to GitHub"
echo "3. Has a different name or owner"
echo "4. Your network blocks GitHub access"
