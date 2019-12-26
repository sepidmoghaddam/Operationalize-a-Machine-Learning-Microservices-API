#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath="sepid/udacity_project:latest"

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run udacity-project --image=$dockerpath --port=80

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4
# Make Prediction
# Save first pod's name in the POD variable
POD=$(kubectl get pod -o jsonpath="{.items[0].metadata.name}")  
# Post prediction request
kubectl exec $POD -- curl -d '{  
   "CHAS":{  
      "0":0
   },
   "RM":{  
      "0":6.575
   },
   "TAX":{  
      "0":296.0
   },
   "PTRATIO":{  
      "0":15.3
   },
   "B":{  
      "0":396.9
   },
   "LSTAT":{  
      "0":4.98
   }
}'\
     -H "Content-Type: application/json" \
     -X POST http://localhost/predict



# Step 5:
# Forward the container port to a host
kubectl port-forward deployment/udacity-project 8000:80

