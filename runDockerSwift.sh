#!/bin/bash

if [[ -z "$LOCAL_SWIFT_STORAGE" ]]; then
    echo ""
    echo "Need to set LOCAL_SWIFT_STORAGE to point to local directory"
    echo "where swift data will be sored, example: export LOCAL_SWIFT_STORAGE=~/.swift"
    echo "you can set it to NONE (export LOCAL_SWIFT_STORAGE=NONE) to store"
    echo "data locally inside containter, no data presistency though "
    echo ""
    exit 1
fi

export IMAGE=ualibraries/swift_dev
if [[ "$LOCAL_SWIFT_STORAGE" = "NONE" ]]; then
    docker run -d -p 8080:8080 $IMAGE
else
    docker run -d -v $LOCAL_SWIFT_STORAGE:/srv -p 8080:8080 $IMAGE
fi
docker logs -f $(docker ps | grep $IMAGE | cut -d " " -f1)
