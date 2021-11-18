#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
DOCKER_PATH="abdelrazekrizk/my-app:3.0.0"

# Step 2:
# Run the Docker Hub container with kubernetes
#kubectl run --generator=run-pod/v1  --image=$DOCKER_PATH --port=80
kubectl create deployment web-app --image=$DOCKER_PATH --port=8080

# Step 3:
# get the Pod name and store it in the POD_NAME environment variable"
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

# Step 4:
# Wait until your pod is running, check for "condition=ready"
#kubectl wait --for=condition=Ready pod/web-app
kubectl wait --for=condition=Ready pod/$POD_NAME --timeout=45s

# Step 5:
# #Creating a service Expose the kubectl pod container port=80 ,port=8080
kubectl expose pod $POD_NAME \
--port=8000 \
--name=webapp

# Step 6:
# List kubernetes pods
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'

# Step 7:
# port-forward the container port to a host
kubectl port-forward pod/$POD_NAME 8000:8080

# Step 8:
# log the pod
kubectl logs pod/$POD_NAME
