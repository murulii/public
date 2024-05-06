
# Steps
1) Create s3 bucket
2) install kops
3) install aws cli and configure it
 

```
# v1.28.3


wget https://github.com/kubernetes/kops/releases/download/v1.28.3/kops-linux-amd64

sudo mv kops-linux-amd64 /usr/local/bin/kops

sudo chmod +x /usr/local/bin/kops

kops version
kops help

# create cluster config one zone and when u apply this it will create configuration not cluster to create cluster using this configuration you should apply kops update cmd 

kops create cluster \
  --name=my-cluster.k8s.local \
  --state=s3://my-kops-state-store \
  --zones=us-west-2a \
  --node-count=3 \
  --node-size=t2.micro \
  --master-size=t2.micro \
  --kubernetes-version 1.16.0 \  //for latest no need to specifiy this
  --dns-zone=my-cluster.k8s.local


```
