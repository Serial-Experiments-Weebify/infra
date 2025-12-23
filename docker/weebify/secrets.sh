#!/bin/env bash


# check before overwriting
if [ -f ./secrets/searchKey.txt ] || \
   [ -f ./secrets/s3Secret.txt ] || \
   [ -f ./secrets/s3AccessKey.txt ] || \
   [ -f ./secrets/mongoSecret.txt ] || \
   [ -f ./secrets/authJwtKey.txt ] || \
   [ -f ./secrets/mongoRootSecret.txt ]; then
  echo "Refusing to overwrite existing secrets!"
  exit
fi

if [ ! -d ./secrets ]; then
  mkdir ./secrets
fi

openssl rand -base64 48 > ./secrets/searchKey.txt
openssl rand -base64 48 > ./secrets/s3Secret.txt
openssl rand -base64 48 > ./secrets/s3AccessKey.txt
openssl rand -base64 48 > ./secrets/mongoSecret.txt
openssl rand -base64 48 > ./secrets/authJwtKey.txt
openssl rand -base64 48 > ./secrets/mongoRootSecret.txt