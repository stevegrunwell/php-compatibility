FROM php:7-alpine

RUN set -eux; \
  apk add --no-cache \
  bash \
  unzip

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY phpcs.xml.dist /app/phpcs.xml.dist
COPY vendor /app/vendor
WORKDIR /app

# Route the request through the shell script.
ENTRYPOINT [ "/bin/sh", "/docker-entrypoint.sh"]
