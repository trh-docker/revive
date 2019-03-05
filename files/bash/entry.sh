#!/usr/bin/dumb-init /bin/sh
caddy -conf /opt/caddy/Caddyfile &
/usr/bin/php-cgi7.0