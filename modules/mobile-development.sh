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
    
    # Install Android Studio
    log "Installing Android Studio..."
    # Download and install Android Studio via Flatpak for easier management
    flatpak install -y flathub com.google.AndroidStudio
    
    # Alternative: Manual installation
    # wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.3.1.18/android-studio-2023.3.1.18-linux.tar.gz -O /tmp/android-studio.tar.gz
    # sudo tar -xzf /tmp/android-studio.tar.gz -C /opt/
    # sudo ln -sf /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio
    
    # Install Flutter
    log "Installing Flutter..."
    cd /tmp
    wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
    sudo tar xf flutter_linux_3.16.0-stable.tar.xz -C /opt/
    
    # Add Flutter to PATH
    echo 'export PATH=/opt/flutter/bin:$PATH' >> ~/.bashrc
    
    # Install React Native CLI
    log "Installing React Native CLI..."
    npm install -g @react-native-community/cli
    
    # Install Expo CLI (already installed in web-development module)
    log "Expo CLI should already be installed..."
    
    # Install Ionic CLI (already installed in web-development module)
    log "Ionic CLI should already be installed..."
    
    # Install Cordova
    log "Installing Apache Cordova..."
    npm install -g cordova
    
    # Install Android SDK tools (if not using Android Studio)
    log "Installing Android SDK command line tools..."
    mkdir -p ~/Android/Sdk/cmdline-tools
    cd ~/Android/Sdk/cmdline-tools
    wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
    unzip commandlinetools-linux-10406996_latest.zip
    mv cmdline-tools latest
    
    # Add Android SDK to PATH
    echo 'export ANDROID_HOME=~/Android/Sdk' >> ~/.bashrc
    echo 'export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH' >> ~/.bashrc
    echo 'export PATH=$ANDROID_HOME/platform-tools:$PATH' >> ~/.bashrc
    echo 'export PATH=$ANDROID_HOME/emulator:$PATH' >> ~/.bashrc
    
    # Install iOS development tools (if on macOS - note: this won't work on Linux)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        log "Installing iOS development tools..."
        # Xcode installation would go here, but we're on Linux
        log "iOS development requires macOS and Xcode"
    else
        warn "iOS development is not available on Linux. Consider using React Native or Flutter for cross-platform development."
    fi
    
    # Install mobile testing tools
    log "Installing mobile development utilities..."
    sudo dnf install -y \
        adb \
        fastboot \
        scrcpy  # Android screen mirroring
    
    # Install emulator dependencies
    sudo dnf install -y \
        qemu-kvm \
        libvirt \
        virt-manager \
        bridge-utils
    
    # Add user to libvirt group for emulator access
    sudo usermod -aG libvirt $USER
    
    # Install additional mobile development tools
    log "Installing additional mobile development tools..."
    
    # Install Genymotion (Android emulator alternative)
    # Note: Requires manual setup after installation
    wget https://dl.genymotion.com/releases/genymotion-3.4.0/genymotion-3.4.0-linux_x64.bin -O /tmp/genymotion.bin
    chmod +x /tmp/genymotion.bin
    # Note: This requires manual installation, so we'll skip the automatic install
    log "Genymotion installer downloaded to /tmp/genymotion.bin - run manually if needed"
    
    # Install mobile debugging and testing tools
    log "Installing mobile debugging and testing tools..."
    
    # Install Flipper (mobile app debugger)
    wget https://github.com/facebook/flipper/releases/latest/download/Flipper-linux.zip -O /tmp/flipper.zip
    unzip /tmp/flipper.zip -d /tmp/
    sudo mv /tmp/Flipper-linux-* /opt/flipper
    sudo ln -sf /opt/flipper/flipper /usr/local/bin/flipper
    rm /tmp/flipper.zip
    
    # Install React Native Debugger
    npm install -g react-native-debugger
    
    # Install mobile app analysis tools
    sudo dnf install -y \
        apktool \
        dex2jar \
        jadx
    
    # Install device testing and automation tools
    pip3 install --user \
        appium-python-client \
        pytest \
        robotframework \
        robotframework-appiumlibrary
    
    # Install Appium via npm
    npm install -g appium
    npm install -g appium-doctor
    
    # Install mobile performance testing tools
    npm install -g \
        detox-cli \
        maestro \
        patrol_cli
    
    # Install Firebase CLI for mobile backend
    npm install -g firebase-tools
    
    # Install Fastlane for mobile CI/CD
    sudo gem install fastlane
    
    # Install cross-platform mobile frameworks
    log "Installing additional cross-platform frameworks..."
    
    # Install Xamarin development tools (Mono)
    sudo dnf install -y \
        mono-devel \
        mono-complete \
        nuget
    
    # Install Unity development support
    flatpak install -y flathub com.unity.UnityHub
    
    # Install mobile design and prototyping tools
    log "Installing mobile design tools..."
    
    # Install Figma desktop app
    flatpak install -y flathub com.figma.Figma
    
    # Install Adobe XD alternative - Penpot
    flatpak install -y flathub app.penpot.Penpot
    
    # Install mobile app icon generators
    npm install -g \
        app-icon-cli \
        react-native-asset \
        cordova-res
    
    # Install mobile deployment tools
    log "Installing mobile deployment and distribution tools..."
    
    # Install code-push for React Native
    npm install -g code-push-cli
    
    # Install mobile security testing tools
    log "Installing mobile security tools..."
    
    # Install MobSF dependencies
    pip3 install --user \
        mobsf
    
    # Install OWASP dependency check
    wget https://github.com/jeremylong/DependencyCheck/releases/download/v8.4.0/dependency-check-8.4.0-release.zip -O /tmp/dependency-check.zip
    unzip /tmp/dependency-check.zip -d /tmp/
    sudo mv /tmp/dependency-check /opt/
    sudo ln -sf /opt/dependency-check/bin/dependency-check.sh /usr/local/bin/dependency-check
    rm /tmp/dependency-check.zip
    
    # Install mobile app reverse engineering tools
    sudo dnf install -y \
        binutils \
        file \
        hexedit \
        radare2
    
    # Install mobile network analysis tools
    sudo dnf install -y \
        mitmproxy \
        charles-proxy
    
    # Install Proxyman (HTTP debugging proxy)
    flatpak install -y flathub com.proxyman.Proxyman
    
    # Install mobile app store tools
    log "Installing app store management tools..."
    
    # Install Google Play Console tools
    pip3 install --user google-play-scraper
    
    # Install App Store Connect tools
    npm install -g app-store-connect-api
    
    # Install mobile analytics tools
    npm install -g \
        @segment/analytics-node \
        firebase-admin
    
    # Install mobile push notification testing
    npm install -g \
        web-push \
        push-sender
    
    # Install device farm and cloud testing tools
    log "Installing cloud testing integrations..."
    
    # Install AWS Device Farm CLI
    pip3 install --user awscli
    
    # Install BrowserStack tools
    npm install -g browserstack-local
    
    # Install Sauce Labs tools
    npm install -g saucelabs
    
    # Configure environment variables for mobile development
    log "Setting up mobile development environment variables..."
    
    # Add Android environment variables to shell profiles
    cat >> ~/.bashrc << 'EOF'

