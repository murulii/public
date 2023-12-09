# Generate some traffic
**Let's deploy a simple traffic generator pod**

`traffic-generator.yaml`

```
apiVersion: v1
kind: Pod
metadata:
  name: traffic-generator
spec:
  containers:
  - name: alpine
    image: alpine
    args:
    - sleep
    - "100000000"
```
```
cd kubernetes\autoscaling\components\application
kubectl apply -f .\traffic-generator.yaml

# get a terminal to the traffic-generator
kubectl exec -it traffic-generator sh

# install wrk
apk add --no-cache wrk

# simulate some load
wrk -c 5 -t 5 -d 99999 -H "Connection: Close" http://application-cpu

```
```
#you can scale to pods manually and see roughly 6-7 pods will satisfy resource requests.

kubectl scale deploy/application-cpu --replicas 2
````
