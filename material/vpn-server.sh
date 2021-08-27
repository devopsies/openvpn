#!/bin/bash

apt update
apt install -y nginx
cp /vagrant/nginx.conf /etc/nginx/nginx.conf
service nginx restart
cp /vagrant/openvpn-install.sh /home/vagrant/openvpn-install.sh
chmod u+x /home/vagrant/openvpn-install.sh

cat << EOF | tee variables
IP_ADDRESS_LISTEN=10.10.22.10
PROTOCOL=udp
PORT=1194
DNS_CHOICE=1
CONTINUE=1
EOF

source variables

. /home/vagrant/openvpn-install.sh

ADD=myclient /home/vagrant/openvpn-install.sh && mv /root/myclient.ovpn /vagrant/tmp/myclient.ovpn
