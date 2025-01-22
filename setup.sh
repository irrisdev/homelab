#!/usr/bin/env bash

# Check if the system is Debian-based
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" != "debian" && "$ID_LIKE" != "debian" ]]; then
        echo "This script is intended for Debian-based systems only. Exiting..."
        exit 1
    else
        echo "Debian-based system detected."
    fi
else
    echo "Unable to determine the OS. Exiting..."
    exit 1
fi

# Update and upgrade the system
apt update && apt upgrade -y

# Install Fail2Ban for security
apt install fail2ban -y

# Modify sshd_config to improve security
sed -i \
    -e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' \
    -e 's/^PasswordAuthentication.*/PasswordAuthentication no/' \
    -e 's/^#*UsePAM.*/UsePAM no/' \
    /etc/ssh/sshd_config

# Remove cloud-init ssh configuration file (if present)
rm -f /etc/ssh/sshd_config.d/60-cloudimg-settings.conf

# Enable and restart SSH service
systemctl enable ssh
systemctl restart ssh

# Install unattended-upgrades for automatic security updates
apt install unattended-upgrades -y

# Prompt for new username and create the user
read -p "Enter the username for the new user: " username

# Create new user and set password
adduser "$username"

# Add the new user to the sudo group
usermod -aG sudo "$username"

echo "User $username has been created and added to the sudo group."
