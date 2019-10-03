#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


apt-mark unhold docker-ce
apt remove -y --purge docker-ce
rm /etc/apt/sources.list.d/docker.list


exit 0
