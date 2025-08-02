#!/bin/bash

# System Setup Module
# Handles system updates, RPM Fusion, and basic system configuration

setup_system() {
    log "Setting up system updates and RPM Fusion repositories..."
    
    # Update system
    log "Updating system packages..."
    sudo dnf update -y
    
    # Enable RPM Fusion repositories
    log "Enabling RPM Fusion repositories..."
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    
    # Update package cache
    sudo dnf update -y
    
    # Install essential packages
    log "Installing essential packages..."
    sudo dnf install -y \
        curl \
        wget \
        vim \
        nano \
        htop \
        neofetch \
        tree \
        unzip \
        zip \
        p7zip \
        p7zip-plugins \
        unrar \
        git \
        gcc \
        g++ \
        make \
        cmake \
        build-essential \
        kernel-devel \
        dkms
    
    # Install Fedora workstation repositories
    sudo dnf install -y fedora-workstation-repositories
    
    log "System setup completed!"
}


setup_flatpak_repos() {
    log "Setting up Flatpak and additional repositories..."
    
    # Install Flatpak (usually pre-installed on Fedora Workstation)
    sudo dnf install -y flatpak
    
    # Add Flathub repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    
    # Enable Terra repositories for additional packages
    sudo dnf copr enable -y terra/release
    
    log "Flatpak and additional repositories setup completed!"
}
