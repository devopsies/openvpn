#!/bin/bash

apt update
apt install -y openvpn

openvpn --config /vagrant/myclient.ovpn &

