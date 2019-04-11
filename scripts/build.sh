#!/bin/bash
echo -e "Build environment variables:"
echo "REGISTRY_URL=${REGISTRY_URL}"
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}"
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "BUILD_NUMBER=${BUILD_NUMBER}"

# Learn more about the available environment variables at:
# https://console.bluemix.net/docs/services/ContinuousDelivery/pipeline_deploy_var.html#deliverypipeline_environment

# To review or change build options use:
# bx cr build --help

echo -e "Checking for Dockerfile at the repository root"
if [ -f Dockerfile ]; then
   echo "Dockerfile found"
else
    echo "Dockerfile not found"
    exit 1
fi

echo -e "Building container image"
set -x
bx cr build -t $REGISTRY_URL/$REGISTRY_NAMESPACE/$IMAGE_NAME:$GIT_COMMIT .
set +x
