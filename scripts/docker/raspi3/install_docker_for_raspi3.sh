#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


curl -sSL https://get.docker.com | sh
apt remove --purge -y docker-ce docker-ce-cli containerd.io
apt install -y docker-ce=5:19.03.8~3-0~raspbian-stretch
apt-mark unhold docker-ce docker-ce-cli containerd.io

usermod -aG docker pi

echo
echo 'Done'
echo 'You should reboot your Raspberry Pi.'

exit 0
