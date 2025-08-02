#!/bin/bash

# Development Tools Module
# Installs essential development tools

setup_development_tools() {
    log "Setting up development tools..."
    
    # Install Git and configure
    log "Installing and configuring Git..."
    sudo dnf install -y git git-lfs
    
    # Ask for Git configuration
    read -p "Enter your Git username: " git_username
    read -p "Enter your Git email: " git_email
    
    if [[ -n "$git_username" && -n "$git_email" ]]; then
        git config --global user.name "$git_username"
        git config --global user.email "$git_email"
        git config --global init.defaultBranch main
        git config --global core.editor "code --wait"
        log "Git configured successfully!"
    fi
    
    # Install Docker
    log "Installing Docker..."
    sudo dnf remove -y docker \
                      docker-client \
                      docker-client-latest \
                      docker-common \
                      docker-latest \
                      docker-latest-logrotate \
                      docker-logrotate \
                      docker-selinux \
                      docker-engine-selinux \
                      docker-engine
    
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    # Start and enable Docker
    sudo systemctl start docker
    sudo systemctl enable docker
    
    # Add user to docker group
    sudo usermod -aG docker $USER
    
    # Install Docker Compose (standalone)
    log "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
    # Install development databases
    log "Installing database tools..."
    sudo dnf install -y \
        postgresql \
        postgresql-server \
        postgresql-contrib \
        mysql-server \
        redis \
        sqlite
    
    # Install Docker management tools
    log "Installing Docker management and container tools..."
    
    # Install Portainer (Docker GUI)
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v portainer_data:/data \
        portainer/portainer-ce:latest || log "Portainer will be available after reboot"
    
    # Install Lazydocker (Terminal UI for Docker)
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    
    # Install ctop (Container monitoring)
    sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
    sudo chmod +x /usr/local/bin/ctop
    
    # Install dive (Docker image layer analyzer)
    wget https://github.com/wagoodman/dive/releases/download/v0.10.0/dive_0.10.0_linux_amd64.rpm
    sudo dnf install -y dive_0.10.0_linux_amd64.rpm
    rm dive_0.10.0_linux_amd64.rpm
    
    # Install development databases with GUI tools
    log "Installing database tools with GUI clients..."
    sudo dnf install -y \
        postgresql \
        postgresql-server \
        postgresql-contrib \
        mysql-server \
        mysql-workbench-community \
        redis \
        sqlite \
        sqlite-browser
    
    # Install DBeaver (Universal database tool) via Flatpak
    flatpak install -y flathub io.dbeaver.DBeaverCommunity
    
    # Install other essential development tools
    log "Installing additional development tools..."
    sudo dnf install -y \
        jq \
        yq \
        httpie \
        curl \
        wget \
        aria2 \
        wireshark \
        nmap \
        telnet \
        nc \
        netcat \
        tmux \
        screen \
        fzf \
        ripgrep \
        fd-find \
        bat \
        exa \
        tree \
        htop \
        btop \
        iotop \
        stress \
        stress-ng \
        neovim \
        vim \
        emacs \
        micro \
        ranger \
        mc \
        ncdu \
        duf \
        procs \
        bandwhich
    
    # Install API development tools
    log "Installing API development and testing tools..."
    
    # Install Postman via Flatpak
    flatpak install -y flathub com.getpostman.Postman
    
    # Install Insomnia via Flatpak
    flatpak install -y flathub rest.insomnia.Insomnia
    
    # Install HTTPie Desktop
    flatpak install -y flathub com.httpie.Httpie
    
    # Install version control tools
    log "Installing version control and collaboration tools..."
    sudo dnf install -y \
        git-gui \
        gitk \
        git-cola \
        meld \
        kdiff3 \
        beyond-compare
    
    # Install GitKraken via Flatpak
    flatpak install -y flathub com.axosoft.GitKraken
    
    # Install GitHub Desktop via Flatpak
    flatpak install -y flathub io.github.shiftey.Desktop
    
    # Install monitoring and system tools
    log "Installing system monitoring and performance tools..."
    sudo dnf install -y \
        glances \
        gotop \
        nmon \
        sysstat \
        iftop \
        nethogs \
        tcpdump \
        wireshark-cli \
        traceroute \
        mtr \
        speedtest-cli \
        lsof \
        strace \
        ltrace \
        valgrind \
        gdb \
        lldb
    
    # Install cloud and DevOps tools
    log "Installing cloud and DevOps tools..."
    
    # Install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    
    # Install Helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    
    # Install Terraform
    sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
    sudo dnf install -y terraform
    
    # Install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    
    # Install Azure CLI
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/azure-cli
    sudo dnf install -y azure-cli
    
    # Install Google Cloud CLI
    curl https://packages.cloud.google.com/yum/doc/yum-key.gpg | sudo rpm --import -
    sudo dnf config-manager --add-repo https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
    sudo dnf install -y google-cloud-cli
    
    # Install virtualization tools
    log "Installing virtualization and container tools..."
    sudo dnf install -y \
        qemu-kvm \
        libvirt \
        libvirt-daemon-config-network \
        libvirt-daemon-kvm \
        virt-manager \
        virt-viewer \
        virt-install \
        bridge-utils \
        podman \
        buildah \
        skopeo \
        podman-compose
    
    # Install text editors and IDEs
    log "Installing additional editors and IDEs..."
    
    # Install JetBrains Toolbox
    wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.28.1.15219.tar.gz -O /tmp/jetbrains-toolbox.tar.gz
    tar -xzf /tmp/jetbrains-toolbox.tar.gz -C /tmp
    sudo mv /tmp/jetbrains-toolbox-*/jetbrains-toolbox /usr/local/bin/
    rm -rf /tmp/jetbrains-toolbox*
    
    # Install Zed editor
    curl -f https://zed.dev/install.sh | sh
    
    # Install productivity and documentation tools
    log "Installing documentation and productivity tools..."
    
    # Install Obsidian for note-taking
    flatpak install -y flathub md.obsidian.Obsidian
    
    # Install Notion (unofficial)
    flatpak install -y flathub notion-app-enhanced
    
    # Install Slack
    flatpak install -y flathub com.slack.Slack
    
    # Install Discord
    flatpak install -y flathub com.discordapp.Discord
    
    # Install Zoom
    flatpak install -y flathub us.zoom.Zoom
    
    # Install file managers and utilities
    log "Installing file managers and utilities..."
    sudo dnf install -y \
        nautilus-extensions \
        thunar \
        pcmanfm \
        dolphin \
        krusader \
        filezilla \
        rclone \
        rsync \
        syncthing
    
    # Install Syncthing GUI
    flatpak install -y flathub me.kozec.syncthing-gtk
    
    # Install backup and sync tools
    log "Installing backup and synchronization tools..."
    sudo dnf install -y \
        timeshift \
        borgbackup \
        duplicity \
        rclone
    
    # Install additional package managers
    log "Installing additional package managers..."
    
    # Install Snap (optional)
    sudo dnf install -y snapd
    sudo systemctl enable --now snapd.socket
    sudo ln -sf /var/lib/snapd/snap /snap
    
    # Install AppImage support
    sudo dnf install -y fuse fuse-libs
    wget https://github.com/AppImage/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
    sudo dnf install -y appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
    rm appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
    
    # Install security and penetration testing tools (optional)
    log "Installing security tools..."
    sudo dnf install -y \
        nmap \
        wireshark \
        tcpdump \
        openssl \
        gnupg2 \
        pass \
        keepassxc
    
    # Install KeePassXC via Flatpak for better integration
    flatpak install -y flathub org.keepassxc.KeePassXC
    
    log "Enhanced development tools setup completed!"
    log "🐳 Portainer will be available at https://localhost:9443 after reboot"
    log "📊 Use 'lazydocker' for terminal Docker management"
    log "🔍 Use 'ctop' for container monitoring"
    log "🗄️ DBeaver installed for database management"
    log "☁️ Cloud CLIs installed: AWS, Azure, Google Cloud"
    log "🎯 JetBrains Toolbox installed for IDEs"
}
