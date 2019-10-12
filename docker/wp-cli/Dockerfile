FROM wordpress:cli
LABEL maintainer="jsb@phloxis.com"

# path should be relative to project root
COPY ./docker/wp-cli/docker-entrypoint-override.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint-override.sh"]