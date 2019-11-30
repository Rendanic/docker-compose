FROM ubuntu:18.04

RUN apt-get update && apt-get install -y git make sudo

RUN test -d /git/checkmk || git clone https://github.com/tribe29/checkmk.git /git/checkmk
RUN cd /git/checkmk && yes | make setup && make .venv