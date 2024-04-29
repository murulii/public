kubeadm certs certificate-key # copy the output IMPORTANT

cat <<EOF > kubeadm-config.yml
apiVersion: kubeadm.k8s.io/v1beta3
kind: InitConfiguration
bootstrapTokens:
- groups:
  - system:bootstrappers:kubeadm:default-node-token
  token: ${some random string}  # important thing to set as it will be used when joining nodes to the k8s cluster.
  ttl: 24h0m0s
  usages:
  - signing
  - authentication

certificateKey: ${get it from the output of kubeadm certs certificate-key command}
nodeRegistration:
  criSocket: unix:///var/run/containerd/containerd.sock
  imagePullPolicy: IfNotPresent
  taints: null
---
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
apiServer:
  timeoutForControlPlane: 4m0s
  certSANs:
    - "${public ip of loadbalancer}" # <pub ip of lb>
    - "127.0.0.1"
certificatesDir: /etc/kubernetes/pki
clusterName: kubernetes
controllerManager: {}
dns: {}
etcd:
  external:
    endpoints:
    - "https://${private ip of the etcd 0}:2379"
    - "https://${private ip of the etcd 1}:2379"
    - "https://${private ip of the etcd 2}:2379"
    caFile: "/etcd/kubernetes/pki/etcd/ca.pem"
    certFile: "/etcd/kubernetes/pki/etcd/etcd.pem"
    keyFile: "/etcd/kubernetes/pki/etcd/etcd-key.pem"
imageRepository: registry.k8s.io
kubernetesVersion: 1.28.0
controlPlaneEndpoint: "${public ip of loadbalancer}:6443"
networking:
  dnsDomain: cluster.local
  serviceSubnet: 10.96.0.0/12
scheduler: {}

EOF


kubeadm init --config kubeadm-config.yml --upload-certs


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

