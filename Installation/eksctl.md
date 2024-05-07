# Install aws-cli & kubectl & eksctl and run below command
```
eksctl create cluster --name muruli --version 1.24 --region ap-south-1 --nodegroup-name worker-nodes --node-type t2.micro --nodes 2


###Delete Worker Grp First
aws eks --region ap-south-1 delete-nodegroup --cluster-name muruli --nodegroup-name worker-nodes
aws eks --region ap-south-1 describe-nodegroup --cluster-name muruli --nodegroup-name worker-nodes --query "nodegroup.status" 


##Delete Cluster EKS
aws eks --region ap-south-1 delete-cluster --name muruli
aws eks --region ap-south-1 describe-cluster --name muruli --query "cluster.status"   

```
