# Project

```

apiVersion: apps/v1
kind: Deployment
metadata:
  name: pro
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pro
  template:
    metadata:
      labels:
        app: pro
    spec:
      containers:
      - name: apache
        image: httpd:latest
        ports:
        - containerPort: 80
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        volumeMounts:
        - name: html
          mountPath: /usr/local/apache2/htdocs/
      volumes:
      - name: html
        configMap:
          name: pro-html
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: pro-html
data:
  index.html: |
    <html>
    <body>
      <h1>This is pro pod</h1>
      <p>Pod Name: $(POD_NAME)</p>
    </body>
    </html>

---
apiVersion: v1
kind: Service
metadata:
  name: pro-service
spec:
  selector:
    app: pro
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer

```

# project-1

```

apiVersion: apps/v1
kind: Deployment
metadata:
  name: pro1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pro1
  template:
    metadata:
      labels:
        app: pro1
    spec:
      containers:
      - name: apache
        image: httpd:latest
        ports:
        - containerPort: 80
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        volumeMounts:
        - name: html
          mountPath: /usr/local/apache2/htdocs/
      volumes:
      - name: html
        configMap:
          name: pro1-html
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: pro1-html
data:
  index.html: |
    <html>
    <body>
      <h1>This is pro1 pod</h1>
      <p>Pod Name: $(POD_NAME)</p>
    </body>
    </html>
---
apiVersion: v1
kind: Service
metadata:
  name: pro1-service
spec:
  selector:
    app: pro1
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```

# Project-2

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pro2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pro2
  template:
    metadata:
      labels:
        app: pro2
    spec:
      containers:
      - name: apache
        image: httpd:latest
        ports:
        - containerPort: 80
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        volumeMounts:
        - name: html
          mountPath: /usr/local/apache2/htdocs/
      volumes:
      - name: html
        configMap:
          name: pro2-html
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: pro2-html
data:
  index.html: |
    <html>
    <body>
      <h1>This is pro2 pod</h1>
      <p>Pod Name: $(POD_NAME)</p>
    </body>
    </html>
---
apiVersion: v1
kind: Service
metadata:
  name: pro2-service
spec:
  selector:
    app: pro2
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer

```
