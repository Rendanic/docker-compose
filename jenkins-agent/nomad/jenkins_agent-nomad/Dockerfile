FROM oraclelinux:7 as helper

RUN yum install -y yum-utils
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
RUN yum -y install nomad vault

RUN yum install -y wget unzip && wget -q -O /tmp/nomad-pack.zip https://github.com/hashicorp/nomad-pack/releases/download/nightly/nomad-pack_0.0.1-techpreview3_linux_amd64.zip &&\
    cd /tmp && unzip /tmp/nomad-pack.zip && chmod a+x /tmp/nomad-pack


FROM jenkins/inbound-agent:latest

USER root

RUN apt-get update && \
    apt-get -y install vim ca-certificates git jq vim openssh-client sshpass groff

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /root/.local

COPY --from=helper /tmp/nomad-pack /usr/local/bin
COPY --from=helper /bin/nomad /usr/local/bin
COPY --from=helper /bin/vault /usr/local/bin

USER jenkins
ENTRYPOINT ["jenkins-agent"]
