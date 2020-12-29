FROM centos:7 as helper
ARG AWS_VAULT_VERSION

RUN yum install -y epel-release && \
    yum install -y unzip git wget make rpm-build which PyYAML asciidoc\
        python36 python36-pip python36-docutils  \
        python-pip python2-devel python-sphinx python2-cryptography python-six pytest python-requests python-coverage python-mock \
        python-boto3 python-paramiko python-jmespath python-passlib python-virtualenv && \
    pip install packaging 2>/dev/null && \
    pip3 install --user straight.plugin

RUN wget -q -O aws-vault https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 &&\
    chmod a+x aws*

ARG ANSIBLE_VERSION

FROM jenkins/inbound-agent:latest
USER root

RUN apt-get update && \
    apt-get -y install vim ca-certificates git jq vim openssh-client groff && \
    apt-get -y install python-pip && \
    pip install awscli boto boto3 ec2 docker ansible==2.8.18 && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /root/.local

COPY --from=helper /aws-* /bin

USER jenkins
ENTRYPOINT ["jenkins-agent"]