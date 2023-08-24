---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sentence-generator
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  selector:
    matchLabels:
      app: sentence-generator
  template:
    metadata:
      labels:
        app: sentence-generator
    spec:
      containers:
        - name: generator
          image: ghcr.io/f5devcentral/sentence-demo-app/sentence-generator:v2.0
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
  name: sentence-generator
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  type: ClusterIP
  selector:
    app: sentence-generator
  ports:
    - name: http
      port: 80
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sentence-colors
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  selector:
    matchLabels:
      app: sentence-colors
  template:
    metadata:
      labels:
        app: sentence-colors
    spec:
      containers:
        - name: colors
          image: ghcr.io/f5devcentral/sentence-demo-app/sentence-colors:v2.0
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
  name: sentence-colors
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  type: ClusterIP
  selector:
    app: sentence-colors
  ports:
    - name: http
      port: 80
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sentence-adjectives
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  selector:
    matchLabels:
      app: sentence-adjectives
  template:
    metadata:
      labels:
        app: sentence-adjectives
    spec:
      containers:
        - name: adjectives
          image: ghcr.io/f5devcentral/sentence-demo-app/sentence-adjectives:v2.0
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
  name: sentence-adjectives
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  type: ClusterIP
  selector:
    app: sentence-adjectives
  ports:
    - name: http
      port: 80
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sentence-animals
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  selector:
    matchLabels:
      app: sentence-animals
  template:
    metadata:
      labels:
        app: sentence-animals
    spec:
      containers:
        - name: animals
          image: ghcr.io/f5devcentral/sentence-demo-app/sentence-animals:v2.0
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
  name: sentence-animals
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  type: ClusterIP
  selector:
    app: sentence-animals
  ports:
    - name: http
      port: 80
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sentence-locations
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  selector:
    matchLabels:
      app: sentence-locations
  template:
    metadata:
      labels:
        app: sentence-locations
    spec:
      containers:
        - name: locations
          image: ghcr.io/f5devcentral/sentence-demo-app/sentence-locations:v2.0
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
  name: sentence-locations
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  type: ClusterIP
  selector:
    app: sentence-locations
  ports:
    - name: http
      port: 80
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sentence-backgrounds
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  selector:
    matchLabels:
      app: sentence-backgrounds
  template:
    metadata:
      labels:
        app: sentence-backgrounds
    spec:
      containers:
        - name: backgrounds
          image: ghcr.io/f5devcentral/sentence-demo-app/sentence-backgrounds:v2.0
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
  name: sentence-backgrounds
  annotations:
    ves.io/site: ${app_deployment_region}
    ves.io/site-name: ${virtual_site_name}
spec:
  type: ClusterIP
  selector:
    app: sentence-backgrounds
  ports:
    - name: http
      port: 80
      targetPort: 8080
