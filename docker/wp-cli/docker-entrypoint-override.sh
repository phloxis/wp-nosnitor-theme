#!/bin/bash

# sleep until wordpress is up
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' wordpress:80)" != "302" ]]; do echo ''Waiting for wordpress to come up...''; sleep 1; done'

# perform wordpress install
wp core install --url=$WPCORE_URL --title="$WPCORE_TITLE" --admin_user="$WPCORE_ADMINUSER" --admin_password="$WPCORE_ADMINPASS" --admin_email="$WPCORE_ADMINEMAIL" --skip-email --allow-root

# enable nosnitor theme
wp theme activate nosnitor --allow-root

# configure permalinks
wp rewrite structure '/%year%/%monthnum%/%day%/%postname%/' --allow-root

# load default entrypoint
#docker-entrypoint.sh wp shell
