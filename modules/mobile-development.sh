#!/bin/bash

# Mobile Development Module
# Installs tools for mobile development

setup_mobile_development() {
    log "Setting up mobile development environment..."

    # Install Java Development Kit (required for Android development)
    log "Installing Java Development Kit..."
    sudo dnf install -y java-17-openjdk java-17-openjdk-devel

    # Set JAVA_HOME
    echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk' >> ~/.bashrc
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
    if [ -f ~/.zshrc ]; then
        echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk' >> ~/.zshrc
        echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.zshrc
    fi
    source ~/.bashrc

    # Install Android Studio
    log "Installing Android Studio..."
    if ! flatpak install -y flathub com.google.AndroidStudio; then
        error "Failed to install Android Studio via Flatpak."
    fi

    # Install Flutter
    log "Installing Flutter..."
    if [ -d "/opt/flutter" ]; then
        log "Flutter already installed. Skipping."
    else
        cd /tmp
        if ! wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.2-stable.tar.xz; then
            error "Failed to download Flutter."
            return 1
        fi
        sudo tar xf flutter_linux_3.22.2-stable.tar.xz -C /opt/
        sudo mv /opt/flutter_linux_3.22.2-stable /opt/flutter
        rm flutter_linux_3.22.2-stable.tar.xz
    fi

    # Add Flutter to PATH
    echo 'export PATH=/opt/flutter/bin:$PATH' >> ~/.bashrc
    if [ -f ~/.zshrc ]; then
        echo 'export PATH=/opt/flutter/bin:$PATH' >> ~/.zshrc
    fi
    source ~/.bashrc

    # Run Flutter doctor to check dependencies
    log "Running flutter doctor..."
    flutter doctor

    # Install React Native CLI
    log "Installing React Native CLI..."
    npm install -g @react-native-community/cli

    # Install Expo CLI
    log "Installing Expo CLI..."
    npm install -g expo-cli

    # Install Ionic CLI
    log "Installing Ionic CLI..."
    npm install -g @ionic/cli

    # Install Cordova
    log "Installing Apache Cordova..."
    npm install -g cordova

    # Install Android SDK tools
    log "Installing Android SDK command line tools..."
    mkdir -p ~/Android/sdk
    cd ~/Android/sdk
    if ! wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip; then
        error "Failed to download Android SDK command line tools."
        return 1
    fi
    unzip commandlinetools-linux-11076708_latest.zip
    rm commandlinetools-linux-11076708_latest.zip
    mkdir -p cmdline-tools
    mv cmdline-tools/* cmdline-tools/
    mv android-sdk-license cmdline-tools/
    mv android-sdk-preview-license cmdline-tools/
    mv NOTICE.txt cmdline-tools/
    mv source.properties cmdline-tools/
    mv bin cmdline-tools/
    mv lib cmdline-tools/

    # Add Android SDK to PATH
    echo 'export ANDROID_HOME=~/Android/sdk' >> ~/.bashrc
    echo 'export PATH=$ANDROID_HOME/cmdline-tools/bin:$PATH' >> ~/.bashrc
    echo 'export PATH=$ANDROID_HOME/platform-tools:$PATH' >> ~/.bashrc
    echo 'export PATH=$ANDROID_HOME/emulator:$PATH' >> ~/.bashrc
    if [ -f ~/.zshrc ]; then
        echo 'export ANDROID_HOME=~/Android/sdk' >> ~/.zshrc
        echo 'export PATH=$ANDROID_HOME/cmdline-tools/bin:$PATH' >> ~/.zshrc
        echo 'export PATH=$ANDROID_HOME/platform-tools:$PATH' >> ~/.zshrc
        echo 'export PATH=$ANDROID_HOME/emulator:$PATH' >> ~/.zshrc
    fi
    source ~/.bashrc

    # Accept Android licenses
    log "Accepting Android licenses..."
    yes | sdkmanager --licenses

    # Install essential Android SDK packages
    log "Installing essential Android SDK packages..."
    sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" "emulator" "system-images;android-34;google_apis;x86_64"

    # Install mobile testing tools
    log "Installing mobile development utilities..."
    sudo dnf install -y adb fastboot scrcpy

    # Install emulator dependencies
    log "Installing emulator dependencies..."
    sudo dnf install -y @virtualization
    sudo systemctl start libvirtd
    sudo systemctl enable libvirtd
    sudo usermod -aG libvirt $USER

    log "Mobile development environment setup completed!"
    log "Please restart your terminal or run 'source ~/.bashrc' to use the new tools."
    log "Run 'flutter doctor' to verify your setup."
    log "You can create an Android emulator using 'avdmanager create avd ...' or from Android Studio."
}
