
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
