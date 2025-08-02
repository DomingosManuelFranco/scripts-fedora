# Fedora Developer Setup - One-Line Installation

For users who want to install without Git authentication issues, use this direct download method:

## 🚀 One-Line Installation

```bash
curl -L https://raw.githubusercontent.com/DomingosManuelFranco/scripts-fedora/main/install.sh | bash
```

## 📋 What This Does

1. **Downloads** the latest version of the setup scripts directly from GitHub
2. **No Git authentication** required - uses public HTTPS download
3. **Extracts** all files to `~/fedora-dev-setup/`
4. **Runs** the interactive setup automatically
5. **Works** for any user without GitHub account requirements

## 🔧 Manual Installation (If You Prefer)

```bash
# Download the installer
curl -L https://raw.githubusercontent.com/DomingosManuelFranco/scripts-fedora/main/install.sh -o install.sh

# Review the script (optional but recommended)
cat install.sh

# Make executable and run
chmod +x install.sh
./install.sh
```

## 🆚 Git vs Direct Download

| Method              | Pros                                                                   | Cons                                                   |
| ------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------ |
| **Direct Download** | ✅ No authentication needed<br>✅ Works for any user<br>✅ One command | ❌ No version control<br>❌ Re-download for updates    |
| **Git Clone**       | ✅ Easy updates with `git pull`<br>✅ Version control                  | ❌ Requires Git setup<br>❌ May ask for authentication |

## 🔄 For Updates

With direct download method:

```bash
# Re-run the installer to get latest version
curl -L https://raw.githubusercontent.com/DomingosManuelFranco/scripts-fedora/main/install.sh | bash
```

With Git method:

```bash
cd scripts-fedora
git pull
./setup-fedora.sh
```

## 🔒 Security Note

The one-line installation downloads and executes a script from the internet. This is generally safe when using trusted sources, but you can always:

1. Download the script first: `curl -L URL -o install.sh`
2. Review it: `cat install.sh` or `less install.sh`
3. Then execute: `bash install.sh`

This approach gives you the transparency while maintaining convenience.
