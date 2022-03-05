FROM jenkins/inbound-agent:latest

USER root

RUN apt update && \
    apt install -y curl gnupg software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository 'deb [arch=amd64] https://apt.releases.hashicorp.com focal main' && \
    apt-get update && apt-get install waypoint && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /root/.local
 
USER jenkins
ENTRYPOINT ["jenkins-agent"]
