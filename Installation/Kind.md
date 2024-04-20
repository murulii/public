
```

sudo apt update
sudo apt install -y docker.io

sudo apt update
sudo snap install kubectl --classic


# Download the KinD binary
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64

# Make the binary executable
chmod +x ./kind

# Move the binary to a directory in your PATH
sudo mv ./kind /usr/local/bin/kind


```

```
kind version

```
```
nano kind-config.yaml
# add below code
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker



```

`kind create cluster --config kind-config.yaml`



`kubectl cluster-info`




```
