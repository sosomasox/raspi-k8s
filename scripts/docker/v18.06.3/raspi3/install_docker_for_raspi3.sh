#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


curl -sSL https://get.docker.com | sh
apt remove --purge -y docker-ce docker-ce-cli containerd.io
apt install -y docker-ce=18.06.3~ce~3-0~raspbian
apt-mark unhold docker-ce docker-ce-cli containerd.io

usermod -aG docker pi

echo
echo 'Done.'
echo 'You should reboot your Raspberry Pi.'

exit 0
