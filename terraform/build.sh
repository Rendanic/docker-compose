#!/bin/bash
export TERRAFORM_VERSION=0.12.15
export AWS_VAULT_VERSION=4.6.4
export TERRAGRUNT_VERSION=0.19.14

cd $(dirname $(basename $0))
docker-compose  build terratools