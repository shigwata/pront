FROM ruby:2

ENV PRONTO_ROOT /data
WORKDIR $PRONTO_ROOT

RUN apt-get update -y && apt-get install -y \
    cmake \
    php5

RUN gem install pronto && \
    gem install pronto-phpcs && \
    gem install pronto-phpmd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require \
    squizlabs/php_codesniffer \
    phpmd/phpmd

CMD [ "pronto", "run" ]
