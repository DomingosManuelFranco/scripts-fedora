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
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Install Zsh plugins
    log "Installing Zsh plugins..."
    
    # Configure Git to avoid authentication issues
    git config --global credential.helper "" 2>/dev/null || true
    git config --global url."https://github.com/".insteadOf git@github.com: 2>/dev/null || true
    
    # zsh-autosuggestions
    if ! git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null; then
        warn "Failed to install zsh-autosuggestions plugin"
    fi
    
    # zsh-syntax-highlighting
    if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null; then
        warn "Failed to install zsh-syntax-highlighting plugin"
    fi
    
    # zsh-completions
    if ! git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions 2>/dev/null; then
        warn "Failed to install zsh-completions plugin"
    fi
    
    # Install Powerlevel10k theme
    log "Installing Powerlevel10k theme..."
    if ! git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k 2>/dev/null; then
        warn "Failed to install Powerlevel10k theme, using default theme"
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
    android
    vscode
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    history-substring-search
    colored-man-pages
    command-not-found
    extract
    web-search
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export EDITOR='code'

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Docker aliases
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dsp='docker system prune'
alias dcp='docker-compose'

# Development aliases
alias code.='code .'
alias serve='python3 -m http.server'
alias myip='curl http://ipecho.net/plain; echo'

# Node.js/npm aliases
alias ni='npm install'
alias nis='npm install --save'
alias nid='npm install --save-dev'
alias nig='npm install --global'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'

# Custom PATH additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/flutter/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load NVM if available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
    
    # Install NVM (Node Version Manager)
    log "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    
    # Change default shell to Zsh
    log "Changing default shell to Zsh..."
    sudo chsh -s $(which zsh) $USER
    
    log "Zsh setup completed!"
    log "Please log out and log back in (or restart) for the shell change to take effect"
    log "After that, run 'p10k configure' to set up your Powerlevel10k theme"
}
