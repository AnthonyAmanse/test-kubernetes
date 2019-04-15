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

# devops pipeline specific
# using build.properties to pass env variables

echo "Checking archive dir presence"
if [ -z "${ARCHIVE_DIR}" ]; then
    echo -e "Build archive directory contains entire working directory."
else
    echo -e "Copying working dir into build archive directory: ${ARCHIVE_DIR} "
    mkdir -p ${ARCHIVE_DIR}
    find . -mindepth 1 -maxdepth 1 -not -path "./$ARCHIVE_DIR" -exec cp -R '{}' "${ARCHIVE_DIR}/" ';'
fi

# If already defined build.properties from prior build job, append to it.
cp build.properties $ARCHIVE_DIR/ || :

# TEST_NODEJS_IMAGE_NAME name from build.properties will be used in deploy script
TEST_NODEJS_IMAGE_NAME=$REGISTRY_URL/$REGISTRY_NAMESPACE/$IMAGE_NAME:$GIT_COMMIT

# write to build.properties
echo "TEST_NODEJS_IMAGE_NAME=${TEST_NODEJS_IMAGE_NAME}" >> $ARCHIVE_DIR/build.properties

cat $ARCHIVE_DIR/build.properties
