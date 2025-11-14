# 🚀 MoonTrader Trading Terminal Installation Script

Automatic installer for MoonTrader trading terminal for Linux systems with MTGuardian monitoring support.

> **Русская версия**: [README.md](README.md)

## 📋 Table of Contents

- [System Requirements](#-system-requirements)
- [Supported Systems](#-supported-systems)
- [Quick Installation](#-quick-installation)
- [Installation Options](#-installation-options)
- [MoonTrader Management](#-moontrader-management)
- [MTGuardian - Monitoring](#-mtguardian---monitoring)
- [File Structure](#-file-structure)
- [Troubleshooting](#-troubleshooting)

## ⚙️ System Requirements

- **OS**: Ubuntu 20.04+, Debian 12+
- **Architecture**: AMD64 (x86_64), ARM64 (aarch64)
- **Privileges**: root access
- **MoonTrader requirements**: see [official website](https://moontrader.com)

## 🖥️ Supported Systems

| System | Version | Status |
|---------|--------|--------|
| Ubuntu | 20.04 LTS | ⚠️ Outdated operating system |
| Ubuntu | 22.04 LTS | ✅ Tested |
| Ubuntu | 24.04 LTS | ✅ Tested |
| Debian | 12 | ⚠️ Tested, but not fully |

## 🚀 Quick Installation

### 1. Connect via SSH
Use an SSH client of your choice to connect to your server:
- **Windows**: for example, [MobaXterm](https://mobaxterm.mobatek.net/), [mRemoteNG](https://mremoteng.org/) (links provided as examples and may be outdated)
- **Linux/Mac**: built-in SSH client in terminal

```bash
ssh user@your-server-ip
```

### 2. Elevate to Root
```bash
# For Ubuntu
sudo su

# For Debian
su -
```

### 3. Installation
```bash
wget -O - https://raw.githubusercontent.com/SlippingForest/MoonTrader_install/master/Linux/install.sh | bash <(cat) </dev/tty
```

## 🔧 Installation Options

### Automatic Installation
- ✅ MoonTrader installation
- ✅ Time setup (chrony)
- ✅ Firewall configuration
- ✅ Fail2Ban setup
- ❌ MTGuardian (monitoring)

### Custom Installation
- ✅ Choose download source (official/Dropbox)
- ✅ Time setup (chrony)
- ✅ Firewall configuration
- ✅ Fail2Ban setup
- ✅ **MTGuardian (monitoring)**

## 🎮 MoonTrader Management

### Basic Commands

| Command | Description |
|---------|----------|
| `MoonTrader` | Start with update |
| `MoonTrader --no-update` | Start without update |
| `MoonTrader --stop` | Stop all processes |
| `MoonTrader --status` | Process status |
| `MoonTrader --attach` | Connect to tmux session |
| `MoonTrader --help` | Help |

### Working with tmux

#### Starting in tmux session
```bash
# Start MoonTrader (creates 'mt' session automatically)
MoonTrader

# Detach from session (Ctrl+B, then D)
# MoonTrader will continue running in background
```

#### Connecting to session
```bash
# Connect to existing session
tmux attach -t mt

# Or through MoonTrader command
MoonTrader --attach
```

### Stop and Cleanup

#### Stopping MoonTrader
```bash
# Graceful stop
MoonTrader --stop

# Force stop (if not responding)
pkill -f MTCore
```

#### Data Cleanup
```bash
# Profile cleanup (reset to default settings)
rm -rf ~/.config/moontrader-data/data

# Log cleanup
rm -rf ~/.config/moontrader-data/data/logs/

# Archive data cleanup
rm -rf ~/.config/moontrader-data/data/archive/
```

## 🛡️ MTGuardian - Monitoring

MTGuardian - MoonTrader monitoring system with Telegram notifications.

### MTGuardian Installation
1. Choose **Custom installation** during setup
2. Enable **Setup MT Guardian** option
3. Enter Telegram bot data:
   - **Server Name**: your server name or custom name
   - **Bot Token**: Telegram bot token
   - **Chat ID**: notification chat ID

### MTGuardian Management
```bash
# Service status
systemctl status mtguardian

# Start service
systemctl start mtguardian

# Stop service
systemctl stop mtguardian

# Restart service
systemctl restart mtguardian

# View logs
tail -f ~/MTGuardian/MTGuardian.log
```

### MTGuardian Autostart Management

```bash
# Enable autostart
sudo systemctl enable mtguardian

# Disable autostart
sudo systemctl disable mtguardian

# Check status
sudo systemctl is-enabled mtguardian

# Complete stop (MTCore continues running)
sudo systemctl stop mtguardian && sudo systemctl disable mtguardian
```

### Telegram Bot Setup
1. Create bot via [@BotFather](https://t.me/BotFather)
2. Get bot token
3. Get Chat ID via [@userinfobot](https://t.me/userinfobot)

## 📁 File Structure

```
~/
├── moontrader/                    # MoonTrader core
│   ├── MTCore                     # Executable file
│   └── start_mt.sh                   # Startup script
├── .config/moontrader-data/       # Configuration and data
│   └── data/
│       ├── default.profile       # Default profile
│       ├── logs/                 # Logs
│       └── archive/              # Archive data
└── MTGuardian/                   # Monitoring system
    ├── MTGuardian                # Main script
    ├── MTGuardian.settings       # Settings
    └── MTGuardian.log           # Monitoring logs
```

### Quick Navigation
```bash
# Navigate to core directory
cd ~/moontrader

# Navigate to configuration directory
cd ~/.config/moontrader-data/

# Navigate to MTGuardian directory
cd ~/MTGuardian
```

## 🔧 Troubleshooting

### Launch Issues
```bash
# Check status
MoonTrader --status

# Check processes
ps aux | grep MTCore

# Check tmux sessions
tmux list-sessions

# Connect to MoonTrader session (if exists)
tmux attach -t mt
```

### MTGuardian Issues
```bash
# Check service
systemctl status mtguardian

# View logs
journalctl -u mtguardian -f

# Check configuration
cat ~/MTGuardian/MTGuardian.settings
```

### Network Issues
```bash
# Check firewall
iptables -L

# Check ports
netstat -tulpn | grep 4242
```

---

**Happy Trading! 🚀📈**
