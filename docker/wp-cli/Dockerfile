FROM wordpress:cli
LABEL maintainer="jsb@phloxis.com"

# path should be relative to project root
COPY ./docker/wp-cli/docker-entrypoint-override.sh /usr/local/bin
COPY ./docker/wp-cli/wp-cli.yml /wp-cli.yml

ENTRYPOINT ["docker-entrypoint-override.sh"]