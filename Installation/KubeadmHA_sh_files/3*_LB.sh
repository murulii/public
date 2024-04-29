
#!/bin/bash
set -xe

sudo apt update
sudo apt install haproxy -y
sleep 2s
sudo systemctl start haproxy && sudo systemctl enable haproxy

cat <<EOF > haproxy.cfg
frontend kubernetes-frontend
  bind *:6443
  mode tcp
  option tcplog
  timeout client 10s
  default_backend kubernetes-backend

backend kubernetes-backend
  timeout connect 10s
  timeout server 10s
  mode tcp
  option tcp-check
  balance roundrobin

  server k3sserver-0 ${Controlplane_Private_IP_0}:6443 check
  server k3sserver-1 ${Controlplane_Private_IP_1}:6443 check
  server k3sserver-2 ${Controlplane_Private_IP_2}:6443 check

frontend nodeport-frontend
  bind *:30000-35000
  mode tcp
  option tcplog
  timeout client 10s
  default_backend nodeport-backend

backend nodeport-backend
  mode tcp
  timeout connect 10s
  timeout server 10s
  balance roundrobin

  server nodeport-0 ${Controlplane_Private_IP_0}
  server nodeport-1 ${Controlplane_Private_IP_1}
  server nodeport-2 ${Controlplane_Private_IP_2}

EOF

sudo mv haproxy.cfg /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy
haproxy -f /etc/haproxy/haproxy.cfg -c

