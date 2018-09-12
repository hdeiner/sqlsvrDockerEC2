#!/usr/bin/env bash

echo THIS IS NOT WORKING YET - USING DOCKER HUB FOR NOW

echo Stop current localRegistry Docker container
sudo -S <<< "password" docker stop localRegistry

echo Remove current localRegistry Docker container
sudo -S <<< "password" docker rm localRegistry

sudo -S <<< "password" docker run -d -p 5000:5000 \
-e "REGISTRY_STORAGE=s3" \
-e "REGISTRY_STORAGE_S3_REGION=us-east-1" \
-e "REGISTRY_STORAGE_S3_BUCKET=howarddeinerdockerregistry" \
-e "REGISTRY_STORAGE_CACHE_BLOBDESCRIPTOR=inmemory" \
--restart=always \
--name localRegistry \
registry:2