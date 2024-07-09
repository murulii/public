************Install IngressController Setup*************

helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace

or

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
## To acess application using masterIP:nodeport enable/edit svc Loadbalancer to Nodeport
------*******************************************************-------


*************Ingress Resource******************

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: path-based-ingress
spec:
  ingressClassName: nginx  ##You should add this class name nginx
  rules:
    - host:   # if you have dns and loadbalancer Replace with your domain or omit for wildcard.
      http:
        paths:
          - path: /
            pathType: Prefix  # Use "Exact" for exact path matching, "Prefix" for prefix matching.
            backend:
              service:
                name: nginx-service  # Replace with the name of your Service or Deployment.
                port:
                  number: 80  # Replace with the port of your Service.

------******************************************************************************************---------------

*****************To acess application using ingress************************************************************

masterip:ingress-svc-nodeport-number/path of application
