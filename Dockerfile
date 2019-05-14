FROM geoffh1977/alpine:3
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"
USER root

# Install Packages
# hadolint ignore=DL3018,DL3013
RUN apk add --update --no-cache jq groff less python3 && \
    pip3 install --no-cache-dir --upgrade pip awscli

# Install Packer
# hadolint ignore=DL3003,DL3018,DL3013
RUN wget -O /tmp/glibc-2.23-r3.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk && \
  wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.4.0/packer_1.4.0_linux_amd64.zip && \
  apk add --allow-untrusted --no-cache /tmp/glibc-2.23-r3.apk && \
  cd /usr/bin && \
  unzip /tmp/packer.zip && \
  chmod +x /usr/bin/packer && \
  rm -rf /tmp/consul.zip /tmp/glibc-2.23-r3.apk /var/cache/apk/*

USER ${ALPINE_USER}
CMD ["packer", "--help"]
