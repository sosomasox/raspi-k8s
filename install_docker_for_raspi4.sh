#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi

wget https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/containerd.io_1.2.6-3_armhf.deb 

#wget https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce-cli_18.09.0~3-0~debian-buster_armhf.deb 
#wget https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce-cli_18.09.9~3-0~debian-buster_armhf.deb 

#wget https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce_18.03.1~ce-0~debian_armhf.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce_18.06.1~ce~3-0~debian_armhf.deb 
#wget https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce_18.06.3~ce~3-0~debian_armhf.deb
#wget https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce_18.09.9~3-0~debian-buster_armhf.deb

sudo dpkg -i containerd.io_1.2.5-1_armhf.deb
#sudo dpkg -i docker-ce-cli_18.09.0~3-0~debian-buster_armhf.deb 
sudo dpkg -i docker-ce_18.06.1~ce~3-0~debian_armhf.deb 

usermod -aG docker pi

echo 'You need to reboot.'

exit 0
