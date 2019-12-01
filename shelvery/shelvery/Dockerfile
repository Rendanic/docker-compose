FROM alpine:latest as helper
ARG AWS_VAULT_VERSION
RUN wget -q https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 ; mv aws-vault-linux-amd64 aws-vault ;\
    chmod a+x aws*

FROM python:3
RUN pip install shelvery
COPY --from=helper /aws-* /bin