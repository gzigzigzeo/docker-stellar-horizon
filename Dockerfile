FROM debian:jessie-slim

MAINTAINER Viktor Sokolov <gzigzigzeo@evilmartians.com>

ARG HORIZON_VERSION=0.11.0
ENV STELLAR_TAR_URL "https://github.com/stellar/horizon/releases/download/v${HORIZON_VERSION}/horizon-v${HORIZON_VERSION}-linux-amd64.tar.gz"

RUN mkdir -p /usr/share/man/ \
  && mkdir -p /usr/share/man/man1 \
  && mkdir -p /usr/share/man/man2 \
  && mkdir -p /usr/share/man/man3 \
  && mkdir -p /usr/share/man/man4 \
  && mkdir -p /usr/share/man/man5 \
  && mkdir -p /usr/share/man/man6 \
  && mkdir -p /usr/share/man/man7 \
  && mkdir -p /usr/share/man/man8 \
  && mkdir -p /usr/share/man/man9

RUN apt-get update && apt-get install -y curl ca-certificates postgresql-client && apt-get clean

RUN curl -f -L -o horizon.tar.gz $STELLAR_TAR_URL \
  && tar -zxvf horizon.tar.gz \
  && mv /horizon-v${HORIZON_VERSION}-linux-amd64/horizon /usr/local/bin \
  && chmod +x /usr/local/bin/horizon \
  && rm -rf horizon.tar.gz /horizon-v${HORIZON_VERSION}-linux-amd64

# Settings
ENV DOCKER_STELLAR_HORIZON_DATABASE_URL "postgres://gzigzigzeo@docker.for.mac.localhost/horizon"
ENV DOCKER_STELLAR_HORIZON_STELLAR_CORE_DATABASE_URL "postgres://gzigzigzeo@docker.for.mac.localhost/core"
ENV DOCKER_STELLAR_HORIZON_STELLAR_CORE_URL="http://core:11626"
ENV LOG_LEVEL="info"
ENV INGEST="true"
ENV PER_HOUR_RATE_LIMIT="72000"

ENTRYPOINT "/bin/sh"

# Healthcheck & Entrypoint
#COPY docker_entrypoint.sh /
#RUN chmod +x /docker_entrypoint.sh

#COPY docker_healthcheck.sh /
#RUN chmod +x /docker_healtcheck.sh

#ENTRYPOINT ["/docker_entrypoint.sh"]
#CMD ["stellar-core", "--conf", "/etc/stellar-core.cfg"]
#EXPOSE 8000

#HEALTHCHECK CMD ["/docker_healthcheck.sh"]
