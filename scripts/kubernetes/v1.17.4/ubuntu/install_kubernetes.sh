#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add 
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt install -y kubelet=1.17.4-00 kubeadm=1.17.4-00 kubectl=1.17.4-00 kubernetes-cni=0.7.5-00


systemctl daemon-reload
systemctl restart kubelet.service
apt-mark hold kubeadm kubectl kubelet kubernetes-cni

echo
echo 'Done.'

exit 0

