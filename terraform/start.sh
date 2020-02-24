#!/bin/bash

export TERRAFORM_VERSION=$1

wdir=$(dirname $0)
echo ${wdir}

cd $wdir
docker-compose run --rm -u terraform -w /home/terraform/${2} terratools bash
