#!/bin/bash
#
# Script for building all Containers for Ansible from 2.2-2.9
#
dir=$(dirname $(basename $0))

for stable in $(git ls-remote --heads git://github.com/ansible/ansible.git | cut -d"/" -f3- | grep "^stable-2.[2-9]") ; do
#   "$dir/build.sh" "$stable"
   "ansibleaws/build.sh" "$stable"
done