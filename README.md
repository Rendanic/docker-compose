# docker-compose
Repository with some configurations for docker-compose

## terraform
This container includes the following tools:
- terraform
- terragrunt
- aws-vault
- aws-cli

The version of the container is the same like terraform. This is needed for dvelopment teams, because Terraform store the version in the statefile and automatically updates the version there. You cannot start terraform with a lower version against a statefile with higher version, which forces all teammembers to update their terraform.

The version of the other tools are always the last stable from github. aws-cli is installed from python-pip.
