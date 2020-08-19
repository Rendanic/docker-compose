#!/bin/bash

export TERRAFORM_VERSION=$1
export containeruser="${containeruser:-"$USER"}"
export userhome=$(getent passwd | grep "^${containeruser}:" | cut -d":" -f6 )
export TERRAGRUNT_DOWNLOAD="${userhome}/.terragrunt_cache_docker"
wdir=$(dirname $0)
echo ${wdir}

cd $wdir
docker-compose run --rm -u ${containeruser} -e HOME="${userhome}" -e TERRAGRUNT_DOWNLOAD="$TERRAGRUNT_DOWNLOAD" -w ${2:-"/home/terraform/"} terratools bash