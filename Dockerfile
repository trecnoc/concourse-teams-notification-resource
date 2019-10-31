FROM python:3.7-alpine
ENV PACKAGES "bash curl openssl ca-certificates jq vim"
RUN apk add --update "${PACKAGES}" && rm -rf /var/cache/apk/*
RUN pip install --upgrade pip
COPY assets/ /opt/resource/
RUN pip install -r /opt/resource/requirements.txt
RUN chmod +x /opt/resource/*