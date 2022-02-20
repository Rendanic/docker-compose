FROM oraclelinux:7 as helper

ARG AWS_VAULT_VERSION

RUN yum install -y wget unzip && wget -q -O aws-vault https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 &&\
    chmod a+x aws*


FROM jenkins/inbound-agent:latest

ARG ANSIBLE_VERSION

USER root

RUN apt-get update && \
    apt-get -y install vim ca-certificates git jq vim openssh-client sshpass groff && \
    apt-get -y install python3-pip python3-docker && \
    python3 -m pip install --user --upgrade pip && \
    pip3 install awscli boto boto3 ec2 docker
RUN pip3 install ansible==${ANSIBLE_VERSION} && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /root/.local

COPY --from=helper /aws-* /bin

USER jenkins
ENTRYPOINT ["jenkins-agent"]
