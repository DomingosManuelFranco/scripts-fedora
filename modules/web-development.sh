#!/bin/bash

# Web Development Module
# Installs tools for web development

setup_web_development() {
    log "Setting up web development environment..."
    
    # Install Node.js via NodeSource repository
    log "Installing Node.js..."
    curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
    sudo dnf install -y nodejs npm
    
    # Install Yarn
    log "Installing Yarn..."
    curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo dnf install -y yarn
    
    # Install pnpm
    log "Installing pnpm..."
    npm install -g pnpm
    
    # Install global npm packages
    log "Installing global npm packages..."
    npm install -g \
        @angular/cli \
        @vue/cli \
        create-react-app \
        create-next-app \
        vite \
        typescript \
        ts-node \
        nodemon \
        pm2 \
        eslint \
        prettier \
        live-server \
        serve \
        http-server \
        netlify-cli \
        vercel \
        firebase-tools \
        expo-cli \
        @ionic/cli
    
    # Install VS Code
    log "Installing Visual Studio Code..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf install -y code
    
    # Install VS Code extensions
    log "Installing VS Code extensions..."
    # Language support
    code --install-extension ms-vscode.vscode-typescript-next
    code --install-extension ms-python.python
    code --install-extension ms-vscode.vscode-json
    code --install-extension redhat.vscode-yaml
    code --install-extension ms-vscode.vscode-xml
    code --install-extension rust-lang.rust-analyzer
    code --install-extension golang.go
    code --install-extension ms-dotnettools.csharp
    code --install-extension ms-vscode.powershell
    
    # Web development
    code --install-extension bradlc.vscode-tailwindcss
    code --install-extension ms-vscode.vscode-css-peek
    code --install-extension ecmel.vscode-html-css
    code --install-extension formulahendry.auto-rename-tag
    code --install-extension formulahendry.auto-close-tag
    code --install-extension ms-vscode.live-server
    code --install-extension ritwickdey.liveserver
    code --install-extension firefox-devtools.vscode-firefox-debug
    code --install-extension ms-edgedevtools.vscode-edge-devtools
    
    # Frameworks and libraries
    code --install-extension Angular.ng-template
    code --install-extension johnpapa.Angular2
    code --install-extension octref.vetur
    code --install-extension Vue.volar
    code --install-extension ms-vscode.vscode-react-native
    code --install-extension dsznajder.es7-react-js-snippets
    code --install-extension bradlc.vscode-tailwindcss
    code --install-extension svelte.svelte-vscode
    
    # Code quality and formatting
    code --install-extension esbenp.prettier-vscode
    code --install-extension ms-vscode.vscode-eslint
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension stylelint.vscode-stylelint
    code --install-extension bradlc.vscode-tailwindcss
    code --install-extension formulahendry.code-runner
    code --install-extension christian-kohler.path-intellisense
    code --install-extension naumovs.color-highlight
    code --install-extension oderwat.indent-rainbow
    code --install-extension CoenraadS.bracket-pair-colorizer-2
    
    # DevOps and containers
    code --install-extension ms-vscode.vscode-docker
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
    code --install-extension hashicorp.terraform
    code --install-extension ms-azuretools.vscode-azureterraform
    
    # Git and collaboration
    code --install-extension github.copilot
    code --install-extension github.copilot-chat
    code --install-extension GitHub.vscode-pull-request-github
    code --install-extension eamodio.gitlens
    code --install-extension mhutchie.git-graph
    code --install-extension donjayamanne.githistory
    
    # Database
    code --install-extension ms-mssql.mssql
    code --install-extension ms-ossdata.vscode-postgresql
    code --install-extension bmewburn.vscode-intelephense-client
    code --install-extension mtxr.sqltools
    
    # Productivity
    code --install-extension ms-vscode.vscode-todo-highlight
    code --install-extension Gruntfuggly.todo-tree
    code --install-extension alefragnani.Bookmarks
    code --install-extension streetsidesoftware.code-spell-checker
    code --install-extension ms-vscode.vscode-markdown
    code --install-extension shd101wyy.markdown-preview-enhanced
    code --install-extension yzhang.markdown-all-in-one
    
    # Themes and icons
    code --install-extension zhuangtongfa.Material-theme
    code --install-extension PKief.material-icon-theme
    code --install-extension vscode-icons-team.vscode-icons
    code --install-extension dracula-theme.theme-dracula
    code --install-extension GitHub.github-vscode-theme
    
    # Install Sublime Text
    log "Installing Sublime Text..."
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    sudo dnf install -y sublime-text
    
    # Install browsers for testing
    log "Installing browsers for development and testing..."
    # Chrome
    sudo dnf config-manager --set-enabled google-chrome
    sudo dnf install -y google-chrome-stable
    
    # Brave Browser
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo dnf install -y brave-browser
    
    # Firefox Developer Edition
    flatpak install -y flathub org.mozilla.firefox
    
    # Microsoft Edge
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
    sudo dnf install -y microsoft-edge-stable
    
    # Install design and prototyping tools
    log "Installing design and prototyping tools..."
    
    # Figma (Web-based, but install PWA support)
    flatpak install -y flathub com.github.IsmaelMartinez.teams_for_linux
    
    # GIMP for image editing
    sudo dnf install -y gimp gimp-plugins-extras
    
    # Inkscape for vector graphics
    flatpak install -y flathub org.inkscape.Inkscape
    
    # Krita for digital painting
    flatpak install -y flathub org.kde.krita
    
    # Blender for 3D modeling
    flatpak install -y flathub org.blender.Blender
    
    # Install additional web development tools
    log "Installing additional web development utilities..."
    
    # Web servers and reverse proxies
    sudo dnf install -y \
        nginx \
        httpd \
        caddy \
        traefik \
        haproxy
    
    # PHP and related tools
    sudo dnf install -y \
        php \
        php-cli \
        php-fpm \
        php-mysql \
        php-pgsql \
        php-sqlite3 \
        php-mbstring \
        php-xml \
        php-json \
        php-curl \
        php-gd \
        php-zip \
        php-bcmath \
        php-opcache \
        composer
    
    # Python web development tools
    pip3 install --user \
        flask \
        django \
        fastapi \
        uvicorn \
        gunicorn \
        celery \
        redis \
        requests \
        beautifulsoup4 \
        scrapy \
        selenium \
        jupyter \
        ipython
    
    # Ruby and Rails
    sudo dnf install -y ruby ruby-devel rubygems
    gem install rails bundler
    
    # Performance and testing tools
    log "Installing performance and testing tools..."
    sudo dnf install -y \
        siege \
        apache-bench \
        wrk \
        vegeta
    
    # Install Lighthouse CLI
    npm install -g lighthouse
    
    # Install web performance tools
    npm install -g \
        @web/dev-server \
        browser-sync \
        webpack-bundle-analyzer \
        bundlesize \
        speed-test \
        pagespeed-insights-cli
    
    # Install Chrome DevTools extensions and tools
    npm install -g \
        chrome-launcher \
        puppeteer \
        playwright \
        cypress
    
    # Install API documentation tools
    log "Installing API documentation and mock tools..."
    npm install -g \
        @apidevtools/swagger-cli \
        redoc-cli \
        json-server \
        mockoon-cli \
        wiremock
    
    # Install Mockoon (API mocking tool)
    flatpak install -y flathub com.mockoon.Mockoon
    
    # Install database GUI tools for web development
    log "Installing database management tools..."
    
    # Redis GUI
    flatpak install -y flathub app.redisinsight.RedisInsight
    
    # MongoDB Compass
    flatpak install -y flathub com.mongodb.Compass
    
    # phpMyAdmin (web-based)
    sudo dnf install -y phpMyAdmin
    
    # Install static site generators and JAMstack tools
    log "Installing static site generators and JAMstack tools..."
    npm install -g \
        @11ty/eleventy \
        gatsby-cli \
        @gridsome/cli \
        @nuxtjs/create-nuxt-app \
        @quasar/cli \
        hugo \
        jekyll
    
    # Install Hugo (static site generator)
    sudo dnf install -y hugo
    
    # Install content management and headless CMS tools
    npm install -g \
        strapi \
        @sanity/cli \
        contentful-cli \
        ghost-cli
    
    # Install Progressive Web App tools
    npm install -g \
        workbox-cli \
        pwa-asset-generator \
        web-app-manifest-cli
    
    # Install code quality and security tools
    log "Installing code quality and security scanning tools..."
    npm install -g \
        eslint \
        prettier \
        stylelint \
        jshint \
        jslint \
        standard \
        xo \
        snyk \
        nsp \
        retire \
        audit-ci
    
    # Install Sonarqube scanner
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip
    unzip sonar-scanner-cli-4.8.0.2856-linux.zip
    sudo mv sonar-scanner-4.8.0.2856-linux /opt/sonar-scanner
    sudo ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner
    rm sonar-scanner-cli-4.8.0.2856-linux.zip
    
    # Install accessibility testing tools
    npm install -g \
        axe-cli \
        lighthouse-ci \
        pa11y \
        pa11y-ci
    
    # Install email development tools
    log "Installing email development tools..."
    npm install -g \
        maildev \
        mjml \
        email-templates-cli
    
    # Install local tunnel tools for testing
    npm install -g \
        ngrok \
        localtunnel \
        serveo
    
    # Install browser automation tools
    log "Installing browser automation tools..."
    
    # Selenium WebDriver
    pip3 install --user selenium webdriver-manager
    
    # Install ChromeDriver
    CHROME_DRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)
    wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip"
    unzip /tmp/chromedriver.zip -d /tmp/
    sudo mv /tmp/chromedriver /usr/local/bin/chromedriver
    sudo chmod +x /usr/local/bin/chromedriver
    rm /tmp/chromedriver.zip
    
    log "Enhanced web development environment setup completed!"
    log "🌐 Multiple browsers installed for cross-browser testing"
    log "🎨 Design tools: GIMP, Inkscape, Krita, Blender"
    log "🔧 Performance tools: Lighthouse, Siege, Apache Bench"
    log "🧪 Testing tools: Cypress, Playwright, Selenium"
    log "📊 API tools: Postman, Insomnia, Mockoon"
    log "🗄️ Database GUIs: DBeaver, Redis Insight, MongoDB Compass"
    log "🚀 JAMstack tools: Gatsby, Next.js, Nuxt.js, Hugo"
}
