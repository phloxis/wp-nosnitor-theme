#!/bin/bash

# sleep until wordpress is up
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' wordpress:80)" != "302" ]]; do echo ''Waiting for wordpress to come up...''; sleep 1; done'

# perform wordpress install
wp core install --url=http://localhost:8080 --title="My Blog" --admin_user=admin --admin_password=pass --admin_email=wp-admin@nosnitor.net --skip-email --allow-root

# enable nosnitor theme
wp theme activate nosnitor --allow-root

# load default entrypoint
#docker-entrypoint.sh wp shell
