#!/bin/bash


if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi


curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add 
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt install -y kubelet=1.19.4-00 kubeadm=1.19.4-00 kubectl=1.19.4-00 cri-tools=1.13.0-01 kubernetes-cni=0.8.7-00
apt-mark hold kubelet kubeadm kubectl cri-tools kubernetes-cni

systemctl daemon-reload
systemctl restart kubelet.service

echo
echo 'Done.'

exit 0
