FROM alpine

RUN apk add --update ruby ruby-json ruby-io-console ruby-bundler && rm -rf /var/cache/apk/*

# bundler does not want to install as root
RUN bundle config --global silence_root_warning 1

RUN mkdir -p /etc/sensu/sensu-cli

RUN adduser -h /app -D sensu

WORKDIR /app

USER sensu

ADD Gemfile .
RUN bundler install --binstubs --path vendor

VOLUME /etc/sensu/sensu-cli
