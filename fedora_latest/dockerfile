# dockerfile with cache
FROM fedora:latest
LABEL maintainer Markus Schaeffer <sizufly@gmail.com>

RUN dnf install -y gcc \
  	&& dnf clean all \
  	&& rm -rf /var/cache/yum


