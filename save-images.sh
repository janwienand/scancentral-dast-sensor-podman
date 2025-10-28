#!/bin/bash

source .env

for image in $(yq -r '.services.*.image' < docker-compose.yml ); do
   image_safe=$(echo $image | tr /: _)

   echo Pulling $image
   podman pull $image
   echo Saving $image to $image_safe.tar
   podman save $image -o $image_safe.tar
done
