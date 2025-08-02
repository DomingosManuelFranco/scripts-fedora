#!/bin/bash

# Theming and Fonts Module
# Installs fonts, themes, and visual customizations

setup_theming_fonts() {
    log "Setting up fonts and theming..."
    
    # Install essential fonts
    log "Installing fonts..."
    sudo dnf install -y \
        google-roboto-fonts \
        google-roboto-mono-fonts \
        google-roboto-slab-fonts \
        google-noto-fonts \
        google-noto-color-emoji-fonts \
        liberation-fonts \
        dejavu-sans-fonts \
        dejavu-serif-fonts \
        dejavu-sans-mono-fonts \
        fontconfig
    
    # Install FiraCode Nerd Font for terminal and coding
    log "Installing FiraCode Nerd Font..."
    mkdir -p ~/.local/share/fonts
    cd /tmp
    
    # Download and install FiraCode Nerd Font
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
    unzip FiraCode.zip -d FiraCode
    cp FiraCode/*.ttf ~/.local/share/fonts/
    
    # Download and install other popular programming fonts
    log "Installing additional programming fonts..."
    
    # JetBrains Mono Nerd Font
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip JetBrainsMono.zip -d JetBrainsMono
    cp JetBrainsMono/*.ttf ~/.local/share/fonts/
    
    # Hack Nerd Font
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
    unzip Hack.zip -d Hack
    cp Hack/*.ttf ~/.local/share/fonts/
    
    # Source Code Pro
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip
    unzip SourceCodePro.zip -d SourceCodePro
    cp SourceCodePro/*.ttf ~/.local/share/fonts/
    
    # Refresh font cache
    fc-cache -fv
    
    # Install themes and icons for different desktop environments
    log "Installing themes and icons..."
    
    # For GNOME
    if command -v gnome-shell &> /dev/null; then
        log "Setting up GNOME themes..."
        sudo dnf install -y \
            gnome-tweaks \
            gnome-extensions-app \
            gnome-shell-extension-user-theme \
            gnome-shell-extension-dash-to-dock \
            gnome-shell-extension-appindicator
        
        # Install Orchis theme
        cd /tmp
        if git clone https://github.com/vinceliuice/Orchis-theme.git 2>/dev/null; then
            cd Orchis-theme
            ./install.sh || warn "Failed to install Orchis theme"
        else
            warn "Failed to download Orchis theme"
        fi
        
        # Install Tela icon theme
        cd /tmp
        if git clone https://github.com/vinceliuice/Tela-icon-theme.git 2>/dev/null; then
            cd Tela-icon-theme
            ./install.sh || warn "Failed to install Tela icon theme"
        else
            warn "Failed to download Tela icon theme"
        fi
    fi
    
    # For KDE Plasma
    if command -v plasmashell &> /dev/null; then
        log "Setting up KDE Plasma themes..."
        
        # Install Kvantum theme engine
        sudo dnf install -y kvantum
        
        # Install Orchis KDE theme
        cd /tmp
        if git clone https://github.com/vinceliuice/Orchis-kde.git 2>/dev/null; then
            cd Orchis-kde
            ./install.sh || warn "Failed to install Orchis KDE theme"
        else
            warn "Failed to download Orchis KDE theme"
        fi
        
        # Install Tela icon theme for KDE
        cd /tmp
        if git clone https://github.com/vinceliuice/Tela-icon-theme.git 2>/dev/null; then
            cd Tela-icon-theme
            ./install.sh || warn "Failed to install Tela icon theme for KDE"
        else
            warn "Failed to download Tela icon theme for KDE"
        fi
        
        log "KDE themes installed. Use System Settings > Appearance to apply them."
    fi
    
    # Install Starship prompt (cross-shell)
    log "Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
    
    # Create starship config
    mkdir -p ~/.config
    cat > ~/.config/starship.toml << 'EOF'
# Starship configuration
format = """
[┌───────────────────────────────────────────────────────────────────────](bold green)
[│](bold green)$os$username$hostname$directory$git_branch$git_status$python$nodejs$rust$golang$php$java$docker_context
[└─](bold green)$character"""

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[➜](bold red)"

[username]
show_always = true
style_user = "bg:blue"
style_root = "bg:red"
format = '[$user]($style) '

[hostname]
ssh_only = false
format = 'on [$hostname](bold yellow) '

[directory]
style = "blue"
format = "in [$path]($style) "
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = " "
format = "[$symbol$branch]($style) "
style = "bright-black"

[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "cyan"

[nodejs]
symbol = " "
format = "[$symbol($version )]($style)"

[python]
symbol = " "
format = "[$symbol($version )]($style)"

[rust]
symbol = " "
format = "[$symbol($version )]($style)"

[golang]
symbol = " "
format = "[$symbol($version )]($style)"

[php]
symbol = " "
format = "[$symbol($version )]($style)"

[java]
symbol = " "
format = "[$symbol($version )]($style)"

[docker_context]
symbol = " "
format = "[$symbol$context]($style) "
EOF
    
    # Install additional visual tools
    log "Installing additional visual tools..."
    sudo dnf install -y \
        neofetch \
        htop \
        btop \
        cmatrix \
        figlet \
        lolcat \
        fortune-mod \
        cowsay
    
    # Install terminal emulators
    log "Installing modern terminal emulators..."
    sudo dnf install -y \
        alacritty \
        kitty \
        tilix
    
    # Create Alacritty config
    mkdir -p ~/.config/alacritty
    cat > ~/.config/alacritty/alacritty.yml << 'EOF'
# Alacritty configuration
window:
  padding:
    x: 10
    y: 10
  decorations: full
  startup_mode: Windowed

scrolling:
  history: 10000
  multiplier: 3

font:
  normal:
    family: FiraCode Nerd Font
    style: Regular
  bold:
    family: FiraCode Nerd Font
    style: Bold
  italic:
    family: FiraCode Nerd Font
    style: Italic
  size: 12.0

colors:
  primary:
    background: '#1e1e1e'
    foreground: '#d4d4d4'
  normal:
    black:   '#000000'
    red:     '#cd3131'
    green:   '#0dbc79'
    yellow:  '#e5e510'
    blue:    '#2472c8'
    magenta: '#bc3fbc'
    cyan:    '#11a8cd'
    white:   '#e5e5e5'
  bright:
    black:   '#666666'
    red:     '#f14c4c'
    green:   '#23d18b'
    yellow:  '#f5f543'
    blue:    '#3b8eea'
    magenta: '#d670d6'
    cyan:    '#29b8db'
    white:   '#e5e5e5'

cursor:
  style:
    shape: Block
    blinking: On

selection:
  save_to_clipboard: true
EOF
    
    log "Fonts and theming setup completed!"
    log "Available fonts: FiraCode Nerd Font, JetBrains Mono, Hack Nerd Font, Source Code Pro"
    log "Terminal emulators installed: Alacritty, Kitty, Tilix"
    log "Starship prompt installed - add 'eval \"\$(starship init bash)\"' to your shell rc file if not using Zsh"
}
