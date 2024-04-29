#!/bin/bash
set -xe

cat <<EOF > /etc/systemd/system/etcd.service
[Unit]
Description=etcd

[Service]
ExecStart=/usr/local/bin/etcd \\
  --name infra0 \\
  --initial-advertise-peer-urls https://${current-vm-private-ip}:2380 \
  --listen-peer-urls https://${current-vm-private-ip}:2380 \\
  --listen-client-urls https://${current-vm-private-ip}:2379,https://127.0.0.1:2379 \\
  --advertise-client-urls https://${current-vm-private-ip}:2379 \\
  --initial-cluster-token etcd-cluster-1 \\
  --initial-cluster infra0=https://${current-vm-private-ip}:2380,infra1=https://${other-vms-private-ip}:2380,infra2=https://${other-vms-private-ip}:2380 \\
  --log-outputs=/var/lib/etcd/etcd.log \\
  --initial-cluster-state new \\
  --peer-auto-tls \\
  --snapshot-count '10000' \\
  --wal-dir=/var/lib/etcd/wal \\
  --client-cert-auth \\
  --trusted-ca-file=/var/lib/etcd/ca.pem \\
  --cert-file=/var/lib/etcd/etcd.pem \\
  --key-file=/var/lib/etcd/etcd-key.pem \\
  --data-dir=/var/lib/etcd/data
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable etcd
