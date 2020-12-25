FROM alpine:latest as helper
ARG TERRAFORM_VERSION
ARG TERRAGRUNT_VERSION
ARG AWS_VAULT_VERSION

RUN apk add --no-cache unzip && \
    wget -q https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 ; mv aws-vault-linux-amd64 aws-vault &&\
    wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 ; mv terragrunt_linux_amd64 terragrunt && \
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ; unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip ; rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    chmod a+x terra* aws*

FROM jenkins/inbound-agent:latest
USER root

RUN apt-get update && apt-get -y install vim ca-certificates git jq vim openssh-client groff && \
    apt-get -y install python-pip && pip install awscli && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /root/.local
COPY --from=helper /aws-* /bin
COPY --from=helper /terra* /bin/

USER jenkins
ENTRYPOINT ["jenkins-agent"]