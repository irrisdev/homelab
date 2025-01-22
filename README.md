# Commonly Used Links and Resources

This document contains links and resources that are frequently used for homelab, development, and personal projects.

## Applications
- [x] Media Server (Jellyfin) 
- [x] DNS Server (Adguard)
- [x] Docker Manager (Portainer)

#### Coming
- [ ] Traefik / NGINX Proxy Manager
- [ ] Home Assistant
- [ ] Homepage
- [ ] Net Data
- [ ] Grafana
- [ ] Tailscale

### Tasks
- [x] Configure Hardware RAID
- [x] Upgrade BIOS Firmware
- [ ] Setup TrueNAS - DL320e (6TB)
- [x] Setup Proxmox - DL380p (8TB)
- [ ] Reduce Fanspeeds [Link](https://www.reddit.com/r/homelab/comments/sx3ldo/hp_ilo4_v277_unlocked_access_to_fan_controls/)

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

### Configure sshd config
```bash
sudo nano /etc/ssh/sshd_config

# Update settings in sshd_config:
# PasswordAuthentication -> no
# UsePAM -> no
# PermitRootLogin -> no

sed -i \
-e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' \
-e 's/^PasswordAuthentication.*/PasswordAuthentication no/' \
-e 's/^#*UsePAM.*/UsePAM no/' \
/etc/ssh/sshd_config
rm /etc/ssh/sshd_config.d/60-cloudimg-settings.conf

sudo systemctl enable ssh
sudo systemctl restart ssh
```

### Configure Firewall (UFW)
```bash
sudo ufw enable
sudo ufw allow ssh
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
### Install Portainer - [Docs](https://docs.portainer.io/start/install-ce/server/docker/linux)
```bash
docker volume create portainer_data

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.5
```
