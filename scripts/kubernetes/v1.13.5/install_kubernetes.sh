#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


systemctl disable dphys-swapfile
dphys-swapfile swapoff
dphys-swapfile uninstall
update-rc.d dphys-swapfile disable

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add 
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt install -y kubelet=1.13.5-00 kubeadm=1.13.5-00 kubectl=1.13.5-00 kubernetes-cni=0.7.5-00


systemctl daemon-reload
systemctl restart kubelet.service
apt-mark hold kubeadm kubectl kubelet kubernetes-cni


if [ -f /etc/rc.local ]; then
    cp /etc/rc.local /etc/rc.local.bk
    rm -f /etc/rc.local
fi


touch /etc/rc.local
chmod 755 /etc/rc.local


while read line
do
    if [ "$line" = "exit 0" ]; then
        echo "systemctl daemon-reload" >> /etc/rc.local
        echo >> /etc/rc.local
    fi
    
    echo $line >> /etc/rc.local
done < /etc/rc.local.bk

echo
echo 'Done.'

exit 0

