# Commonly Used Links and Resources

This document contains links and resources that are frequently used for homelab, development, and personal projects.

## Useful Resources

#### General
- **Proxmox**: 
  - [PVE Helper Scripts](https://community-scripts.github.io/ProxmoxVE/scripts)
  - [Ubuntu VMs](https://github.com/tteck/Proxmox/discussions/2072)
- **Jellyfin**: [Media Server](https://github.com/TechHutTV/homelab/tree/main/media)


#### Networking
- [Traefik](https://doc.traefik.io/traefik/)
- [Nginx Proxy Manager](https://nginxproxymanager.com/setup/)
- [DuckDNS](https://www.duckdns.org/)
- [Cloudflare API Docs](https://developers.cloudflare.com/api/resources/dns/subresources/settings/)

#### Other
- **Ansible**

## Frequent Commands

### Update and Upgrade Packages

```bash
sudo apt update && sudo apt upgrade -y
```

### Add new user and add to sudoers
```bash
sudo adduser i
sudo usermod -aG sudo i
```

### Install Fail2Ban
```bash
sudo apt install fail2ban -y
```

### Configure Firewall (UFW)
```bash
sudo ufw enable
sudo ufw allow ssh
```

### Configure sshd config
```bash
sudo nano /etc/ssh/sshd_config

# Update settings in sshd_config:
# PasswordAuthentication -> no
# UsePAM -> no
# PermitRootLogin -> no

sudo systemctl restart ssh
```


### Enable Automatic Updates
```bash
sudo apt install unattended-upgrades
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