# Mobile Development Environment Variables
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"

# Flutter
export PATH="/opt/flutter/bin:$PATH"

# React Native
export REACT_NATIVE_HOME="$HOME/.react-native"

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# Unity
export UNITY_HOME="/opt/unity"
EOF
    
    # Add to Zsh profile if it exists
    if [ -f ~/.zshrc ]; then
        cat >> ~/.zshrc << 'EOF'

# Mobile Development Environment Variables
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"

# Flutter
export PATH="/opt/flutter/bin:$PATH"

# React Native
export REACT_NATIVE_HOME="$HOME/.react-native"

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# Unity
export UNITY_HOME="/opt/unity"
EOF
    fi
    
    log "Enhanced mobile development environment setup completed!"
    log "📱 Mobile debugging: Flipper, React Native Debugger"
    log "🧪 Testing tools: Appium, Detox, Maestro"
    log "🚀 CI/CD: Fastlane, Firebase CLI, Code Push"
    log "🎨 Design tools: Figma, Penpot"
    log "🔒 Security tools: MobSF, OWASP Dependency Check"
    log "☁️ Cloud testing: BrowserStack, Sauce Labs integrations"
    log "🎮 Game development: Unity Hub"
    log ""
    log "Note: You'll need to restart your terminal or run 'source ~/.bashrc' to update PATH variables"
    log "After restart, run 'flutter doctor' to verify Flutter installation"
    log "Run Android Studio and complete the SDK setup through the GUI"
    log "Run 'appium-doctor' to verify Appium setup"
}
