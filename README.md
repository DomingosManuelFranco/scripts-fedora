# Fedora Developer Setup Scripts

Automated setup scripts for Fedora Linux targeting web and mobile developers. These scripts will transform a fresh Fedora installation into a fully configured development environment.

## 🚀 Features

- **System Setup**: Updates, RPM Fusion repositories, multimedia codecs
- **Development Tools**: Git, Docker, databases, essential CLI tools
- **Web Development**: Node.js, npm/yarn/pnpm, VS Code, browsers, frameworks
- **Mobile Development**: Android Studio, Flutter, React Native, Java JDK
- **Shell Enhancement**: Zsh with Oh My Zsh, Powerlevel10k theme, useful plugins
- **Fonts & Theming**: FiraCode Nerd Font, programming fonts, themes for GNOME/KDE
- **Additional Repositories**: Flatpak, Terra repos, useful applications

## 📋 What Gets Installed

### System & Multimedia

- System updates and RPM Fusion repositories
- Multimedia codecs (gstreamer, ffmpeg, etc.)
- Essential tools (curl, wget, git, build tools)
- VLC, OBS Studio, GIMP, Audacity

### Development Tools

- **Version Control**: Git, Git LFS, GitKraken, GitHub Desktop, Meld
- **Containers**: Docker, Docker Compose, Portainer (GUI), Lazydocker, ctop, dive
- **Databases**: PostgreSQL, MySQL, Redis, SQLite, DBeaver, MySQL Workbench
- **Editors**: VS Code (70+ extensions), Sublime Text, Neovim, JetBrains Toolbox, Zed
- **CLI Tools**: jq, yq, httpie, fzf, ripgrep, bat, exa, btop, procs, bandwhich
- **Cloud**: AWS CLI, Azure CLI, Google Cloud CLI, kubectl, Helm, Terraform
- **Monitoring**: htop, btop, glances, gotop, ctop, iotop, nmon
- **Security**: KeePassXC, pass, OpenSSL, GnuPG, Wireshark

### Web Development

- **Runtime**: Node.js (LTS), npm, Yarn, pnpm, NVM
- **Frameworks**: Angular CLI, Vue CLI, Create React App, Vite, Next.js, Nuxt.js
- **Global Tools**: TypeScript, ESLint, Prettier, Netlify CLI, Vercel CLI, Firebase CLI
- **Browsers**: Google Chrome, Brave Browser, Firefox Developer Edition, Microsoft Edge
- **Servers**: Nginx, Apache, Caddy, PHP with extensions
- **Testing**: Lighthouse, Cypress, Playwright, Puppeteer, Selenium
- **API Tools**: Postman, Insomnia, HTTPie Desktop, Mockoon, JSON Server
- **Performance**: Siege, Apache Bench, WebPageTest CLI, Bundle Analyzer
- **Design**: GIMP, Inkscape, Krita, Blender, Figma (PWA)
- **JAMstack**: Gatsby CLI, Hugo, Jekyll, Eleventy, Gridsome
- **CMS**: Strapi, Sanity CLI, Contentful CLI, Ghost CLI

### Mobile Development

- **Android**: Java 17 JDK, Android Studio (Flatpak), Android SDK tools
- **Cross-platform**: Flutter, React Native CLI, Ionic CLI, Cordova, Xamarin (Mono)
- **Emulation**: QEMU/KVM for Android emulators, Genymotion
- **Tools**: ADB, Fastboot, scrcpy (screen mirroring), Flipper
- **Testing**: Appium, Detox, Maestro, React Native Debugger
- **CI/CD**: Fastlane, Firebase CLI, Code Push CLI
- **Security**: MobSF, OWASP Dependency Check, APKTool
- **Design**: Figma, Penpot, app icon generators
- **Game Dev**: Unity Hub
- **Cloud Testing**: BrowserStack Local, Sauce Labs tools

### Shell & Terminal

- **Shell**: Zsh with Oh My Zsh
- **Theme**: Powerlevel10k
- **Plugins**: autosuggestions, syntax highlighting, completions
- **Terminals**: Alacritty, Kitty, Tilix
- **Prompt**: Starship (alternative to Powerlevel10k)

### Fonts & Theming

- **Programming Fonts**: FiraCode Nerd Font, JetBrains Mono, Hack, Source Code Pro
- **System Fonts**: Google Fonts (Roboto, Noto), Liberation, DejaVu
- **Themes**: Orchis theme, Tela icon theme (GNOME & KDE)
- **Tools**: Kvantum (KDE), GNOME Tweaks, theme engines

### Flatpak Applications

