FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        cgit \
        fcgiwrap \
        nginx-light \
        spawn-fcgi \
        git \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/cgitrc /etc/cgitrc
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh \
    && mkdir -p /run/fcgiwrap /var/cache/nginx /var/lib/git/repos

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
