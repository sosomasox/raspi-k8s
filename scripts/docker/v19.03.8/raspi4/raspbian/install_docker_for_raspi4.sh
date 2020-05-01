#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


apt install -y libltdl7


if [ ! -e ./downloads ] ;then
    mkdir downloads
fi


if [ ! -e ./downloads/containerd.io_1.2.13-1_armhf.deb  ] ;then
    wget -P ./downloads https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/containerd.io_1.2.13-1_armhf.deb
fi


if [ ! -e ./downloads/docker-ce-cli_19.03.8~3-0~debian-buster_armhf.deb ] ;then
    wget -P ./downloads https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce-cli_19.03.8~3-0~debian-buster_armhf.deb 
fi


if [ ! -e ./downloads/docker-ce_19.03.8~3-0~debian-buster_armhf.deb ] ;then
    wget -P ./downloads https://download.docker.com/linux/debian/dists/buster/pool/stable/armhf/docker-ce_19.03.8~3-0~debian-buster_armhf.deb
fi


dpkg -i ./downloads/containerd.io_1.2.13-1_armhf.deb
dpkg -i ./downloads/docker-ce-cli_19.03.8~3-0~debian-buster_armhf.deb 
dpkg -i ./downloads/docker-ce_19.03.8~3-0~debian-buster_armhf.deb

usermod -aG docker pi

echo
echo 'Done.'
echo 'You should reboot your Raspberry Pi.'

exit 0
