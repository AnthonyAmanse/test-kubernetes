#!/bin/bash

# devops pipeline specific

# View build properties
if [ -f build.properties ]; then
  echo "build.properties:"
  cat build.properties
else
  echo "build.properties : not found"
fi

# Make sure the cluster is running and get the ip_address
ip_addr=$(bx cs workers $PIPELINE_KUBERNETES_CLUSTER_NAME | grep normal | awk '{ print $2 }')
if [ -z $ip_addr ]; then
  echo "$PIPELINE_KUBERNETES_CLUSTER_NAME not created or workers not ready"
  exit 1
fi

# substitute image name
sed -i 's/TEST_NODEJS_IMAGE_NAME/'"$TEST_NODEJS_IMAGE_NAME"'/g' manifests/test.yaml

# show yaml file
cat manifests/test.yaml

# apply all yaml files in manifests folder
kubectl apply -f manifests

# get k8s resources
kubectl get ingress
kubectl get svc
kubectl get pods
