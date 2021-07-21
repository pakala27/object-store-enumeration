#!/bin/bash

set -u -e

DEFAULT_REGION=${DEFAULT_REGION}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
DEFAULT_OUTPUT=${DEFAULT_OUTPUT}

function env_check() {
  echo "Checking ENV variables"
  if [[ "${AWS_ACCESS_KEY_ID}" == "" || "${AWS_SECRET_ACCESS_KEY}" == "" ]]; then
    echo "Please set correct AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY"
    exit 1
  fi
}

function configure_awscli() {
  echo "Configuring AWS CLI" 
  aws configure set default.region ${DEFAULT_REGION} --profile coding
  aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID} --profile coding
  aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY} --profile coding
  aws configure set default.output ${DEFAULT_OUTPUT} --profile coding
}

function enumerate_objectstore() {
  while true; do
  echo "==========================================="
  echo " Welcome to object store enumeration tool"
  echo "==========================================="
  echo "Enumerating content from the object s3://terraform-challenge-bucket-2 "
  aws s3 ls s3://terraform-challenge-bucket-2 --recursive --profile coding
  #Running the function in infinite loop to just kepp the script alive
  sleep 30
  done
} 

env_check
configure_awscli
enumerate_objectstore

