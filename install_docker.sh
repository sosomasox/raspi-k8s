#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi

# if you added "cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1" to /boot/cmdline.txt, you can install docker below command
curl -sSL https://get.docker.com | sh
apt remove -y --purge docker-ce
apt install -y docker-ce=18.06.1~ce~3-0~raspbian
apt-mark hold docker-ce
usermod -aG docker pi
reboot

echo 'You need to reboot.'


exit 0
