#!/bin/bash

# apply permissions
chown -R www-data:www-data /var/www/html
chmod -R a+rw /var/www/html/wp-content

# load default entrypoint
docker-entrypoint.sh apache2-foreground
