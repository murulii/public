```

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: combined-ingress
  namespace: mynamespace
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: pro.muruli1.shop
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: pro-service
            port:
              number: 80


      
  - host: pro1.muruli1.shop
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: pro1-service
            port:
              number: 80



      
  - host: pro2.muruli1.shop
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: pro2-service
            port:
              number: 80
      

```
