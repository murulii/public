
scp -i ksctl-key ca.pem etcd.pem etcd-key.pem root@${etcd-0}:/var/lib/etcd
scp -i ksctl-key ca.pem etcd.pem etcd-key.pem root@${etcd-1}:/var/lib/etcd
scp -i ksctl-key ca.pem etcd.pem etcd-key.pem root@${etcd-2}:/var/lib/etcd



scp -i ksctl-key ca.pem etcd.pem etcd-key.pem root@${Controlplane_Private_IP_0}:/etcd/kubernetes/pki/etcd/
scp -i ksctl-key ca.pem etcd.pem etcd-key.pem root@${Controlplane_Private_IP_1}:/etcd/kubernetes/pki/etcd/
scp -i ksctl-key ca.pem etcd.pem etcd-key.pem root@${Controlplane_Private_IP_2}:/etcd/kubernetes/pki/etcd/


