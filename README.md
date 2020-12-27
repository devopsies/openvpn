# GoMyCode training workshop : networking

Install KVM, Vagrant and Vagrant's Libvirt plugin (as root)

```bash
apt -y install qemu-kvm libvirt-bin ebtables dnsmasq-base libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev software-properties-common
wget https://releases.hashicorp.com/vagrant/2.2.10/vagrant_2.2.10_x86_64.deb
dpkg -i vagrant_2.2.10_x86_64.deb
vagrant plugin install vagrant-libvirt
```

Clone repository:

```bash
git clone https://github.com/mdnfiras/gmc-workshop1.git
```

Launch & SSH into the OpenVPN server's Vagrant VM. This machine will be connected to two networks, Vagrant's default management network and the private network that we defined in its Vagrant file `192.168.5.0/24`, with the IP address `192.168.5.3`:

```bash
cd gmc-workshop1/vpn
vagrant up --provider libvirt
vagrant ssh
```

Setup OpenVPN on the server (as root). Setup the VM's local IP of the Vagrant's management network (should be the first option) as the VPN's private and public IP:
```bash
cd openvpn-install
chmod u=x openvpn-install.sh
./openvpn-install.sh
```

Copy the first client's configuration file content (assuming you have named your first client `client`):
```bash
cat /root/client.ovpn
```

Exit the server's SSH session, launch & SSH into the OpenVPN client's Vagrant VM. This machine will be connected to two networks, Vagrant's default management network and the second private network that we defined in its Vagrant file `192.168.6.0/24`, with the IP address `192.168.6.3`:

```bash
cd gmc-workshop1/vpn
vagrant up --provider libvirt
vagrant ssh
```

Paste the client's configuration into a file, i.e `client.ovpn` (you can use nano) and install OpenVPN (as root):

```bash
apt install openvpn
```

Check if you can access the server's NGINX web page through its private network. It should return an error:

```bash
curl 192.168.5.3
```

Run the client OpenVPN in the background using the client's configuration file (as root):
```bash
openvpn --config /path/to/client.ovpn &
```

Check again!

```bash
curl 192.168.5.3
```