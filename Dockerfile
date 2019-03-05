FROM quay.io/spivegin/caddy_only AS caddy-source 

FROM quay.io/spivegin/tlmbasedebian
RUN mkdir /opt/bin
COPY --from=caddy-source /opt/bin/caddy /opt/bin/
WORKDIR /opt/tlm/html
# Installing Curl and OpenSSL
RUN apt-get update && apt-get install -y curl openssl wget &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
# Setting up Caddy Server and AFZ Cert
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates --verbose &&\
    chmod +x /opt/bin/caddy &&\
    ln -s /opt/bin/caddy /bin/caddy &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Install PHP 7
RUN apt-get update && apt-get install -y \
    gzip \
    php7 \
    php7.0-dom \
    php7.0-ctype \
    php7.0-curl \
    php7.0-fpm \
    php7.0-gd \
    php7.0-intl \
    php7.0-json \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-mysqli \
    php7.0-mysqlnd \
    php7.0-opcache \
    php7.0-pdo \
    php7.0-posix \
    php7.0-session \
    php7.0-xml \
    php7.0-iconv \
    php7.0-phar \
    php7.0-openssl \
    php7.0-zlib  &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN wget -qO- https://download.revive-adserver.com/revive-adserver-4.1.4.tar.gz | tar xz --strip 1 \
    && chown -R nobody:nobody . \
    && rm -rf /var/cache/apk/*


EXPOSE 80

# CMD php-fpm7 && nginx -g 'daemon off;'
