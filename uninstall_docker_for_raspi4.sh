#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


sudo dpkg -P containerd.io
#sudo dpkg -P docker-ce-cli
sudo dpkg -P docker-ce

usermod -aG docker pi

echo 'You need to reboot.'

exit 0usermod -G "" pi

echo 'You need to reboot.'

exit 0
