#!/bin/bash

apt update
apt install -y openvpn

mv /vagrant/tmp/myclient.ovpn /home/vagrant/myclient.ovpn

nohup openvpn --config /home/vagrant/myclient.ovpn &

