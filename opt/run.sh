#!/bin/bash

# Generate nginx config
pystache /opt/nginx.conf.mustache \
    "{ \"domain\": \"$DIT4C_DOMAIN\" }" \
    > /etc/nginx/nginx.conf

nginx -t

# Start supervisord
exec supervisord -n