- Discord, Spotify, Telegram, Slack, Signal
- LibreOffice, Thunderbird, VLC
- Inkscape, Blender, development tools

## 🔧 Usage

### Quick Start (Recommended)

```bash
# Clone the repository
git clone https://github.com/woodzo/scripts-fedora.git
cd scripts-fedora

# Make the script executable
chmod +x setup-fedora.sh

# Run the setup script
./setup-fedora.sh
```

### Interactive Setup

The script will present you with options:

1. System Updates & RPM Fusion
2. Multimedia Codecs
3. Development Tools (Git, Docker, etc.)
4. Web Development (Node.js, VS Code, etc.)
5. Mobile Development (Android Studio, Flutter, etc.)
6. Zsh Shell Setup with Oh My Zsh
7. Fonts & Theming (FiraCode, KDE themes, etc.)
8. Flatpak & Additional Repositories
9. All of the above

### Individual Module Installation

You can also run individual modules:

```bash
# Just install development tools
source modules/development-tools.sh && setup_development_tools

# Just install web development environment
source modules/web-development.sh && setup_web_development

# Just install fonts and theming
source modules/theming-fonts.sh && setup_theming_fonts
```

## 📁 Project Structure

```
scripts-fedora/
├── setup-fedora.sh              # Main setup script
├── modules/
│   ├── system-setup.sh          # System updates, RPM Fusion, multimedia
│   ├── development-tools.sh     # Git, Docker, databases, CLI tools
│   ├── web-development.sh       # Node.js, VS Code, web frameworks
│   ├── mobile-development.sh    # Android Studio, Flutter, React Native
│   ├── zsh-setup.sh            # Zsh, Oh My Zsh, themes, plugins
│   └── theming-fonts.sh        # Fonts, themes, visual customization
└── README.md                    # This file
```

## ⚙️ Post-Installation Steps

### 1. Restart Required

After installation, restart your system to ensure all changes take effect:

```bash
sudo reboot
```

### 2. Configure Git

If you skipped Git configuration during setup:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 3. Shell Configuration

If you installed Zsh, log out and log back in, then configure Powerlevel10k:

```bash
p10k configure
```

### 4. Android Development Setup

After reboot, complete Android Studio setup:

1. Launch Android Studio
2. Complete the initial setup wizard
3. Install Android SDK components
4. Create a virtual device (AVD)

### 5. Flutter Setup

Verify Flutter installation:

```bash
flutter doctor
```

Follow any additional setup instructions shown.

### 6. VS Code Extensions

Additional useful extensions you might want:

```bash
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode.remote-explorer
```

### 7. Docker Post-Setup

Add your user to the docker group (already done by script, but requires reboot):

```bash
# Verify docker works without sudo
docker run hello-world
```

## 🎨 Customization

### Fonts

The script installs several programming fonts. To change your terminal font:

- **GNOME Terminal**: Preferences → Profiles → Text → Custom font
- **Alacritty**: Edit `~/.config/alacritty/alacritty.yml`
- **VS Code**: Settings → Font Family

### Themes

For GNOME users:

- Use GNOME Tweaks to apply Orchis theme and Tela icons
- Install additional themes from [GNOME Look](https://www.gnome-look.org/)

For KDE users:

- Use System Settings → Appearance to apply themes
- Configure Kvantum for additional theming options

### Shell Prompt

Choose between Powerlevel10k (Zsh) or Starship (universal):

- Powerlevel10k: `p10k configure`
- Starship: Edit `~/.config/starship.toml`

## 🐛 Troubleshooting

### Common Issues

1. **Docker permission denied**

   ```bash
   sudo usermod -aG docker $USER
   # Then reboot
   ```

2. **Android Studio won't start**

   - Ensure Java is properly installed
   - Check `JAVA_HOME` environment variable
   - Try launching from terminal: `flatpak run com.google.AndroidStudio`

3. **Flutter command not found**

   ```bash
   echo 'export PATH=/opt/flutter/bin:$PATH' >> ~/.bashrc
   source ~/.bashrc
   ```

4. **VS Code extensions not installing**

   - Ensure VS Code is properly installed
   - Try installing extensions manually through the GUI

5. **Zsh not default shell**
   ```bash
   sudo chsh -s $(which zsh) $USER
   # Then log out and back in
   ```

### Getting Help

- Check the script logs for any error messages
- Ensure you have a stable internet connection
- Run `dnf update` before running the script
- For Android development issues, run `flutter doctor` for diagnostics

## 🔄 Updates

To update the setup scripts:

```bash
cd scripts-fedora
git pull origin main
./setup-fedora.sh
```

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

---

**Happy Coding! 🚀**
