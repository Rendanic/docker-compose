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

RUN mkdir /git && cd /git && \
    git clone --single-branch --branch ${ANSIBLE_VERSION} --recurse-submodules https://github.com/ansible/ansible.git && \
    cd ansible && \
    git submodule update --init --recursive

# requirements.txt is not availible in old releases of Ansible
RUN test -f /git/ansible/requirements.txt \
     && pip3 install --user -r /git/ansible/requirements.txt \
     || pip3 install --user jinja2 PyYAML cryptography packaging

RUN cd /git/ansible && make && make rpm


FROM centos:7

RUN yum install -y bash bash-completion ca-certificates cvJ vim \
      openssh openssh-keygen openssh-clients groff python-jinja2 python-yaml \
      python-argcomplete less python2-crypto.x86_64

RUN curl -q "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py && rm -f get-pip.py && \
    pip install awscli boto boto3 ec2 docker 
COPY --from=helper /aws-* /bin
COPY --from=helper /git/ansible/rpm-build/ansible-2*.el7.noarch.rpm /tmp

RUN yum install -y /tmp/ansible-2*.noarch.rpm && \
    rm -rf /root/.local && yum clean all