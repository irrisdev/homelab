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

# Update and Upgrade Packages
sudo apt update && sudo apt upgrade -y

sudo apt install --no-install-recommends -y \
    unattended-upgrades \
    fail2ban

ssh-keygen -t ed25519

sudo sed -i \
-e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' \
# -e 's/^PasswordAuthentication.*/PasswordAuthentication no/' \
-e 's/^#*UsePAM.*/UsePAM no/' \
    /etc/ssh/sshd_config
sudo rm /etc/ssh/sshd_config.d/60-cloudimg-settings.conf

sudo systemctl enable ssh
sudo systemctl restart ssh

# Configure Firewall (UFW)
sudo ufw enable
sudo ufw allow ssh
sudo ufw reload

sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo apt autoremove -y
