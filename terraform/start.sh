#!/bin/bash

export TERRAFORM_VERSION=$1

wdir=$(dirname $0)
echo ${wdir}

cd $wdir
docker-compose run --rm -u ${containeruser:-"$USER"} -e HOME=/home/terraform -w ${2:-"/home/terraform/"} terratools bash