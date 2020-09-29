FROM alpine:3

RUN apk add --no-cache --update bash curl openssl ca-certificates jq vim

COPY src/ /opt/resource/

RUN chmod +x /opt/resource/*
