FROM oraclelinux:8

LABEL maintainer="Thorsten Bruhns"

ARG TERRAFORM_VERSION
ARG TERRAGRUNT_VERSION
ARG AWS_VAULT_VERSION

RUN yum install -y oracle-epel-release-el8 && \
    yum update -y && \
    yum install -y bash bash-completion git jq vim openssh \
      python38 python38-pip unzip curl \
      postgresql && \
    pip3 install oci-cli
RUN yum clean all && rm -rf /var/cache/yum && \
    useradd -d /home/terraform -m -s /bin/bash -u 12345 terraform && \
    rm -rf /root/.local

RUN mkdir /tmp/aws && cd /tmp/aws && \
    curl -q "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/aws/awscliv2.zip" && \
      unzip awscliv2.zip && \
        cd aws && \
          ./install && \
      /usr/local/bin/aws --version && \
    echo "aws-vault" && \
      curl -L -q "https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64" -o /usr/local/bin/aws-vault && \
    echo "terragrunt" && \
      curl -L -q "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64" -o /usr/local/bin/terragrunt && \
    echo "terraform" && \
      curl -L -q "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o terraform.zip && \
      unzip terraform.zip && \
      mv terraform /usr/local/bin/terraform && \
    chmod a+x /usr/local/bin/* && \
    cd /tmp && rm -rf /tmp/aws

CMD ["su", "-u terraform", "/bin/aws-vault"]
