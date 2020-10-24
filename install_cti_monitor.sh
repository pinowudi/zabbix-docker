#!/bin/sh
sudo apt-get update && \
sudo apt-get upgrade -y && \
sudo apt-get dist-upgrade -y && \
sudo add-apt-repository ppa:wireguard/wireguard && \
sudo apt-get update && \
sudo apt-get install wireguard && \
sudo add-apt-repository ppa:shevchuk/dnscrypt-proxy && \
sudo apt update && \
sudo apt install dnscrypt-proxy && \
sudo systemctl restart NetworkManager && \
sudo systemctl restart dnscrypt-proxy && \
sudo apt-get autoremove && \
sudo docker-compose -f cti_monitor.yaml build && \
cat << EOF > docker-compose-app.service
# /etc/systemd/system/docker-compose-app.service

[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/srv/docker/zabbix-docker
cat <<EOF >> docker-compose-app.service
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF
sudo mkdir /srv/docker && \
sudo ln -s $(pwd) /srv/docker/zabbix-docker && \
sudo cp docker-compose-app.service /etc/systemd/system/docker-compose-app.service && \
sudo ln -s cti_monitor.yaml docker-compose.yaml && \
sudo systemctl enable docker-compose-app && \
sudo systemctl restart docker-compose-app && \
reboot
