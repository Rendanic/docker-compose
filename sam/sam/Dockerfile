FROM python:3.7-alpine

RUN apk add --no-cache gcc musl-dev linux-headers libc-dev libffi-dev \
                       openssl-dev make docker \
    && pip install awscli aws-sam-cli