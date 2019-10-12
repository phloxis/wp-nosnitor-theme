FROM wordpress
LABEL maintainer="jsb@phloxis.com"

# path should be relative to project root
COPY ./src/ /var/www/html/wp-content/themes/nosnitor/
COPY ./docker/wp/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY ./docker/wp/docker-entrypoint-override.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint-override.sh"]