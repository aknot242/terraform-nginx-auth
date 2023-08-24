apiVersion: apps/v1
kind: Deployment
metadata:
  name: sentence-frontend-nginx
  annotations:
    ves.io/virtual-sites: ${virtual_site_name}
spec:
  selector:
    matchLabels:
      app: sentence-frontend-nginx
  template:
    metadata:
      labels:
        app: sentence-frontend-nginx
    spec:
      containers:
        - name: frontend-nginx
          image: ghcr.io/f5devcentral/sentence-demo-app/sentence-nginx-webapp:v2.0
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
          env:
            - name: PREFIX
              value: "sentence"
            - name: NAMESPACE
              value: "${namespace}"
---
apiVersion: v1
kind: Service
metadata:
  name: sentence-frontend-nginx
  annotations:
    ves.io/virtual-sites: ${virtual_site_name}
spec:
  type: ClusterIP
  selector:
    app: sentence-frontend-nginx
  ports:
    - name: http
      port: 80
      targetPort: 8080
