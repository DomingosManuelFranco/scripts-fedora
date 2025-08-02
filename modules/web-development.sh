#!/bin/bash

# Web Development Module
# Installs tools for web development

setup_web_development() {
    log "Setting up web development environment..."
    
    # Install Node.js using nvm (Node Version Manager)
    log "Installing nvm (Node Version Manager)..."
    if ! curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash; then
        error "Failed to install nvm."
        return 1
    fi

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # Add nvm to shell profiles
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
    if [ -f ~/.zshrc ]; then
        echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
    fi

    log "Installing latest LTS version of Node.js..."
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'

    # Verify installation
    log "Node.js version: $(node -v)"
    log "npm version: $(npm -v)"

    # Install pnpm
    log "Installing pnpm..."
    npm install -g pnpm

    # Install Yarn
    log "Installing Yarn..."
    npm install -g yarn

    # Install Bun
    log "Installing Bun..."
    npm install -g bun

    # Install essential global npm packages
    log "Installing essential global npm packages..."
    npm install -g \
        typescript \
        ts-node \
        nodemon \
        pm2 \
        vite \
        netlify-cli \
        vercel

    # Install VS Code
    log "Installing Visual Studio Code..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf install -y code
    
    log "VS Code installed. For extensions, consider installing extension packs from the marketplace."
    log "Recommended extension packs: 'Angular Extension Pack', 'Vue Extension Pack', 'React Extension Pack'"

    # Install Google Chrome
    log "Installing Google Chrome..."
    sudo dnf install -y fedora-workstation-repositories
    sudo dnf config-manager --set-enabled google-chrome
    sudo dnf install -y google-chrome-stable

    log "Web development environment setup completed!"
    log "Please restart your terminal or run 'source ~/.bashrc' to use nvm."
}
