Vpa Controller installation

```
git clone https://github.com/kubernetes/autoscaler.git
cd autoscaler/vertical-pod-autoscaler
git checkout origin/vpa-release-1.0
REGISTRY=registry.k8s.io/autoscaling TAG=1.0.0 ./hack/vpa-process-yamls.sh apply
```


kubectl apply -f dep.yml
kubectl apply -f vpa.yml

kubectl exec -it traffic-generator sh
apk add --no-cache wrk
wrk -c 5 -t 5 -d 99999 -H "Connection: Closed" http://application-cpu
