FROM quay.io/spivegin/php7

# RUN wget -qO- https://download.revive-adserver.com/revive-adserver-4.1.4.tar.gz | tar xz --strip 1 
RUN git clone https://github.com/revive-adserver/revive-adserver.git . &&\
    cd plugins_repo  && sh package.sh -b &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD files/bash/entry.sh /opt/bin/
ADD files/php/ /etc/php/7.0/fpm/pool.d/
ADD files/Caddy/Caddyfile /opt/caddy/
RUN chmod +x /opt/bin/entry.sh &&\
    chmod -R a+w /opt/tlm/html/var &&\
    chmod -R a+w /opt/tlm/html/plugins &&\
    chmod -R a+w /opt/tlm/html/www/admin/plugins &&\
    chmod -R a+w /opt/tlm/html/www/images

ENV DOMAIN=0.0.0.0 \
    PORT=80
EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]