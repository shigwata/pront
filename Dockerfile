FROM ruby:2

ENV PRONTO_ROOT /data
ENV PRONTO_VERSION 0.9.5

WORKDIR $PRONTO_ROOT

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    cmake \
    php5 \
    && rm -rf /var/lib/apt/lists/*

RUN gem install pronto -v $PRONTO_VERSION --no-document && \
    gem install pronto-phpcs --no-document && \
    gem install pronto-phpmd --no-document

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require \
    squizlabs/php_codesniffer \
    phpmd/phpmd

CMD [ "pronto", "run" ]
