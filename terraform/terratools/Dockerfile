
FROM alpine:latest as helper
ARG TERRAFORM_VERSION

RUN apk add unzip
RUN wget -q https://github.com/99designs/aws-vault/releases/download/v4.6.3/aws-vault-linux-amd64 ; mv aws-vault-linux-amd64 aws-vault
RUN wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v0.19.21/terragrunt_linux_amd64 ; mv terragrunt_linux_amd64 terragrunt
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ; unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip ; rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN chmod a+x terra* aws*

FROM alpine:latest
RUN apk add bash bash-completion ca-certificates git jq vim
COPY --from=helper /aws-* /bin
COPY --from=helper /terra* /bin/
CMD ["/bin/aws-vault"]

