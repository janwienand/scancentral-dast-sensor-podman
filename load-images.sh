#!/bin/bash

for image in $(yq -r '.services.*.image' < docker-compose.yml ); do
   image_safe=$(echo $image | tr /: _)

   echo Loading $image from $image_safe.tar
   podman load -i $image_safe.tar
done
