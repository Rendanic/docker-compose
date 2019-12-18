FROM ubuntu:18.04

RUN apt-get update && apt-get install -y git make sudo
RUN apt-get install -y libssl-dev

RUN test -d /git/checkmk || git clone https://github.com/tribe29/checkmk.git /git/checkmk
RUN cd /git/checkmk
RUN yes | make setup 
RUN make .venv

# ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime