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
apt install -y kubelet=1.10.5-00 kubeadm=1.10.5-00 kubectl=1.10.5-00 kubernetes-cni=0.6.0-00


if [ -f /etc/systemd/system/kubelet.service.d/10-kubeadm.conf ]; then
    cp /etc/systemd/system/kubelet.service.d/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf.bk

    echo "[Service]" > /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_SYSTEM_PODS_ARGS=--pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_NETWORK_ARGS=--network-plugin=cni --cni-conf-dir=/etc/cni/net.d --cni-bin-dir=/opt/cni/bin\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "#Environment=\"KUBELET_DNS_ARGS=--cluster-dns=10.96.0.10 --cluster-domain=cluster.local\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_DNS_ARGS=--cluster-dns=10.244.0.10 --cluster-domain=cluster.local\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_AUTHZ_ARGS=--authorization-mode=Webhook --client-ca-file=/etc/kubernetes/pki/ca.crt\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_CADVISOR_ARGS=--cadvisor-port=0\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_CERTIFICATE_ARGS=--rotate-certificates=true --cert-dir=/var/lib/kubelet/pki\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "Environment=\"KUBELET_SYSTEM_PODS_ARGS=--pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true --fail-swap-on=false\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "ExecStart=" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    echo "ExecStart=/usr/bin/kubelet \$KUBELET_KUBECONFIG_ARGS \$KUBELET_SYSTEM_PODS_ARGS \$KUBELET_NETWORK_ARGS \$KUBELET_DNS_ARGS \$KUBELET_AUTHZ_ARGS \$KUBELET_CADVISOR_ARGS \$KUBELET_CERTIFICATE_ARGS \$KUBELET_EXTRA_ARGS" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

fi


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


exit 0
