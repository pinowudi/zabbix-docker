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
sudo cp docker-compose-app.service /etc/systemd/system/docker-compose-app.service && \
sudo systemctl enable docker-compose-app && \
sudo systemctl restart docker-compose-app && \
reboot
