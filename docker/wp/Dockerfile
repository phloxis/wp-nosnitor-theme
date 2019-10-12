FROM wordpress
LABEL maintainer="jsb@phloxis.com"

COPY ./docker-entrypoint-override.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint-override.sh"]