#!/bin/bash

# log in docker
docker login

# build test-nodejs
docker build -t $DOCKER_USERNAME/test-nodejs:$GIT_COMMIT .

# push image
docker push $DOCKER_USERNAME/test-nodejs:$GIT_COMMIT
