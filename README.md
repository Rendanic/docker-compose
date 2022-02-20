# docker-compose
Repository with some configurations for docker-compose

## Images in dockerhub

| Image | tags| url |
|-------|-----|-----|
| rendanic/jenkins_agent-ansibleaws | 2.9, 2.10, 3, 4 | <https://hub.docker.com/r/rendanic/jenkins_agent-ansibleaws> |
| rendanic/terratools | 0.12.31, 0.13.7, 0.14.11, 0.15.5, latest 10 from 1.x | <https://hub.docker.com/r/rendanic/terratools> |

## terraform
This container includes the following tools:
- terraform
- terragrunt
- aws-vault
- aws-cli

The version of the container is the same like terraform. This is needed for dvelopment teams, because Terraform store the version in the statefile and automatically updates the version there. You cannot start terraform with a lower version against a statefile with higher version, which forces all teammembers to update their terraform.

The version of the other tools are always the last stable from github. aws-cli is installed from python-pip.
