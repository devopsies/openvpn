#!/bin/bash

apt update
apt install -y nginx
cp /vagrant/index.html /var/www/html/index.html