#!/bin/bash
basename=$0

# get latest tag from git-repositories
export TERRAFORM_VERSION=$(git ls-remote --tags git://github.com/hashicorp/terraform.git | cut -d"/" -f3- | cut -b2-| grep -v "\^" |  sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)
export AWS_VAULT_VERSION=$(git ls-remote --tags git://github.com/99designs/aws-vault.git | cut -d"/" -f3- | cut -b2-| grep -v "-" | sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)
export TERRAGRUNT_VERSION=$(git ls-remote --tags git://github.com/gruntwork-io/terragrunt.git | cut -d"/" -f3- | cut -b2-| sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)

cd $(dirname $basename)
# Build latest version
TERRAFORM_VERSION_latest=${TERRAFORM_VERSION}
docker-compose build terratools || exit 10

for TERRAFORM_VERSION in $(cat terraform.version | grep -v ^# | grep -v ${TERRAFORM_VERSION_latest}) ; do
   echo "Using Terraform: ${TERRAFORM_VERSION}"
   export TERRAFORM_VERSION
   docker-compose build terratools || exit 10
done