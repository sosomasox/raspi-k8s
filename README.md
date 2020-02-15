# Setup_Kubernetes_for_RaspberryPi

## init process for master
>*sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.3.254 --ignore-preflight-errors=SystemVerification --kubernetes-version v1.10.5*

>*sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.3.254 --token-ttl=0 --ignore-preflight-errors=SystemVerification --kubernetes-version v1.10.5*
