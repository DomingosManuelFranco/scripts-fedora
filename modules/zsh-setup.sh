#!/bin/bash

# Zsh Shell Setup Module
# Installs and configures Zsh with Oh My Zsh and plugins

setup_zsh() {
    log "Setting up Zsh shell with Oh My Zsh..."
    
    # Install Zsh
    log "Installing Zsh..."
    sudo dnf install -y zsh
    
    # Install Oh My Zsh
    log "Installing Oh My Zsh..."
    if [ -d "$HOME/.oh-my-zsh" ]; then
        warn "Oh My Zsh is already installed. Skipping."
    else
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install Zsh plugins
    log "Installing Zsh plugins..."
    ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    
    # zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    fi
    
    # zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    fi
    
    # zsh-completions
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-completions" ]; then
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
    fi
    
    # Install Powerlevel10k theme
    log "Installing Powerlevel10k theme..."
    if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
    fi
    
    # Create .zshrc configuration
    log "Configuring .zshrc..."
    cat > ~/.zshrc << 'EOF'
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    docker
    docker-compose
    npm
    yarn
    node
    nvm
    flutter
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export EDITOR='code'

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load NVM if available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
    
    # Change default shell to Zsh
    if [ "$SHELL" != "/bin/zsh" ]; then
        log "Changing default shell to Zsh..."
        sudo chsh -s $(which zsh) $USER
    fi
    
    log "Zsh setup completed!"
    log "Please log out and log back in for the shell change to take effect."
    log "After that, run 'p10k configure' to set up your Powerlevel10k theme."
}
