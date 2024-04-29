kubeadm join ${Loadbalancer_Public_IP}:6443 --token ${TOKEN} --discovery-token-ca-cert-hash sha256:${CA_CERT_HASH}
