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
  - host: project1.example.com
    http:
      paths:
      - path: /app1
        pathType: Prefix
        backend:
          service:
            name: project1-app1-service
            port:
              number: 80
      - path: /app2
        pathType: Prefix
        backend:
          service:
            name: project1-app2-service
            port:
              number: 80
  - host: project2.example.com
    http:
      paths:
      - path: /app1
        pathType: Prefix
        backend:
          service:
            name: project2-app1-service
            port:
              number: 80
      - path: /app2
        pathType: Prefix
        backend:
          service:
            name: project2-app2-service
            port:
              number: 80
  - host: project3.example.com
    http:
      paths:
      - path: /app1
        pathType: Prefix
        backend:
          service:
            name: project3-app1-service
            port:
              number: 80
      - path: /app2
        pathType: Prefix
        backend:
          service:
            name: project3-app2-service
            port:
              number: 80

```
