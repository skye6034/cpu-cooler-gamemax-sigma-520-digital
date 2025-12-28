#!/bin/bash

# CPU Cooler Display Installer for Fedora
# Installs dependencies, setup permissions, and enables auto-start service.

set -e  # Exit immediately if a command exits with a non-zero status.

# Colors for pretty output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Installation...${NC}"

# 1. Check for Root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit
fi

# Detect the real user (who called sudo) to run the service as
REAL_USER=${SUDO_USER:-$USER}
echo "Installing for user: $REAL_USER"

# 2. Setup Permissions (Udev Rules)
echo -e "${GREEN}[2/5] Configuring USB permissions...${NC}"
cat > /etc/udev/rules.d/99-cpu-cooler.rules <<EOF
# HID 5131:2007 CPU Cooler Display
SUBSYSTEM=="usb", ATTRS{idVendor}=="5131", ATTRS{idProduct}=="2007", MODE="0666", TAG+="uaccess"
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="5131", ATTRS{idProduct}=="2007", MODE="0666", TAG+="uaccess"
EOF

# Reload rules immediately
udevadm control --reload-rules
udevadm trigger

# 3. Install the Python Script
echo -e "${GREEN}[3/5] Installing script to /usr/local/bin...${NC}"
# We assume the python script is named 'cpu_cooler.py' and is in the current directory
if [ -f "cpu_cooler.py" ]; then
    cp cpu_cooler.py /usr/local/bin/cpu_cooler_display
    chmod +x /usr/local/bin/cpu_cooler_display
else
    echo "Error: cpu_cooler.py not found in current directory!"
    exit 1
fi

# 4. Create and Enable Systemd Service
echo -e "${GREEN}[4/5] Creating background service...${NC}"
cat > /etc/systemd/system/cpu-cooler.service <<EOF
[Unit]
Description=CPU Cooler Display Controller
After=multi-user.target

[Service]
User=$REAL_USER
ExecStartPre=/bin/sleep 10
ExecStart=/usr/bin/python3 /usr/local/bin/cpu_cooler_display
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

echo -e "${GREEN}[5/5] Starting service...${NC}"
systemctl daemon-reload
systemctl enable cpu-cooler.service
systemctl restart cpu-cooler.service

echo -e "${GREEN}Done! Your cooler display is active and will start automatically on boot.${NC}"
