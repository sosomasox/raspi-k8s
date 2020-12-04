#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt update
apt -y install docker-ce=5:19.03.14~3-0~ubuntu-focal \
                        docker-ce-cli=5:19.03.14~3-0~ubuntu-focal \
                        containerd.io=1.3.9-1
apt-mark hold docker-ce docker-ce-cli containerd.io

usermod -aG docker ubuntu

echo
echo 'Done.'
echo 'You should reboot your Raspberry Pi.'

exit 0
