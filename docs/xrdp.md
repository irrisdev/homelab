# Enable GUI on Ubuntu Server

Choose your desktop enviornment of choice (gnome, xfce, kde).

### Install Ubuntu Desktop 
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install ubuntu-desktop -y
```

### Install XRDP
```bash
sudo apt install xrdp 
sudo adduser xrdp ssl-cert  
sudo systemctl restart xrdp
sudo ufw allow from 192.168.1.0/24 to any port 3389
```

### Configure XRDP
```bash
sudo sed -i '4 i\export XDG_CURRENT_DESKTOP=ubuntu:GNOME' /etc/xrdp/startwm.sh
sudo sed -i '4 i\export GNOME_SHELL_SESSION_MODE=ubuntu' /etc/xrdp/startwm.sh
sudo sed -i '4 i\export DESKTOP_SESSION=ubuntu' /etc/xrdp/startwm.sh
sudo systemctl restart xrdp
```
