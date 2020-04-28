#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo 'You are not root.'
    echo 'You need to be root authority to execute.'
    exit 1
fi

apt-mark unhold kubeadm kubectl kubelet kubernetes-cni
apt remove --purge -y kubelet kubeadm kubectl kubernetes-cni
rm /etc/apt/sources.list.d/kubernetes.list

echo
echo 'Done.'

exit 0
