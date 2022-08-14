#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "Usage: ./create_post.sh my-post"
    exit -1
fi

NAME=$1
YEAR=$(date +"%Y")
MONTH=$(date +%m)

hugo new --kind post post/${YEAR}/${MONTH}/${NAME}
