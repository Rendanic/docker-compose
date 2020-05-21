FROM centos:7 as helper
ARG AWS_VAULT_VERSION
ARG ANSIBLE_VERSION

RUN yum install -y epel-release ; yum install -y unzip git wget python-setuptools python-jinja2 python-yaml make python-sphinx python-pip && \
    pip install packaging && \
    wget -q https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 ; mv aws-vault-linux-amd64 aws-vault &&\
    chmod a+x aws*

RUN mkdir /git && cd /git && \
    git clone --single-branch --branch ${ANSIBLE_VERSION} --recurse-submodules https://github.com/ansible/ansible.git && \
    cd ansible

RUN cd /git/ansible && \
    echo 'oldpwd=$PWD' > ansible_profile.sh && \
    echo "cd /usr/local/ansible" >> ansible_profile.sh && \
    echo "source hacking/env-setup -q" >> ansible_profile.sh && \
    echo 'cd $oldpwd' >> ansible_profile.sh

RUN cd /git/ansible && \
    git checkout ${ANSIBLE_VERSION} && \
    git submodule update --init --recursive && \
    make && \
    bash hacking/env-setup

FROM centos:7
RUN yum install -y bash bash-completion ca-certificates cvJ vim openssh openssh-keygen groff python-jinja2 python-yaml python-argcomplete

# RUN     yum install -y python3-pip && pip3 install awscli boto boto3 ec2

RUN yum install -y python2-crypto.x86_64 && \
    curl -q "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py && rm -f get-pip.py && \
    pip install paramiko awscli boto boto3 ec2 docker 

COPY --from=helper /aws-* /bin
COPY --from=helper /git /usr/local

RUN rm -rf /usr/local/ansible/.git && \
    rm -rf /root/.local && yum clean all && \
    cd /usr/local/ansible ; bash hacking/env-setup && \
    ln -s /usr/local/ansible/ansible_profile.sh /etc/profile.d/ansible_profile.sh
CMD ["/bin/bash"]