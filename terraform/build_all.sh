#!/bin/bash
basename=$0

docker_credentials=~/.docker/config.json
docker_owner=rendanic

work_docker() {

   TERRAFORM_VERSION="$1"
   dockerhubtag="$2"
   echo "#################################################"
   echo "#################################################"
   echo "Terraform version: ${TERRAFORM_VERSION}"
   docker-compose -f docker-compose_build.yml build terratools

   dockerimage="terratools:${TERRAFORM_VERSION}"
   docker tag "${dockerimage}" "$docker_owner/terratools:${dockerhubtag}"
   test -f "$docker_credentials" && docker push "$docker_owner/terratools:${dockerhubtag}"
}

# shellcheck disable=SC2154
if [ "$dockerpass" -a "$dockeruser" ] ; then

   # shellcheck disable=SC2154
   echo "$dockerpass" | docker login --password-stdin -u "$dockeruser"
   if [ "$?" -ne 0 ] ; then
      echo "Login to dockerhub failed. Username: $dockeruser"
      rm -f "$docker_credentials"
      exit 9
   fi
fi

# get latest tag from git-repositories
TERRAFORM_VERSION=$(git ls-remote --tags git://github.com/hashicorp/terraform.git | cut -d"/" -f3- | cut -b2-| grep -v "\^" |  sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)
AWS_VAULT_VERSION=$(git ls-remote --tags git://github.com/99designs/aws-vault.git | cut -d"/" -f3- | cut -b2-| grep -v "-" | sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)
TERRAGRUNT_VERSION=$(git ls-remote --tags git://github.com/gruntwork-io/terragrunt.git | cut -d"/" -f3- | cut -b2-| sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)
export TERRAFORM_VERSION AWS_VAULT_VERSION TERRAGRUNT_VERSION

workdir=$(dirname "$basename")
cd "$workdir"
# Build latest version
work_docker "$TERRAFORM_VERSION" "latest"

grep -v '^#' < terraform.version | while IFS= read -r TERRAFORM_VERSION
do
   echo "Using Terraform: ${TERRAFORM_VERSION}"
   export TERRAFORM_VERSION
   work_docker "$TERRAFORM_VERSION" "$TERRAFORM_VERSION"
done

echo "Remove Docker credentials"
if [ -f "$docker_credentials" ] ; then
   rm -f "$docker_credentials"
fi