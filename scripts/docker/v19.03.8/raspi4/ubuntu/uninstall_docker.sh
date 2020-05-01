#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


dpkg -P docker-ce
dpkg -P containerd.io
dpkg -P docker-ce-cli

apt remove --purge -y libltdl7


if [ -e ./downloads/containerd.io_1.2.6-3_arm64.deb ] ;then
    rm ./downloads/containerd.io_1.2.6-3_arm64.deb
fi


if [ -e ./downloads/docker-ce-cli_19.03.8~3-0~debian-buster_arm64.deb ] ;then
    rm ./downloads/docker-ce-cli_19.03.8~3-0~debian-buster_arm64.deb 
fi


if [ -e ./downloads/docker-ce_19.03.8~3-0~debian-buster_arm64.deb ] ;then
    rm ./downloads/docker-ce_19.03.8~3-0~debian-buster_arm64.deb
fi


usermod -G "" ubuntu

echo
echo 'Done.'
echo 'You should reboot your Raspberry Pi.'

exit 0
