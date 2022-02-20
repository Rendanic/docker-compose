#!/bin/bash
basename=$0

docker_credentials=~/.docker/config.json
docker_owner=rendanic
containername="jenkins_agent-ansibleaws"
export VERSION="$1"
export ANSIBLE_VERSION="$VERSION"

work_docker() {

   VERSION="$1"
   dockerhubtag="$1"
   
   echo "#################################################"
   echo "#################################################"
   echo "Vrsion: ${VERSION}"
   docker-compose -f docker-compose_build.yml build "$containername"

   dockerimage="$containername:${VERSION}"
   docker tag "${dockerimage}" "$docker_owner/$containername:${dockerhubtag}"
   test -f "$docker_credentials" && docker push "$docker_owner/$containername:${dockerhubtag}"
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
AWS_VAULT_VERSION=$(git ls-remote --tags git://github.com/99designs/aws-vault.git | cut -d"/" -f3- | cut -b2-| grep -v "-" | sort -t. -k 1,1n -k 2,2n -k 3,3n | tail -1)
export AWS_VAULT_VERSION

workdir=$(dirname "$basename")
cd "$workdir"

work_docker "$VERSION"

echo "Remove Docker credentials"
if [ -f "$docker_credentials" ] ; then
   rm -f "$docker_credentials"
fi