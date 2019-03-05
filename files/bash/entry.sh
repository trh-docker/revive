#!/usr/bin/dumb-init /bin/sh

php-cgi &
caddy -conf /opt/caddy/Caddyfile