# Commonly Used Links and Resources

This document contains links and resources that are frequently used for homelab, development, and personal projects.

## Applications
- [x] Media Server (Jellyfin) 
- [x] DNS Server (Adguard)
- [x] Docker Manager (Portainer)
- [x] Tailscale
- [x] Traefik / NGINX Proxy Manager
- [x] Homepage

#### Coming
- [ ] Home Assistant
- [ ] Net Data
- [ ] Grafana
- [ ] opnSense

#### Ideas
- [ ] Self host Gitlab
- [ ] Storage solution - nextcloud
- [ ] Data redundancy / backups
- [ ] Terraform & CI/CD

## Useful Resources

#### General
- **Proxmox**: 
  - [PVE Helper Scripts](https://community-scripts.github.io/ProxmoxVE/scripts)
  - [Ubuntu VMs](https://github.com/tteck/Proxmox/discussions/2072)
- **Media Server**: [Media Server](/media/README.md)
- **XRDP**: [Setup Guide](/docs/xrdp.md)


#### Networking
- [Traefik](https://doc.traefik.io/traefik/)
- [Nginx Proxy Manager](https://nginxproxymanager.com/setup/)
- [DuckDNS](https://www.duckdns.org/)
- [Cloudflare API Docs](https://developers.cloudflare.com/api/resources/dns/subresources/settings/)

#### Other
- [Adguard DNS Blocklist](https://github.com/hagezi/dns-blocklists)
- [Composerize](https://www.composerize.com/)

## Frequent Commands

### Automatic setup
```bash
bash -c "$(wget -qLO - https://raw.githubusercontent.com/irrisdev/homelab/refs/heads/main/setup.sh)"
```

### Default commands

```bash
# Update and Upgrade Packages
apt update && apt upgrade -y

# Enable Automatic Updates
apt install unattended-upgrades -y

# Install Fail2Ban
apt install fail2ban -y
```

### Add new user and add to sudoers
```bash
read -p "Enter new username: " username
adduser "$username"
usermod -aG sudo "$username"
su "$username" && cd

# Generate ssh key for new user
ssh-keygen -t ed25519
```

### Networking/Firewall Configurations
```bash
sudo sed -i \
-e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' \
-e 's/^PasswordAuthentication.*/PasswordAuthentication no/' \
-e 's/^#*UsePAM.*/UsePAM no/' \
/etc/ssh/sshd_config
sudo rm /etc/ssh/sshd_config.d/60-cloudimg-settings.conf

sudo systemctl enable ssh
sudo systemctl restart ssh

# Configure Firewall (UFW)
sudo ufw enable
sudo ufw allow ssh
sufo ufw reload
```

### Download Docker
```bash
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
```
### Install Portainer - [Docs](https://docs.portainer.io/start/install-ce/server/docker/linux)
```bash
docker volume create portainer_data

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.5
```
