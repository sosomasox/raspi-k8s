#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


if [ -f /etc/rc.local ]; then
    cp /etc/rc.local /etc/rc.local.bk
    rm -f /etc/rc.local
fi

touch /etc/rc.local
chmod 755 /etc/rc.local

while read line
do
    if [ "$line" = "systemctl daemon-reload" ]; then
        echo >> /dev/null
    else
        echo $line >> /etc/rc.local
    fi
    
done < /etc/rc.local.bk


apt-mark unhold kubeadm kubectl kubelet kubernetes-cni
apt remove --purge -y kubelet kubeadm kubectl kubernetes-cni
rm /etc/apt/sources.list.d/kubernetes.list

update-rc.d dphys-swapfile enable
dphys-swapfile install
dphys-swapfile swapon
systemctl enable dphys-swapfile

echo
echo 'Done.'

exit 0
